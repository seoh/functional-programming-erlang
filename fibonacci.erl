-module('fibonacci').
-export([fibo/1]).

fibo(0) -> 0;
fibo(1) -> 1;
fibo(N) when N > 0 -> fibo(N-1) + fibo(N-2).
% rest case, let it fail.

