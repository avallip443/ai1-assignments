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

% if lists are of equal length, the boolean EqualItems list is made and returned
equalEntries(List1, List2, EqualItems) :-
    length(List1, L1),
    length(List2, L2),
    L1 = L2,
    equalEntriesHelp(List1, List2, EqualItems).

% base case: List1 and List2 empty, so EqualItems will be emtpy too.
equalEntriesHelp([], [], []).

% recursive case: compare List1 head and List2 head
% if head elements are equal, put true in EqualItems list and recursively call for the rest of the lists (tails)
equalEntriesHelp([H1 | T1], [H2 | T2], [true | EqualItems]) :-
    H1 = H2,
    equalEntries(T1, T2, EqualItems).

% if head elements are not equal, put false in EqualItems list and recursively call for the rest of the lists (tails)
equalEntriesHelp([H1 | T1], [H2 | T2], [false | EqualItems]) :-
    not H1 = H2,
    equalEntries(T1, T2, EqualItems).


