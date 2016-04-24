%%%-------------------------------------------------------------------
%%% @author Daniel latham
%%% @copyright (C) 2016, Daniel Latham
%%% @doc
%%% Implement a two client version of a text based tic-tac-toe program. To this end develop a module t3
%%% that contains the following functions:
%%%
%%% – newgame() starts a new game node and waits for an opponent.
%%%
%%% – playwith(Opponent) connects to another Erlang node identiﬁed by Opponent and starts a new game.
%%%   If the Opponent does not exist, a call to playwith results in an error. When the game starts the two clients
%%%   randomly decide who starts the game.
%%%
%%% – placetoken(Coordinate) validates that Coordinate is a valid move and places a new token at ﬁeld Coordinate.
%%%   The move is also communicated to the opponent’s client. Coordinate is coordinate in the form of a1, . . ., c3.
%%%   When a winning position is reached or no more move is possible, the program announces the result on both clients
%%%   and the game terminates. If it is not a client’s turn, a call to placetoken prints an error message.
%%%   If there is no ongoing game, a call to placetoken may result in an error.
%%%
%%% – tell(Message) sends a message to the opponent. The message will be printed on the console.
%%%
%%% Hint: This site may give you some ideas: http://ninenines.eu/articles/tictactoe/
%%% Note: If the problem description is unclear, please use the Canvas forum to seek clariﬁcation.
%%% (20 points – extra credit) Extend the two client version so the game can be played in a distributed environment.
%%%
%%%TORUN:
%%% Open two terminals and connect to moat.cis.uab.edu
%%% You should see two vulcan machines
%%% Go to the directory where this file is saved
%%% Type below where YOURNAME and OTHERNAME are consistent
%%%   1$ erl -sname YOURNAME
%%%   2$ erl -sname OTHERNAME
%%% In both type the following
%%%   (YOURNAME@vulcanX)> c(t3).
%%%   (OTHERNAME@vulcanY)> c(t3).
%%% Next, start the game with player one(can be you or other, using you)
%%%   (YOURNAME@vulcanX)> t3:newgame().
%%% Connect to game from player two
%%%   (OTHERNAME@vulcanY)> t3:playwith(YOURNAME@vulcanX).
%%%
%%% @end
%%% Created : 16. Apr 2016 2:20 PM
%%%-------------------------------------------------------------------
-module(t3).


-export([newgame/0, newgame_2/0, playwith/1, new_board/0,
         check/1, homeClient/0, awayClient/0,
         print_board/1, print_board/2, move/4,
         user_input/2 ]).

%Start new game when you want someone to connect to YOU
newgame() ->
  io:fwrite("Newgame created for player 1~n"),
  My_PID = spawn(t3, homeClient, []),
  register(player1, My_PID),
  My_PID.

% Starts new game when you want to connect to someone
newgame_2() ->
  io:fwrite("Newgame created for player 2~n"),
  My_PID = spawn(t3, awayClient, []),
  register(player2, My_PID),
  My_PID.


