% A state in the problem is represented by a list 
% [Boat,Cabbage,Goat,Wolf], in which the four variables can 
% take the values "north" or "south."

% the call would be: 
% :- search([north,north,north,north], [south,south,south,south], R), write(R), fail.

% Moving around

% first, attempt to move the cabbage: 
raw_move([B,B,G,W],[B1,B1,G,W], moved(cabbage,B,B1)) :- opposite(B,B1).

% then, the goat: 
raw_move([G,B,G,W],[G1,B,G1,W], moved(goat,G,G1)) :- opposite(G,G1).

% or the wolf: 
raw_move([W,B,G,W],[W1,B,G,W1], moved(wolf,W,W1)) :- opposite(W,W1).

%... eventually, move the empty boat: 
raw_move([X,C,G,W],[Y,C,G,W], moved(nothing,X,Y)) :- opposite(X,Y).

% the two shores are opposite:
opposite(south,north).
opposite(north,south).

% Legal states:
legal(State) :- not(conflict(State)).

% we cannot allow the cabbage and the goat on the same shore unsupervised...
conflict([B,C,G,_]) :- C==G, opposite(C,B).

% ... nor the goat and the wolf...
conflict([B,_,G,W]) :- W==G, opposite(W,B).
% ... but anything else is fine. 

% An actual move:
move(S1, S2, Move) :- raw_move(S1, S2, Move), legal(S2).

% The usual search predicate:
search(Initial,Final,Result) :- search(Initial,Final,[Initial],Result).
search(Final,Final,_,[]).
search(Crt,Final,Visited,[M|Result]) :-
    move(Crt,AState,M), not(member(AState,Visited)),
    search(AState,Final,[AState|Visited], Result).

/* 

The answer is: 

  ?- search([north,north,north,north], [south,south,south,south], R).
  
  R = [moved(goat,north,south), moved(nothing,south,north), moved(wolf,north,south),
       moved(goat,south,north), moved(cabbage,north,south), moved(nothing,south,north),
       moved(goat,north,south)] ;
  
  R = [moved(goat,north,south), moved(nothing,south,north), moved(cabbage,north,south),
       moved(goat,south,north), moved(wolf,north,south), moved(nothing,south,north),
       moved(goat,north,south)] ;
  
  no

(The output has been edited for clarity)

*/
