%---------------------------------------%
%        Rock Paper Scissors            %
%---------------------------------------%
% see https://www.futurelearn.com/courses/functional-programming-erlang/2/steps/187673

-module('rps').
-export([tournament/2]).

result(X, X) -> 0;

result(rock, scissors) -> 1;
result(scissors, paper) -> 1;
result(paper, rock) -> 1;

result(scissors, rock) -> -1;
result(paper, scissors) -> -1;
result(rock, paper) -> -1.


tournament([], _) -> 0;
tournament(_, []) -> 0;
tournament([X|Xs], [Y|Ys]) ->
	case result(X, Y) of
		0 -> tournament(Xs, Ys);
		1 -> 1;
		-1 -> -1
	end.




