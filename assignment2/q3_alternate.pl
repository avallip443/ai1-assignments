% Enter the names of your group members below.
% If you only have 2 group members, leave the last space blank
%
%%%%%
%%%%% NAME: Carole Youssef
%%%%% NAME: Micah Pascua
%%%%% NAME: Arathi Vallipuranathan
%
% Add the required rules in the corresponding sections. 
% If you put the rules in the wrong sections, you will lose marks.
%
% You may add additional comments as you choose but DO NOT MODIFY the already included comment lines below
%

%%%%% SECTION: alternatePlusMinus
%%%%% Put your rules for alternatePlusMinus and any helper predicates below

% base case for main: if list empty, return 0
alternatePlusMinus([], 0).

% main predicate for alternating plus and minus 
alternatePlusMinus(List, Sum) :-
    alternatePlusMinusHelp(List, 0, TotalSum, add_first_two),
    Sum = TotalSum.

% helper predicate
% base case for predicate: when list empty return accumulated sum
alternatePlusMinusHelp([], Sum, Sum, add).

% recursive case: alternate between plus and minus of elements, starting with +
% must add first 2 elements, then alternate after that 

% Case 1: Add first element, then go to adding second element.
alternatePlusMinusHelp([H|T], Accumulator, Sum, add_first_two) :-
    AccSum is Accumulator + H,
    alternatePlusMinusHelp(T, AccSum, Sum, add_second).

% Case 2: Add second element, then move to subtracting next element.
alternatePlusMinusHelp([H|T], Accumulator, Sum, add_second) :-
    AccSum is Accumulator + H,
    alternatePlusMinusHelp(T, AccSum, Sum, subtract).

% Case 3 and 4: alternated between adding and subtracting the elements
alternatePlusMinusHelp([H|T] ,Accumulator, Sum, subtract) :-
    AccSum is Accumulator - H,
    alternatePlusMinusHelp(T ,AccSum, Sum, add). % will not subtract the next element, will switch to adding it 

alternatePlusMinusHelp([H|T] ,Accumulator, Sum, add) :-
    AccSum is Accumulator + H,
    alternatePlusMinusHelp(T ,AccSum, Sum, subtract). % will not add the next element, will switch to subtracting it 


