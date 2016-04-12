-module(pi).
-export([monte/2]).

%N = iterations X = num actors.
monte(N, X) ->
    genActors(X, 0).


genActors(X, Y) ->
    when X > Y ->
      spawn(uniformGen:gen).
    genActors(X, Y+1).


%% monte carlo code from source in assignment. Take this and make it use actors.
%% Tally is N.
calc(Tally) ->
calc(Tally, 0, 0).

calc(0, Matches, Done) -> 4 * Matches / Done;

calc(Tally, Matches, Done) ->
X = random:uniform(), Y = random:uniform(),
calc (Tally – 1, if X*X + Y*Y Matches + 1; true -> Matches end, Done + 1).
