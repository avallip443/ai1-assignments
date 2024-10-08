% Enter the names of your group members below.
% If you only have 2 group members, leave the last space blank
%
%%%%%
%%%%% NAME: Micah Pascua
%%%%% NAME: Carole Youssef
%%%%% NAME: Arathi Vallipuranathan
%
% Add the required rules in the corresponding sections. 
% If you put the rules in the wrong sections, you will lose marks.
%
% You may add additional comments as you choose but DO NOT MODIFY the already included comment lines below
%

%%%%% SECTION: listShift
%%%%% Put your rules for listShift and any helper predicates below

lengthOfList(nil, 0).
lengthOfList(next(Head, Tail), Len) :- 
    lengthOfList(Tail, TailLen), 
    Len is TailLen + 1.

appendList(nil, List, List).
appendList(next(Head, Tail1), List, next(Head, Tail2)) :- 
    appendList(Tail1, List, Tail2).


split(List, 0, nil, List).
split(next(Head, Tail), Shift, next(Head, Tail1), Remainder) :- 
    Shift2 is Shift - 1, 
    split(Tail, Shift2, Tail1, Remainder).

listShift(List, V, Result) :- 
    lengthOfList(List, Len), 
    Shift is V mod Len, 
    split(List, Shift, ShiftedElem, Remainder), 
    appendList(Remainder, ShiftedElem, Result).