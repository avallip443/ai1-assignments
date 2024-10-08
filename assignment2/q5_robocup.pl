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
%%%%% Below you can find the KB given in the assignment PDF. You may edit it as you wish for testing
%%%%% It will be ignored in the tests
%%%%% Do not put any part of the KB in the robocup section below. That section, should only
%%%%% have statements for the canPass, canScore, and any helper predicates needed for computing those
robot(r1).     robot(r2).     robot(r3).
robot(r4).     robot(r5).     robot(r6).
hasBall(r3).
pathClear(r1, net).    pathClear(r2, r1).    pathClear(r3, r2).
pathClear(r3, net).    pathClear(r3, r1).    pathClear(r3, r4).
pathClear(r4, net).    pathClear(r1, r5).    pathClear(r5, r6).

%%%%% SECTION: robocup
%%%%% Put your rules for canPass, canScore, and any helper predicates below

symmetricPath(R1, R2) :- robot(R1), robot(R2), pathClear(R1, R2).
symmetricPath(R1, R2) :- robot(R1), robot(R2), pathClear(R2, R1).

canPass(R1, R2, M, [R1, R2]) :- M >= 1, symmetricPath(R1, R2).   % direct pass
canPass(R1, R2, M, [R1 | T]) :- M >= 2, symmetricPath(R1, R), robot(R), NewM is M-1, canPass(R, R2, NewM, T), not(member(R1, T)).

canScore(R, M, [R, net]) :- M >= 1, hasBall(R), pathClear(R, net).  % R has ball and scores directly
canScore(R, M, Path) :- M >= 2, hasBall(S), NewM is M-1, canPass(S, R, NewM, PathToR), pathClear(R, net), append(PathToR, [net], Path).  % R doesn't have ball but scores directly

% ['q5_robocup.pl'].