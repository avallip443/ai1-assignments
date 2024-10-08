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

%%%%% SECTION: nestedLists
%%%%% Put your rules for nestedFindDepth, nestedFindIndex, and any helper predicates below

%part a
nestedFindDepth([Item|Tail], Item, 0).

nestedFindDepth([Head|Tail], Item, Depth) :- 
    is_list(Head), 
    nestedFindDepth(Head, Item, SDepth), 
    Depth is SDepth + 1.


nestedFindDepth([Head|Tail], Item, Depth) :- 
    nestedFindDepth(Tail, Item, Depth).

nestedFindDepth([], Item, Depth) :- 
    false.

%part b

nestedFindIndex([Head|Tail], Item, Depth, Index) :-
    Head = Item,
    Depth is 0,
    Index is 0.

nestedFindIndex([Head|Tail], Item, Depth, Index) :- 
    nestedFindDepth(Head, Item, HeadDepth),
    Depth is HeadDepth + 1,
    Index is 0.

nestedFindIndex([Head|Tail], Item, Depth, Index) :-
    nestedFindIndex(Tail, Item, Depth, TailIndex),
    Index is TailIndex+1. 