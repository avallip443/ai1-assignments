
% Enter the names of your group members below.
% If you only have 2 group members, leave the last space blank
%
%%%%%
%%%%% NAME: Arathi Vallipuranathan, 501168322
%%%%% NAME: Micah Pascua
%%%%% NAME: Carole Youssef
%
% Add the required rules in the corresponding sections. 
% If you put the rules in the wrong sections, you will lose marks.
%
% You may add additional comments as you choose but DO NOT MODIFY the already included comment lines below
%
%%%%% Below you can find the KB given in the assignment. You may edit it as you wish for testing
%%%%% It will be ignored in the tests
%%%%% However, the queries you give in part b should be tested on this original KB
robot(r1). robot(r2). robot(r3).
robot(r4). robot(r5). robot(r6).

hasBall(r3).

pathClear(r1, net).
pathClear(r2, r1).
pathClear(r3, r2).
pathClear(r3, net).
pathClear(r3, r1).
pathClear(r3, r4).
pathClear(r4, net).
pathClear(r1, r5).
pathClear(r5, r6).

%%%%% SECTION: q3_rules
%%%%% Put statements for canPass and canScore below. 
%%%%% You may also define helper predicates in this section
%%%%% DO NOT PUT ATOMIC FACTS for robot, hasBall, or pathClear below.

symmetricPath(R1, R2) :- robot(R1), robot(R2), pathClear(R1, R2).
symmetricPath(R1, R2) :- robot(R1), robot(R2), pathClear(R2, R1).

canPass(R1, R2, M) :- M >= 1, symmetricPath(R1, R2).
canPass(R1, R2, M) :- M >= 2, symmetricPath(R1, R), robot(R), canPass(R, R2, M-1).

canScore(R, M) :- M >= 1, hasBall(R), pathClear(R, net).  % R has ball and scores directly
canScore(R, M) :- M >= 2, hasBall(S), canPass(S, R, M-1), pathClear(R, net).  % R doesn't have ball but scores directly

%%%%% END
% DO NOT PUT ANY ATOMIC PROPOSITIONS OR LINES BELOW

% ['q3_robocup.pl'].