homeClient() ->
  receive

    {connect, Opponent_PID} ->
      io:fwrite("'~p' connected to '~p'~n", [self(), Opponent_PID]),
      Opponent_PID ! {connected, self()},
      Opponent_PID ! {compare, self()};

    {sendacceptturn, Opponent_PID, Board} ->
      io:fwrite("Player1 sending accept turn request to Player 2..~n"),
      Opponent_PID ! {acceptturn, self(), Board, x};

    {sendstartgame, Opponent_PID} ->
      io:fwrite("Player1 sending  startgame to Player 2..~n"),
      Opponent_PID ! {startgame, self()};

    {startgame, Opponent_PID} ->
      io:fwrite("Player1 starting new game.. ~n"),

      Board = new_board(),
      Opponent_PID ! {sendacceptturn, self(), Board};

    {result, Result, Board} ->
      io:fwrite("~p~n", [Result]),
      print_board(Board),

      exit("Done..");

    {acceptturn, Opponent_PID, Board, Input} ->
      io:fwrite("Board: ~n"),
      print_board(Board),

      io:fwrite("My Letter: ~p~n", [Input]),
      New_Board = user_input(Input, Board),

      io:fwrite("Changed Board: ~n"),
      print_board(New_Board),
      Check = check(New_Board),

      if
        Check == {victory, x} ->
          io:fwrite("~p~n", [Check]),
          print_board(New_Board),
          Opponent_PID ! {result, Check, New_Board},
          exit("Done..");

        Check == {victory, o} ->
          io:fwrite("~p~n", [Check]),
          print_board(New_Board),
          Opponent_PID ! {result, Check, New_Board},
          exit("Done..");

        Check == draw ->
          io:fwrite("~p~n", [Check]),
          print_board(New_Board),
          Opponent_PID ! {result, Check, New_Board},
          exit("Done..");

        true ->
          io:fwrite("~p~n", [Check]),

          if
            Input == x ->
              Opponent_PID ! {acceptturn, self(), New_Board, o};

            true ->
              Opponent_PID ! {acceptturn, self(), New_Board, x}

          end
      end

  end,
  homeClient().

awayClient() ->
  receive

    {connected, Opponent_PID} ->
      io:fwrite("'~p' connected to '~p'~n", [self(), Opponent_PID]);

    {compare, Opponent_PID} ->
      % random numbers decide who starts game and is X
      random:seed(now()),
      My_Seed = random:uniform(),
      Other_Seed = random:uniform(),

      if
        My_Seed >= Other_Seed ->
          io:fwrite("'~p' >= '~p'; Player2 begins game...~n", [My_Seed, Other_Seed]),
          Opponent_PID ! {sendstartgame, self()};

        My_Seed < Other_Seed ->
          io:fwrite("'~p' < '~p'; Player1 begins game...~n", [My_Seed, Other_Seed]),
          Opponent_PID ! {startgame, self()};

        true ->
          ok

      end;

    {sendacceptturn, Opponent_PID, Board} ->
      io:fwrite("Player2 sending  acceptturn to Player 1..~n"),
      Opponent_PID ! {acceptturn, self(), Board,  x};

    {startgame, Opponent_PID} ->
      io:fwrite("Player2 starting new game.. ~n"),
      Board = new_board(),
      Opponent_PID ! {sendacceptturn, self(), Board};

    {result, Result, Board} ->
      io:fwrite("~p~n", [Result]),
      print_board(Board),

      exit("Done..");

    {acceptturn, Opponent_PID, Board, Input} ->
      io:fwrite("Board: ~n"),
      print_board(Board),

      io:fwrite("My Letter: ~p~n", [Input]),
      New_Board = user_input(Input, Board),

      io:fwrite("Changed Board: ~n"),
      print_board(New_Board),
      Check = check(New_Board),

      if
        Check == {victory, x} ->
          io:fwrite("~p~n", [Check]),
          print_board(New_Board),
          Opponent_PID ! {result, Check, New_Board},
          exit("Done..");

        Check == {victory, o} ->
          io:fwrite("~p~n", [Check]),
          print_board(New_Board),
          Opponent_PID ! {result, Check, New_Board},
          exit("Done..");

        Check == draw ->
          io:fwrite("~p~n", [Check]),
          print_board(New_Board),
          Opponent_PID ! {result, Check, New_Board},
          exit("Done..");

        true ->
          io:fwrite("~p~n", [Check]),
          if
            Input == x ->
              Opponent_PID ! {acceptturn, self(), New_Board, o};
            true ->
              Opponent_PID ! {acceptturn, self(), New_Board, x}
          end
      end

  end,
  awayClient().

