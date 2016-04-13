-module(pi).
-compile(export_all).
-export([calc/1, calc/3]).

%% monte carlo code from source in assignment. Take this and make it use actors.
%% Tally is N.
monte(N, X) ->
  Matches = [],
  Tries = .



%if we calculate a bunch of random numbers less than 1 and put them into a list
%and then sum the list into one number
%put that list in Match in the function 4 * matchs / done;
%this will calculate pi.
calc(Tally) ->
  calc(Tally, 0, 0).

calc(Tally, Matches, Done) ->
  X = random:uniform(), Y = random:uniform(),
  calc (Tally – 1, if X*X + Y*Y Matches + 1; true -> Matches end, Done + 1).

calc(0, Matches, Done) -> 4 * Matches / Done;

gen() ->
  recieve
    rand ->
      X = random:uniform(),
      Y = random:uniform(),
      if X * X + Y * Y  < 1 -> 1;
      true -> 0;
      end.
  end
