-module(index).
-export([get_file_contents/1,show_file_contents/1, refine/1, count/1]).

% Used to read a file into a list of lines.
% Example files available in:
%   gettysburg-address.txt (short)
%   dickens-christmas.txt  (long)
  

% Get the contents of a text file into a list of lines.
% Each line has its trailing newline removed.

get_file_contents(Name) ->
    {ok,File} = file:open(Name,[read]),
    Rev = get_all_lines(File,[]),
    lists:reverse(Rev).

% Auxiliary function for get_file_contents.
% Not exported.

get_all_lines(File,Partial) ->
    case io:get_line(File,"") of
        eof -> file:close(File),
               Partial;
        Line -> {Strip,_} = lists:split(length(Line)-1,Line),
                get_all_lines(File,[Strip|Partial])
    end.

% Show the contents of a list of strings.
% Can be used to check the results of calling get_file_contents.

show_file_contents([L|Ls]) ->
    io:format("~s~n",[L]),
    show_file_contents(Ls);
show_file_contents([]) ->
    ok.    


% type Word = [Char]
% type Line [Word]
%
% 1 Refine contents.
%   - lower_case
%   - filter common words and too short words.
% 2 Count words
% 


% [[Char]] -> [[Char]]
remove_commons([]) -> [];
remove_commons([H|T]) ->
    case { lists:member(H, ["the", "not", "this", "that"])
         , length(H) < 3
         } of

         {false, false} -> [H|remove_commons(T)];
         {_, _} -> remove_commons(T)
    end.



% [Char] -> [[Char]]
split(String) ->
    case lists:splitwith(
            fun (C) -> (C >= $a) and (C =< $z) end,
            String) of
        {[], _} -> [];
        {Match, [_|Rest]} -> [Match|split(Rest)];
        {Match, _} -> [Match]
    end.

refine_line(String) ->
    remove_commons(split(string:lowercase(String))).
    

% [[Char]] -> [[Word]]
refine(Lines) ->
    lists:map(fun(S) -> refine_line(S) end, Lines).


% [[Word]] -> [[{Word, [{Int, Int}]}]]
zipWithIndex(Lines) ->
    {_, R} = lists:foldl(
        fun(Line, {Offset, Result}) ->
            O = Offset + 1,
            L = lists:map(fun(W) -> {W, [{O, O}]} end, Line),
            {O, [L|Result]}
        end,
        {0, []},
        Lines),
    R.


acc(I, []) ->
    [I];
acc({W1, [O1]}, [{W1, Os}|T]) -> 
    [{W1, [O1|Os]}|T];
acc(I, Acc) ->
    [I | Acc].


group(O, []) -> [O];
group({S1, E1}=O, [{S2, E2}|T]=Acc) ->
    if E1 + 1 == S2 -> [{S1, E2}| T];
        true -> [O|Acc]
    end.
    
count(Lines) ->
    Flatted = lists:flatten(zipWithIndex(Lines)),
    Sorted = lists:sort(fun({W1, _}, {W2, _}) ->  W1 > W2 end, Flatted),
    Grouped = lists:foldr(fun(I, Acc) -> acc(I, Acc) end, [], Sorted),
    lists:map(
        fun({W, O}) ->
            {W, lists:foldr(fun(I, Acc) -> group(I, Acc) end, [], O)}
        end, Grouped).
