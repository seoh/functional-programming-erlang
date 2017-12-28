-module('higherorder').
-export([doubleAll/1, evens/1, product/1,
	 zip/2, zip_with/3]).

doubleAll(Xs) -> lists:map(fun(X) -> X*2 end, Xs).

evens(Xs) -> lists:filter(fun(X) -> X rem 2 == 0 end, Xs).

product(Xs) -> lists:foldr(fun(X, Acc) -> X*Acc end, 1, Xs).

%% zip without zip_with
%zip(_, []) -> [];
%zip([], _) -> [];
%zip([X|Xs], [Y|Ys]) ->
%	[{X, Y}|zip(Xs, Ys)].

% zip_with wihtout zip
zip_with(_, [], _) -> [];
zip_with(_, _, []) -> [];
zip_with(F, [X|Xs], [Y|Ys]) ->
	[F(X, Y)|zip_with(F,Xs,Ys)].

% zip_with using zip/2
%zip_with(F, Xs, Ys) ->
%	lists:map(fun({X, Y}) -> F(X, Y) end, zip(Xs, Ys)).

zip(Xs, Ys) ->
	zip_with(fun(X, Y) -> {X,Y} end, Xs, Ys).
