-module('factorial').
-export([run/1]).

run(0) -> 1;
run(N) when N > 0 -> run(N-1) * N.
% run(N) when N < 0 -> 0.  %% let it fail
