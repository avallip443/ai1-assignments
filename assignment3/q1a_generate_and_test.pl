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
% You may add additional comments as you choose but DO NOT MODIFY the comment lines below
%

%%%%% SECTION: puzzleGenerateAndTest
%%%%% Below, you should define rules for the predicate "solve", which takes in your list of
%%%%% variables and finds an assignment for each variable which solves the problem.
%%%%%
%%%%% You should also define rules for the predicate "solve_and_print" which calls your
%%%%% solve predicate and prints out the results in an easy to read, human readable format.
%%%%% The predicate "solve_and_print" should take in no arguments
%%%%% 
%%%%% This section should also include your domain definitions and any other helper
%%%%% predicates that you choose to introduce

% calling solve predicate and print out results
solve_and_print :-
    solve([J,E,T,A,X,L,O,V]),

    write("Value of J: "), write(J), nl,
    write("Value of E: "), write(E), nl,
    write("Value of T: "), write(T), nl,
    write("Value of A: "), write(A), nl,
    write("Value of X: "), write(X), nl,
    write("Value of L: "), write(L), nl,
    write("Value of O: "), write(O), nl,
    write("Value of V: "), write(V), nl, nl,

    write("Therefore: "), nl, nl,

    write("          "), write(J),   write(E),   write(T), nl,
    write("  *       "), write(" "), write(A),   write(X), nl,
    write("---------------"), nl,
    write(" +     "), write(A),   write(X),   write(L),   write(E), nl,
    write("        "), write(J),   write(E),   write(T),   write(" ."), nl,
    write("---------------"), nl,
    write("        "), write(L),   write(O),   write(V),   write(E), nl.


% defining each digit
digit(0). digit(1). digit(2). digit(3). digit(4). 
digit(5). digit(6). digit(7). digit(8). digit(9).

% checking that every digit is different
all_diff([]).
all_diff([H|T]) :- not(member(H,T)), all_diff(T).

% solve predicate - takes in a list of variables and finds an assignment for each variable 
solve([J,E,T,A,X,L,O,V]) :-

    digit(J), digit(E), digit(T), digit(A),
    digit(X), digit(L), digit(O), digit(V),

    J > 0, A > 0,
    E is (T*X) mod 10, C1 is (T*X) // 10,
    L is ((E*X) + C1) mod 10, C10 is ((E*X) + C1) // 10,
    X is ((J*X) + C10) mod 10, C100 is ((J*X) + C10) // 10,

    A is C100,

    T is (T*A) mod 10, C2 is (T*A) // 10,
    E is ((E*A) + C2) mod 10, C20 is ((E*A) + C2) // 10,

    J is ((J*A) + C20),

    V is (L+T) mod 10, C3 is (L+T) // 10,
    O is (X+E + C3) mod 10, C30 is (X+E + C3) // 10,

    L is (A+J + C30),

    all_diff([J,E,T,A,X,L,O,V]).


