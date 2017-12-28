-module(where1).
-export([take/2, nub/1]).

take(0,_Xs) ->
    [];
take(_N,[]) ->
    [];
take(N,[X|Xs]) when N>0 ->
    [X|take(N-1,Xs)].


% dumb way %
%indexOf(Item, List) ->
%  indexOf(0, Item, List).
%
%indexOf(_, _, []) -> -1;
%indexOf(N, I, [I|_T]) -> N;
%indexOf(N, I, [_H|T]) -> indexOf(N+1, I, T).
%
%
%nub(Xs) -> 
%  lists:reverse(nub(Xs, [])).
%
%nub([], Ys) -> Ys;
%nub([H|T], Ys) ->
%  case indexOf(H, Ys) > -1 of
%    true -> nub(T, Ys);
%    false -> nub(T, [H|Ys])
%  end.


nub([]) -> [];
nub([X|Xs]) ->
  [X|filter(Xs, X)].


filter([], _) -> [];
filter([H|T], H) -> filter(T, H);
filter([H|T], X) -> [H|filter(T, X)].


