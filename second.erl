-module(second).
-export([hypotenuse/2, perimeter/2, area/2]).

hypotenuse(A, B) ->
  math:sqrt(first:square(A) + first:square(B)).

perimeter(A, B) ->
  hypotenuse(A, B) + A + B.

% area of right-angeld triangle
area(A, B) ->
  A * B / 2.
