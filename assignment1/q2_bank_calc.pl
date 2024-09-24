
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

%%%%% SECTION: q2_kb
%%%%% You should put the atomic statements in your KB below in this section
hasAccount(john, cibc, 500).
hasAccount(jane, cibc, 1000).
hasAccount(john, bmo, 1200).
hasAccount(jane, bmo, 2000).

totalDeposits(john, cibc, 400).
totalDeposits(jane, cibc, 700).
totalDeposits(john, bmo, 200).
totalDeposits(jane, bmo, 300).

totalWithdrawals(john, cibc, 1000).
totalWithdrawals(jane, cibc, 200).
totalWithdrawals(john, bmo, 100).
totalWithdrawals(jane, bmo, 150).

monthlyRate(cibc, 0.005).
monthlyRate(bmo, 0.003).

interestLevel(cibc, 1000).
interestLevel(bmo, 1500).

penalty(cibc, 20).
penalty(bmo, 50).

%%%%% SECTION: q2_rules
%%%%% Put statements for subtotal, accruedInterest, accruedPenalty, and endOfMonthBalance below.
%%%%% You may also put helper predicates here
%%%%% DO NOT PUT ATOMIC FACTS FOR hasAccount, totalDeposits, totalWithdrawals, monthlyRate, interestRate, or penalty below.

%subtotal
subtotal(Name, Bank, Subtotal) :-
    hasAccount(Name, Bank, Balance),
    totalDeposits(Name, Bank, Deposits),
    totalWithdrawals(Name, Bank, Withdrawals),
    Subtotal is Balance + Deposits - Withdrawals.

%accruedInterest
accruedInterest(Name, Bank, I) :-
    subtotal(Name, Bank, Subtotal),
    interestLevel(Bank, MinLevel),
    monthlyRate(Bank, Rate),
    Subtotal >= MinLevel,
    I is Rate * Subtotal.

accruedInterest(Name, Bank, I) :-
    subtotal(Name, Bank, Subtotal),
    interestLevel(Bank, MinLevel),
    Subtotal < MinLevel,
    I is 0.

%accruedPenalty
accruedPenalty(Name, Bank, P) :-
    subtotal(Name, Bank, Subtotal),
    penalty(Bank, PenaltyAmount),
    Subtotal < 0,
    P is PenaltyAmount.

accruedPenalty(Name, Bank, P) :-
    subtotal(Name, Bank, Subtotal),
    Subtotal >= 0,
    P is 0.

%endOfMonthBalance for given bank
endOfMonthBalance(Name, Bank, Balance) :-
    subtotal(Name, Bank, Subtotal),
    accruedInterest(Name, Bank, I),
    accruedPenalty(Name, Bank, P),
    Balance is Subtotal + I - P.

%endOfMonthBalance for all banks
endOfMonthBalance(Name, Balance) :-
    endOfMonthBalance(Name, cibc, BalanceC),
    endOfMonthBalance(Name, bmo, BalanceB),
    Balance is BalanceC + BalanceB.  

%%%%% END
% DO NOT PUT ANY ATOMIC PROPOSITIONS OR LINES BELOW
