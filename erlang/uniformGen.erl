-module(uniformGen).
-export([gen/0]).

gen() ->
  receive
    x ->
      X0 = random:uniform()
    y ->
      Y0 = random:uniform()
    end.
