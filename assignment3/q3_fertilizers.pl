% Enter the names of your group members below.
% If you only have 2 group members, leave the last space blank
%
%%%%%
%%%%% NAME: Arathi Vallipuranathan
%%%%% NAME: Micah Pascua
%%%%% NAME: Carole Youssef
%
% Add the required rules in the corresponding sections. 
% If you put the rules in the wrong sections, you will lose marks.
%
% You may add additional comments as you choose but DO NOT MODIFY the comment lines below
%

%%%%% SECTION: minAndMaxList
%%%%% Below, you should define rules for the predicate "minList(List, M)", 
%%%%% which takes in an input List and finds the minimal element there.
%%%%%
%%%%% You should also define rules for the predicate "maxList(List, M)", 
%%%%% which takes in an input List and finds the maximal element there.
%%%%%
%%%%% If you introduce any other helper predicates for implementing minList
%%%%% and maxList, they should be included in this section.

minList([H], H).
minList([H | T], M) :- minList(T, M1), H < M1, M = H.
minList([H | T], M) :- minList(T, M1), H >= M1, M = M1.

maxList([H], H).
maxList([H | T], M) :- maxList(T, M1), H > M1, M = H.
maxList([H | T], M) :- maxList(T, M1), H =< M1, M = M1.

%%%%% SECTION: fertilizersSolve
%%%%% Below, you should define rules for the predicate "solve", which takes in your list of
%%%%% variables and finds an assignment for each variable which solves the problem.
%%%%%
%%%%% You should also define rules for the predicate "solve_and_print" which calls your
%%%%% solve predicate and prints out the results in an easy to read, human readable format.
%%%%% The predicate "solve_and_print" should take in no arguments
%%%%%
%%%%% This section should also include your domain definitions and any other helper
%%%%% predicates (other than minList, maxList, and their helpers) that you choose to introduce.


% ORDER OF ARGUMENTS:
% First, I initalize all attributes for each plant with some distinct value. Each attribute is assigned values in their assign_attribute predicate.
% Within each of these predicates, I also includes conditions that are exclusive to that attribute (i.e. connected to only the plant number and not any other attribute).
% Then, I includes the conditions that are depend on 2 or more attributes.


all_diff([]).
all_diff([X | List]) :- not(member(X, List)), all_diff(List).

% define plants with variabels for each attribute
% plant(PlantNumber, Fertilizer, Height, Yield, Weight)
plant(1, F1, H1, Y1, W1).
plant(2, F2, H2, Y2, W3).
plant(3, F3, H3, Y3, W3).
plant(4, F4, H4, Y4, W4).
plant(5, F5, H5, Y5, W5).


assign_fertilizers([F1, F2, F3, F4, F5]) :-
    % assign distinct fertilizer to each plant and apply conditions exclusive to fertilizer
    Fertilizers = [bone_meal, compost, egg_shells, manure, seaweed],
    member(F3, Fertilizers), not(F3 = manure), not(F3 = seaweed), not(F3 = bone_meal), % condition 1 & 3 
    member(F4, Fertilizers), not(F4 = seaweed), not(F4 = bone_meal), % condition 3
    member(F5, Fertilizers), not(F5 = seaweed), not(F5 = bone_meal), % condition 3
    member(F1, Fertilizers), member(F2, Fertilizers), 
    all_diff([F1, F2, F3, F4, F5]).


assign_heights([H1, H2, H3, H4, H5]) :-
    % assign distinct height to each plant and apply conditions exclusive to height
    Heights = [1, 2, 4, 5, 7],
    member(H3, Heights), 
    member(H1, Heights), H1 is H3 + 1, % condition 7
    member(H5, Heights), H5 is H1 * 2, % condition 7
    member(H4, Heights), H4 > H3, % condition 2
    member(H2, Heights), H2 > H4, % condition 2
    all_diff([H1, H2, H3, H4, H5]).


assign_yields([Y1, Y2, Y3, Y4, Y5]) :-
    % assign distinct yield to each plant and apply conditions exclusive to yield
    Yields = [4, 6, 9, 12, 21],
    member(Y1, Yields),
    member(Y2, Yields),
    member(Y3, Yields),
    member(Y4, Yields),
    member(Y5, Yields),
    all_diff([Y1, Y2, Y3, Y4, Y5]).


assign_weights([W1, W2, W3, W4, W5]) :-
    % assign distinct weight to each plant and apply conditions exclusive to weight
    Weights = [3, 9, 10, 14, 19],
    maxList(Weights, MaxWeight),
    member(W5, Weights), not(W5 = MaxWeight), % condition 8 
    member(W2, Weights), member(W3, Weights), W3 > W2, % conditon 1
    member(W1, Weights),  member(W4, Weights),
    all_diff([W1, W2, W3, W4, W5]).


