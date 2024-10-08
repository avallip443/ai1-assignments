% Enter the names of your group members below.
% If you only have 2 group members, leave the last space blank
%
%%%%%
%%%%% NAME: Carole Youssef 
%%%%% NAME: Micah Pasuca
%%%%% NAME: Arathi Vallipuranathan
%
% Add the required rules in the corresponding sections. 
% If you put the rules in the wrong sections, you will lose marks.
%
% You may add additional comments as you choose but DO NOT MODIFY the already included comment lines below
%

%%%%% SECTION: equalEntries
%%%%% Put your rules for equalEntries below

% if lists are equal, EqualItemsHelp list is made and boolean list returned
equalEntries(List1, List2, EqualItems) :-
    length(List1, L1),
    length(List2, L2),
    L1 = L2,
    equalEntriesHelp(List1, List2, EqualItems).

% base case: List1 and List2 empty, so EqualItems will be emtpy too.
equalEntriesHelp([], [], []).

% recursive case: compare List1 head and List2 head
% if equal, put true in list
equalEntriesHelp([H1 | T1], [H2 | T2], [true | EqualItems]) :-
    H1 = H2,
    equalEntries(T1, T2, EqualItems).

% if false, put false in list
equalEntriesHelp([H1 | T1], [H2 | T2], [false | EqualItems]) :-
    H1 \= H2,
    equalEntries(T1, T2, EqualItems).


