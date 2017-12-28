-module(list).
-export([sum/1, max/1, double/1, evens/1, median/1 ]).

% sum([])     -> 0;
% sum([X|Xs]) -> X + sum(Xs).

sum(Xs) -> sum(Xs, 0).

sum([], S)     -> S;
sum([X|Xs], S) -> sum(Xs, X+S).



compare(A, B) ->
  if
    A > B -> A;
    true  -> B
  end.

max(Xs) -> max(Xs, 0).

max([], M)     -> M;
max([X|Xs], M) -> max(Xs, compare(X, M)).



double([])     -> [];
double([X|Xs]) -> [X*2|double(Xs)].


evens([])      -> [];
evens([X|Xs]) when X rem 2 == 0 -> [X|evens(Xs)];
evens([_X|Xs]) -> evens(Xs).



median([]) -> 0;
median(Xs) ->
  case length(Xs) rem 2 of
    1 -> 
      hd(drop(Xs, length(Xs) div 2));
    0 -> 
      [M|Ms] = drop(Xs, length(Xs) div 2 - 1),
      (M + hd(Ms)) / 2
  end.

drop([], _)      -> [];
drop(Xs, 0)      -> Xs;
drop([_X|Xs], N) -> drop(Xs, N-1).