user_input(Input, Board) ->
  X_In = io:get_line("Enter X Coord [1, 3]: "),
  Y_In = io:get_line("Enter Y Coord [1, 3]: "),

  % Turn X and Y into Strings then into Ints
  X_String = string:strip(X_In, right, $\n),
  Y_String = string:strip(Y_C_S, right, $\n),

  X_To_Int = list_to_integer(X_String),
  Y_To_Int = list_to_integer(Y_String),

  %Check if move is inside board deminsion
  Comp_X1 = X_To_Int > 3,
  Comp_X2 = X_To_Int < 1,
  Comp_Y1 = Y_To_Int > 3,
  Comp_Y2 = Y_To_Int < 1,

  if
    Comp_X1 or Comp_X2 ->
      io:fwrite("Incorrect X coord: must be between [1, 3] inclusive~n"),
      user_input(Input, Board);

    Comp_Y1 or Comp_Y2 ->
      io:fwrite("Incorrect Y coord: must be between [1, 3] inclusive~n"),
      user_input(Input, Board);

    true ->
      io:fwrite("New move sent to place (~p, ~p)~n", [X_To_Int, Y_To_Int]),
      New_Board = move(Input, X_To_Int, Y_To_Int, Board),
      New_Board
  end.

print_board(Board) ->
  print_board(Board, 1).

print_board(Board, Index) ->
  if
    Index < 10 ->
      L = element(Index, Board);

    true ->
      L = undefined

  end,

  New_Index = Index + 1,
  case Index of
    1 ->
      io:fwrite("#############~n"),
      io:fwrite("#  ~p ", [L]),
      print_board(Board, New_Index);

    2 ->
      io:fwrite(" ~p ", [L]),
      print_board(Board, New_Index);

    3 ->
      io:fwrite(" ~p  #~n", [L]),
      print_board(Board, New_Index);

    4 ->
      io:fwrite("#  ~p ", [L]),
      print_board(Board, New_Index);

    5 ->
      io:fwrite(" ~p ", [L]),
      print_board(Board, New_Index);

    6 ->
      io:fwrite(" ~p  #~n", [L]),
      print_board(Board, New_Index);

    7 ->
      io:fwrite("#  ~p ", [L]),
      print_board(Board, New_Index);

    8 ->
      io:fwrite(" ~p ", [L]),
      print_board(Board, New_Index);

    9 ->
      io:fwrite(" ~p  #~n", [L]),
      io:fwrite("#############~n"),
      print_board(Board, New_Index);

    _ ->
      ok
      
  end.


playwith(Other_Game_Node)->
  My_PID = newgame_2(),
  {player1, Other_Game_Node} ! {connect, My_PID}.

new_board() ->
  {l, l, l,
    l, l, l,
    l, l, l}.

move(Who, X, Y, Board) ->
  setelement((Y - 1) * 3 + X, Board, Who).

check(Board) ->
  case Board of
    {x, x, x,
      _, _, _,
      _, _, _} -> {victory, x};

    {_, _, _,
      x, x, x,
      _, _, _} -> {victory, x};

    {_, _, _,
      _, _, _,
      x, x, x} -> {victory, x};

    {x, _, _,
      x, _, _,
      x, _, _} -> {victory, x};

    {_, x, _,
      _, x, _,
      _, x, _} -> {victory, x};

    {_, _, x,
      _, _, x,
      _, _, x} -> {victory, x};

    {x, _, _,
      _, x, _,
      _, _, x} -> {victory, x};

    {_, _, x,
      _, x, _,
      x, _, _} -> {victory, x};

    {o, o, o,
      _, _, _,
      _, _, _} -> {victory, o};

    {_, _, _,
      o, o, o,
      _, _, _} -> {victory, o};

    {_, _, _,
      _, _, _,
      o, o, o} -> {victory, o};

    {o, _, _,
      o, _, _,
      o, _, _} -> {victory, o};

    {_, o, _,
      _, o, _,
      _, o, _} -> {victory, o};

    {_, _, o,
      _, _, o,
      _, _, o} -> {victory, o};

    {o, _, _,
      _, o, _,
      _, _, o} -> {victory, o};

    {_, _, o,
      _, o, _,
      o, _, _} -> {victory, o};

    {A, B, C,
      D, E, F,
      G, H, I} when A =/= l, B =/= l, C =/= l,
      D =/= l, E =/= l, F =/= l,
      G =/= l, H =/= l, I =/= l ->
      draw;

    _ -> ok
  end.
