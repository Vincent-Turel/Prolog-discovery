% The board size is given by the predicate size/1

size(4).

% The position of the Knight is represented by the structure -(X,Y)
% (or X-Y), where X and Y are the coordinates of the square where the
% Knight is located.  We represent a move by the position it
% generates.  We use, again, the generate and test technique:
move(A,B,B) :- move_attempt(A,B), inside(B).

% There are 8 possible moves in the middle of the board:
move_attempt(I-J, K-L) :- K is I+1, L is J-2.
move_attempt(I-J, K-L) :- K is I+1, L is J+2.
move_attempt(I-J, K-L) :- K is I+2, L is J+1.
move_attempt(I-J, K-L) :- K is I+2, L is J-1.
move_attempt(I-J, K-L) :- K is I-1, L is J+2.
move_attempt(I-J, K-L) :- K is I-1, L is J-2.
move_attempt(I-J, K-L) :- K is I-2, L is J+1.
move_attempt(I-J, K-L) :- K is I-2, L is J-1.

% However, if the Knight is somwhere close to board's
% margins, some moves might fall out of the board...
inside(A-B) :- size(Max), A > 0, A =< Max, B > 0, B =< Max.

search(Initial,Final,Result) :-
    search(Initial,Final,[Initial],Result).

search(Final, Final, _, []).
search(Crt, Final, Visited, [M|Result]) :-
    move(Crt, AState, M),         % generate
    not(member(AState, Visited)), % test
    search(AState,Final, [AState|Visited], Result).

search_shorter(S,D,N,Result) :-
    search(S,D,Result),         % generate
    length(Result,L), L =< N.   % test

writelist([]) :- write('[]'),nl.
writelist([H|T]) :- write('['),writeseq([H|T]),write(']'),nl.

writeseq([H]) :- write(H),!.
writeseq([H|T]) :- write(H),write(','),writeseq(T).

writelist1([]).
writelist1([H|T]) :- write(H), nl, writelist1(T).
