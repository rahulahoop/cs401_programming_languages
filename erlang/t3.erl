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
  Y_String = string:strip(Y_In, right, $\n),

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
