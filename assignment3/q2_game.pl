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

%%%%% SECTION: fourExactly
%%%%% Below, you should define rules for the predicate "fourExactly(X,List)", 
%%%%% which takes in an input List and checks whether there are exactly 4 
%%%%% occurrences of a given element X in the list.
%%%%%
%%%%% If you introduce any other helper predicates for implementing fourExactly,
%%%%% they should be included in this section.

fourExactly(X, List) :- 
    count(X, List, 4).

count(_, [], 0).
count(X, [X|T], N) :- 
    count(X, T, N1), 
    N is N1 + 1.

count(X, [Y|T], N) :- 
    X \= Y, 
    count(X, T, N).

%%%%% SECTION: gameSolve
%%%%% Below, you should define rules for the predicate "solve", which takes in your list of
%%%%% variables and finds an assignment for each variable which solves the problem.
%%%%%
%%%%% You should also define rules for the predicate "solve_and_print" which calls your
%%%%% solve predicate and prints out the results in an easy to read, human readable format.
%%%%% The predicate "solve_and_print" should take in no arguments
%%%%%solve_and_print :-
%%%%% This section should also include your domain definitions and any other helper
%%%%% predicates (other than fourExactly and its helpers) that you choose to introduce.

% Define the teams participating in the tournament
team(oakville).
team(pickering).
team(richmond_hill).
team(scarborough).
team(toronto).

% Define possible results for a match
result(w).  
result(l).  
result(d). 
result(n).  

solve(Tournament) :-
    % Define the structure of the tournament
    % Each round consists of two matches, each match has two teams and their results
    Tournament = [
        [[TeamA1, ResultA1, TeamB1, ResultB1],[TeamC1, ResultC1, TeamD1, ResultD1]], %round 1
        [[TeamA2, ResultA2, TeamB2, ResultB2],[TeamC2, ResultC2, TeamD2, ResultD2]], %round 2
        [[TeamA3, ResultA3, TeamB3, ResultB3],[TeamC3, ResultC3, TeamD3, ResultD3]], %round 3
        [[TeamA4, ResultA4, TeamB4, ResultB4],[TeamC4, ResultC4, TeamD4, ResultD4]], %round 4
        [[TeamA5, ResultA5, TeamB5, ResultB5],[TeamC5, ResultC5, TeamD5, ResultD5]] %round 5
    ],
    

    % Constraints
    % 1. Pickering lost to Scarborough in the first round, but won over Oakville in the second round
    TeamA1 = pickering, ResultA1 = l, TeamB1 = scarborough, ResultB1 = w,
    TeamA2 = pickering, ResultA2 = w, TeamB2 = oakville, ResultB2 = l,

    % 4. All matches in the fourth and in the fifth round finished with a draw.
    ResultA4 = d, ResultB4 = d, ResultC4 = d, ResultD4 = d,
    ResultA5 = d, ResultB5 = d, ResultC5 = d, ResultD5 = d,

    % validate results
    validate_results(Tournament),

    % 6. None of the matches in the first, second and third rounds finished with a draw
    first_three_no_draws(Tournament),   

    %validate teams (no one plays against themselves)
    validate_teams(Tournament),

    % 2. Toronto did not play in the third round; they had one win and one loss in the previous two rounds
    not TeamA3 = toronto, not TeamB3 = toronto, not TeamC3 = toronto, not TeamD3 = toronto, 
    tor_first_two_results(Tournament),

    % 3. Oakville did not participate in the fourth round, but they already won twice in the preceding three matches
    not TeamA4 = oakville, not TeamB4 = oakville, not TeamC4 = oakville, not TeamD4 = oakville,
    oak_first_three_results(Tournament, 2),

    % 5. Before the fourth round, Richmond Hill won only once and lost once
    rich_hill_results(Tournament, 1, 1),

    %each team plays exactly 4 times with 4 different teams
    diff_matches(Tournament).
    

%helpers

% checks if all results are valid
validate_results([]).
validate_results([Round|Rest]) :-
    validate_round_res(Round),
    validate_results(Rest).

validate_round_res([[_, Result1, _, Result2], [_, Result3, _, Result4]]) :-
    result(Result1), result(Result2), result(Result3), result(Result4),
    opposite_res(Result1, Result2),
    opposite_res(Result3, Result4).

opposite_res(w, l).
opposite_res(l, w).
opposite_res(d, d).

%first three rounds have no draws
first_three_no_draws([Round1, Round2, Round3|_]) :-
    no_draws(Round1),
    no_draws(Round2),
    no_draws(Round3).

no_draws([[_, Result1, _, Result2], [_, Result3, _, Result4]]) :-
    not Result1 = d, not Result2 = d, not Result3 = d, not Result4 = d.

%checks if all teams are valid (no team plays against themselves)
validate_teams([]).
validate_teams([Round|Rest]) :-
    validate_round_teams(Round),
    validate_teams(Rest).

validate_round_teams([[Team1, _, Team2, _], [Team3, _, Team4, _]]) :-
    team(Team1), team(Team2), team(Team3), team(Team4),
    not Team1 = Team2, not Team1 = Team3, not Team1 = Team4,
    not Team2 = Team3, not Team2 = Team4,
    not Team3 = Team4.

%Toronto had one win and one loss from the first two rounds
tor_first_two_results([Round1, Round2|_]) :-
    tor_round(Round1, Result1),
    tor_round(Round2, Result2),
    (Result1 = w, Result2 = l).

