-module(pi).
-export([calc/1, calc/3]).


%% monte carlo code from source in assignment. Take this and make it use actors.
calc(Tally) ->
calc(Tally, 0, 0).

calc(0, Matches, Done) -> 4 * Matches / Done;

calc(Tally, Matches, Done) ->
X = random:uniform(), Y = random:uniform(),
calc (Tally – 1, if X*X + Y*Y Matches + 1; true -> Matches end, Done + 1).
