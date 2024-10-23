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
    unique_matchups(Tournament).
    



%helpers

% all results in the tournament are valid
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

% No draws in the first three rounds
first_three_no_draws([Round1, Round2, Round3|_]) :-
    no_draws(Round1),
    no_draws(Round2),
    no_draws(Round3).

no_draws([[_, Result1, _, Result2], [_, Result3, _, Result4]]) :-
    not Result1 = d, not Result2 = d, not Result3 = d, not Result4 = d.

% All teams in the tournament are valid
validate_teams([]).
validate_teams([Round|Rest]) :-
    validate_round_teams(Round),
    validate_teams(Rest).

% Check if teams in a round are valid and not playing against themselves
validate_round_teams([[Team1, _, Team2, _], [Team3, _, Team4, _]]) :-
    team(Team1), team(Team2), team(Team3), team(Team4),
    not Team1 = Team2, not Team1 = Team3, not Team1 = Team4,
    not Team2 = Team3, not Team2 = Team4,
    not Team3 = Team4.

% Check Toronto's results in the first two rounds
tor_first_two_results([Round1, Round2|_]) :-
    tor_round(Round1, Result1),
    tor_round(Round2, Result2),
    (Result1 = w, Result2 = l).

tor_first_two_results([Round1, Round2|_]) :-
    tor_round(Round1, Result1),
    tor_round(Round2, Result2),
    (Result1 = l, Result2 = w).

% Find Toronto's result in a given round
tor_round([[toronto, Result, _, _], _], Result).
tor_round([[_, _, toronto, Result], _], Result).
tor_round([_, [toronto, Result, _, _]], Result).
tor_round([_, [_, _, toronto, Result]], Result).

% Check Oakville's wins in the first three rounds
oak_first_three_results([Round1, Round2, Round3|_], 2) :-
    oak_wins(Round1, Win1),
    oak_wins(Round2, Win2),
    oak_wins(Round3, Win3),
    Win1 + Win2 + Win3 =:= 2.

% Check if Oakville won in a given round
oak_wins([[oakville, w, _, _], _], 1).
oak_wins([[_, _, oakville, w], _], 1).
oak_wins([_, [oakville, w, _, _]], 1).
oak_wins([_, [_, _, oakville, w]], 1).
oak_wins(_, 0).

% All teams plays once with each other
unique_matchups(Tournament) :-
    empty_matchup_list(Empty),
    process_tournament(Tournament, Empty, Final),
    all_teams_matched(Final).

% Initialize an empty matchup list
empty_matchup_list([
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

% Process the tournament to check for unique matchups
process_tournament([], Matches, Matches).
process_tournament([Round|Rest], CurrentList, Final) :-
    process_round(Round, CurrentList, NextList),
    process_tournament(Rest, NextList, Final).

% Process a round to update matchups
process_round([], Matches, Matches).
process_round([[Team1, _, Team2, _]|Rest], CurrentList, Final) :-
    update_matchup(Team1, Team2, CurrentList, NextList),
    process_round(Rest, NextList, Final).

% Update the matchup list
update_matchup(Team1, Team2, [[Team1, Team2, _]|Rest], [[Team1, Team2, yes]|Rest]).
update_matchup(Team1, Team2, [[Team2, Team1, _]|Rest], [[Team2, Team1, yes]|Rest]).
update_matchup(Team1, Team2, [Match|Rest], [Match|UpdatedRest]) :-
update_matchup(Team1, Team2, Rest, UpdatedRest).

% Check if all teams have been matched
all_teams_matched([]).
all_teams_matched([[_, _, yes]|Rest]) :- all_teams_matched(Rest).
nth1(1, [H|_], H).
    nth1(N, [_|T], X) :- N > 1, N1 is N - 1, nth1(N1, T, X).


% Check Richmond Hill's record before the fourth round
rich_hill_results(Tournament, Wins, Losses) :-
    rich_hill_helper(Tournament, 0, 0, Wins, Losses, 3).

% Base case: when we've checked all rounds we care about
rich_hill_helper(_, Wins, Losses, Wins, Losses, 0).

% Recursive case: Richmond Hill won this round
rich_hill_helper([Round|Rest], CurrWins, CurrLosses, Wins, Losses, RoundsLeft) :-
    rich_hill_round_res(Round, w),
    NextWins is CurrWins + 1,
    NextRoundsLeft is RoundsLeft - 1,
    rich_hill_helper(Rest, NextWins, CurrLosses, Wins, Losses, NextRoundsLeft).

% Recursive case: Richmond Hill lost this round
rich_hill_helper([Round|Rest], CurrWins, CurrLosses, Wins, Losses, RoundsLeft) :-
    rich_hill_round_res(Round, l),
    NextLosses is CurrLosses + 1,
    NextRoundsLeft is RoundsLeft - 1,
    rich_hill_helper(Rest, CurrWins, NextLosses, Wins, Losses, NextRoundsLeft).

% Recursive case: Richmond Hill drew this round
rich_hill_helper([Round|Rest], CurrWins, CurrLosses, Wins, Losses, RoundsLeft) :-
    rich_hill_round_res(Round, d),
    NextRoundsLeft is RoundsLeft - 1,
    rich_hill_helper(Rest, CurrWins, CurrLosses, Wins, Losses, NextRoundsLeft).

% Recursive case: Richmond Hill didn't play this round
rich_hill_helper([Round|Rest], CurrWins, CurrLosses, Wins, Losses, RoundsLeft) :-
    rich_hill_round_res(Round, n),
    NextRoundsLeft is RoundsLeft - 1,
    rich_hill_helper(Rest, CurrWins, CurrLosses, Wins, Losses, NextRoundsLeft).

% Find Richmond Hill's result in a given round
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
