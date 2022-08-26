%% Input dictionary:
word([a,d,d]).    word([a,d,o]).    word([a,g,e]).    word([a,g,o]).    word([a,i,d]).
word([a,i,l]).    word([a,i,m]).    word([a,i,r]).    word([a,n,d]).    word([a,n,y]).
word([a,p,e]).    word([a,p,t]).    word([a,r,c]).    word([a,r,e]).    word([a,r,k]).
word([a,r,m]).    word([a,r,t]).    word([a,s,h]).    word([a,s,k]).    word([a,u,k]).
word([a,w,e]).    word([a,w,l]).    word([a,y,e]).    word([b,a,d]).    word([b,a,g]).
word([b,a,n]).    word([b,a,t]).    word([b,e,e]).    word([b,o,a]).    word([e,a,r]).
word([e,e,l]).    word([e,f,t]).    word([f,a,r]).    word([f,a,t]).    word([f,i,t]).
word([l,e,e]).    word([o,a,f]).    word([r,a,t]).    word([t,a,r]).    word([t,i,e]).

%% Handy predicate to display the result list:
writelist([]).
writelist([H|T]) :- write(H), nl, writelist(T).

search([X11, X12, X13], [X21, X22, X23], [X31, X32, X33], [X11, X21, X31], [X12, X22, X32], [X13, X23, X33]) :- word([X11, X12, X13]), 
                                                                                                                word([X21, X22, X23]),  
                                                                                                                word([X31, X32, X33]),  
                                                                                                                word([X11, X21, X31]),
                                                                                                                word([X12, X22, X32]),
                                                                                                                word([X13, X23, X33]).


legal(_, Index) :- Index =< 3.
legal([NewlyAssigned|Rest], Index)  :-  I1 is Index - 3, 
    									I2 is I1 + 1,
            							I3 is I1 + 2,
                                        nth1(I1, Rest, W3),
                                        nth1(I2, Rest, W2),
                                        nth1(I3, Rest, W1),
                                        nth1(1, NewlyAssigned, L1), nth1(I1, W1, T1),
                                        nth1(2, NewlyAssigned, L2), nth1(I1, W2, T2),
                                        nth1(3, NewlyAssigned, L3), nth1(I1, W3, T3),
                                        L1 == T1,
                                        L2 == T2,
                                        L3 == T3.

transfer([], [Y|YS], YS, [Y], Y) :- word(Y).                                                     
transfer([X|XS], [Y|YS], YS, [Y,X|XS], Y) :- word(Y).                                                     

search(Result) :- search([], [_, _, _, _, _, _], Result, 1).

search(_, [], [], _).
search(Assigned, NotAssigned, [NewlyAssigned|Result], Index) :- transfer(Assigned, NotAssigned, NewNotAssigned, NewAssigned, NewlyAssigned), 
                                                                legal(NewAssigned, Index), 
    													        NewIndex is Index + 1,
                                                                search(NewAssigned, NewNotAssigned, Result, NewIndex).

/*

Using the provided dictionary, there is 2 matching result.

We guess the property on n is that it is pair because for any set of words working in the grid,
we can create another solution made with the transpose of the grid. 
However, it seems worth mentioning that in some cases, the transpose is equal to the original grid and therefore,
produces the same result. 
Thus, because Prolog doesn't accept duplicate answers, it is possible to get an odd number of results.

TESTING :

Question 1 : ?- search(Accross1, Accross2, Accross3, Down1, Down2, Down3).

Accross1 = [b, e, e],
Accross2 = [o, a, f],
Accross3 = [a, r, t],
Down1 = [b, o, a],
Down2 = [e, a, r],
Down3 = [e, f, t] ;
Accross1 = [b, o, a],
Accross2 = [e, a, r],
Accross3 = [e, f, t],
Down1 = [b, e, e],
Down2 = [o, a, f],
Down3 = [a, r, t] ;
false.

Question 2 : ?- search(R).

R = [[b, e, e], [o, a, f], [a, r, t], [b, o, a], [e, a, r], [e, f, t]] ;
R = [[b, o, a], [e, a, r], [e, f, t], [b, e, e], [o, a, f], [a, r, t]] ;
false.

*/