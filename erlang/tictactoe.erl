-module(tictactoe).
-compile(export_all).


newGame() ->
  {undefined, undefined, undefined,
   undefined, undefined, undefined,
   undefined, undefined, undefined}.

move(Who, X, Y, Board) ->
  setelement((Y-1) * 3 + X, Board, Who).

check(Board) ->
  case Board of
     {x, x, x,
      _, _, _,
      _, _, _} -> {victory, x};

     {x, _, _,
      _, x, _,
      _, _, x} -> {victory, x};

     {x, _, _,
      x, _, _,
      x, _, _} -> {victory, x};

      {o, o, o,
       _, _, _,
       _, _, _} -> {victory, o};

      {o, _, _,
       _, o, _,
       _, _, o} -> {victory, o};

      {o, _, _,
       o, _, _,
       o, _, _} -> {victory, o};

     _ -> ok
 end.