tor_first_two_results([Round1, Round2|_]) :-
    tor_round(Round1, Result1),
    tor_round(Round2, Result2),
    (Result1 = l, Result2 = w).

tor_round([[toronto, Result, _, _], _], Result).
tor_round([[_, _, toronto, Result], _], Result).
tor_round([_, [toronto, Result, _, _]], Result).
tor_round([_, [_, _, toronto, Result]], Result).

%Oakville won twice in the first three matches
oak_first_three_results([Round1, Round2, Round3|_], 2) :-
    oak_wins(Round1, Win1),
    oak_wins(Round2, Win2),
    oak_wins(Round3, Win3),
    Win1 + Win2 + Win3 =:= 2.

oak_wins([[oakville, w, _, _], _], 1).
oak_wins([[_, _, oakville, w], _], 1).
oak_wins([_, [oakville, w, _, _]], 1).
oak_wins([_, [_, _, oakville, w]], 1).
oak_wins(_, 0).

%checks if each team plays exactly 4 rounds with 4 different teams
diff_matches(Tournament) :-
    empty_match_list(Empty),
    tourn_process(Tournament, Empty, Final),
    all_matched(Final).

empty_match_list([
    [oakville, pickering, no],
    [oakville, richmond_hill, no],
    [oakville, scarborough, no],
    [oakville, toronto, no],
    [pickering, richmond_hill, no],
    [pickering, scarborough, no],
    [pickering, toronto, no],
    [richmond_hill, scarborough, no],
    [richmond_hill, toronto, no],
    [scarborough, toronto, no]
]).

tourn_process([], Matches, Matches).
tourn_process([Round|Rest], CurrentList, Final) :-
    process_round(Round, CurrentList, NextList),
    tourn_process(Rest, NextList, Final).

process_round([], Matches, Matches).
process_round([[Team1, _, Team2, _]|Rest], CurrentList, Final) :-
    update_matchup(Team1, Team2, CurrentList, NextList),
    process_round(Rest, NextList, Final).

update_matchup(Team1, Team2, [[Team1, Team2, _]|Rest], [[Team1, Team2, yes]|Rest]).
update_matchup(Team1, Team2, [[Team2, Team1, _]|Rest], [[Team2, Team1, yes]|Rest]).
update_matchup(Team1, Team2, [Match|Rest], [Match|UpdatedRest]) :-
update_matchup(Team1, Team2, Rest, UpdatedRest).

all_matched([]).
all_matched([[_, _, yes]|Rest]) :- all_matched(Rest).
nth1(1, [H|_], H).
    nth1(N, [_|T], X) :- N > 1, N1 is N - 1, nth1(N1, T, X).


%Richmond hill's results before the fourth round
rich_hill_results(Tournament, Wins, Losses) :-
    rich_hill_helper(Tournament, 0, 0, Wins, Losses, 3).

rich_hill_helper(_, Wins, Losses, Wins, Losses, 0). %base case

rich_hill_helper([Round|Rest], CurrWins, CurrLosses, Wins, Losses, RoundsLeft) :- %wins round
    rich_hill_round_res(Round, w),
    NextWins is CurrWins + 1,
    NextRoundsLeft is RoundsLeft - 1,
    rich_hill_helper(Rest, NextWins, CurrLosses, Wins, Losses, NextRoundsLeft).

rich_hill_helper([Round|Rest], CurrWins, CurrLosses, Wins, Losses, RoundsLeft) :- %loses round
    rich_hill_round_res(Round, l),
    NextLosses is CurrLosses + 1,
    NextRoundsLeft is RoundsLeft - 1,
    rich_hill_helper(Rest, CurrWins, NextLosses, Wins, Losses, NextRoundsLeft).

rich_hill_helper([Round|Rest], CurrWins, CurrLosses, Wins, Losses, RoundsLeft) :- %draws round
    rich_hill_round_res(Round, d),
    NextRoundsLeft is RoundsLeft - 1,
    rich_hill_helper(Rest, CurrWins, CurrLosses, Wins, Losses, NextRoundsLeft).

rich_hill_helper([Round|Rest], CurrWins, CurrLosses, Wins, Losses, RoundsLeft) :- %didn't play
    rich_hill_round_res(Round, n),
    NextRoundsLeft is RoundsLeft - 1,
    rich_hill_helper(Rest, CurrWins, CurrLosses, Wins, Losses, NextRoundsLeft).

rich_hill_round_res([[richmond_hill, Result, _, _], _], Result).
rich_hill_round_res([[_, _, richmond_hill, Result], _], Result).
rich_hill_round_res([_, [richmond_hill, Result, _, _]], Result).
rich_hill_round_res([_, [_, _, richmond_hill, Result]], Result).
rich_hill_round_res(_, n).


time_solve :-
    write('Starting solve...'), nl,
    statistics(runtime, [Start|_]),
    solve(Solution),
    statistics(runtime, [End|_]),
    ExecutionTime is (End - Start) / 1000,  
    write('Solve completed in '),
    write(ExecutionTime),
    write(' seconds.'), nl,
    write('Solution found:'), nl,
    print_tournament(Solution).

solve_and_print :-
    solve(Tournament),
    print_tournament(Tournament).

print_tournament([]).
print_tournament([Round|Rest]) :-
    write('Round: '), write(Round), nl,
    print_tournament(Rest).

