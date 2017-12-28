-module(ex1).
-export([perimeter/1, bits/1]).

perimeter({circle, R}) -> 2 * math:pi() * R;
perimeter({triangle, R, H}) -> math:sqrt(R*R + H*H) + R + H;
perimeter({ractangle, W, H}) -> 2 * (W + H).

bits(0, S) -> S;
bits(N, S) -> bits(N div 2, S + N rem 2).

bits(N) -> bits(N, 0).