solve([plant(1, F1, H1, Y1, W1), plant(2, F2, H2, Y2, W2), plant(3, F3, H3, Y3, W3), plant(4, F4, H4, Y4, W4), plant(5, F5, H5, Y5, W5)]) :-
    assign_fertilizers([F1, F2, F3, F4, F5]),
    assign_heights([H1, H2, H3, H4, H5]),
    assign_yields([Y1, Y2, Y3, Y4, Y5]),
    assign_weights([W1, W2, W3, W4, W5]),

    % condition 1: manure-fertilized plant has heavier weight that 3rd plant
    member(plant(_, manure, _, _, WeightManure), 
           [plant(1, F1, H1, Y1, W1), 
            plant(2, F2, H2, Y2, W2), 
            plant(3, F3, H3, Y3, W3), 
            plant(4, F4, H4, Y4, W4), 
            plant(5, F5, H5, Y5, W5)]),
    W3 < WeightManure,

    % condition 4: tallest plant does not have most yield or heaviest weight
    maxList([H1, H2, H3, H4, H5], MaxHeight),
    maxList([Y1, Y2, Y3, Y4, Y5], MaxYield),
    maxList([W1, W2, W3, W4, W5], MaxWeight),

    member(plant(_, _, MaxHeight, YieldTallest, WeightTallest), 
           [plant(1, F1, H1, Y1, W1), 
            plant(2, F2, H2, Y2, W2), 
            plant(3, F3, H3, Y3, W3), 
            plant(4, F4, H4, Y4, W4), 
            plant(5, F5, H5, Y5, W5)]),
    not(YieldTallest is MaxYield), not(WeightTallest is MaxWeight),

    % condition 4: shortest plant does not have most yield or heaviest weight
    minList([H1, H2, H3, H4, H5], MinHeight),
    member(plant(_, _, MinHeight, YieldShortest, WeightShortest), 
           [plant(1, F1, H1, Y1, W1), 
            plant(2, F2, H2, Y2, W2), 
            plant(3, F3, H3, Y3, W3), 
            plant(4, F4, H4, Y4, W4), 
            plant(5, F5, H5, Y5, W5)]),
    not(YieldShortest is MaxYield), not(WeightShortest is MaxWeight),

    % condition 5: egg-shell-fertilized plant has half the yield of 1st plant and heaviest weight
    member(plant(_, egg_shells, _, YieldEgg, WeightEgg), 
           [plant(1, F1, H1, Y1, W1), 
            plant(2, F2, H2, Y2, W2), 
            plant(3, F3, H3, Y3, W3), 
            plant(4, F4, H4, Y4, W4), 
            plant(5, F5, H5, Y5, W5)]),
    YieldEgg is Y1 / 2, WeightEgg is MaxWeight,

    % condition 6: seawedd-fertilized plant is tallest and has least yield
    min_list([Y1, Y2, Y3, Y4, Y5], MinYield),
    member(plant(_, seaweed, HeightSeaweed, YieldSeaweed, _), 
           [plant(1, F1, H1, Y1, W1), 
            plant(2, F2, H2, Y2, W2), 
            plant(3, F3, H3, Y3, W3), 
            plant(4, F4, H4, Y4, W4), 
            plant(5, F5, H5, Y5, W5)]),
    HeightSeaweed is MaxHeight, YieldSeaweed is MinYield,

    % condition 6: bone-meal-fertilized plant has lightest weight
    min_list([W1, W2, W3, W4, W5], MinWeight),
    member(plant(_, bone_meal, _, _, WeightBone), 
           [plant(1, F1, H1, Y1, W1), 
            plant(2, F2, H2, Y2, W2), 
            plant(3, F3, H3, Y3, W3), 
            plant(4, F4, H4, Y4, W4), 
            plant(5, F5, H5, Y5, W5)]),
    WeightBone is MinWeight.


solve_and_print :-
    solve([plant(1, F1, H1, Y1, W1), 
        plant(2, F2, H2, Y2, W2), 
        plant(3, F3, H3, Y3, W3), 
        plant(4, F4, H4, Y4, W4), 
        plant(5, F5, H5, Y5, W5)]),

    % print each plant's attributes 
    write('Plant 1: Fertilizer = '), write(F1), write(', Height = '), write(H1), write(', Yield = '), write(Y1), write(', Weight = '), write(W1), nl,
    write('Plant 2: Fertilizer = '), write(F2), write(', Height = '), write(H2), write(', Yield = '), write(Y2), write(', Weight = '), write(W2), nl,
    write('Plant 3: Fertilizer = '), write(F3), write(', Height = '), write(H3), write(', Yield = '), write(Y3), write(', Weight = '), write(W3), nl,
    write('Plant 4: Fertilizer = '), write(F4), write(', Height = '), write(H4), write(', Yield = '), write(Y4), write(', Weight = '), write(W4), nl,
    write('Plant 5: Fertilizer = '), write(F5), write(', Height = '), write(H5), write(', Yield = '), write(Y5), write(', Weight = '), write(W5), nl.

cpu_time(Predicate) :-
    statistics(cputime, T1),  
    call(Predicate),          
    statistics(cputime, T2),  
    Time is T2 - T1,          
    write('CPU time:'), write(Time), write(' seconds').


% ['q3_fertilizers.pl'].
