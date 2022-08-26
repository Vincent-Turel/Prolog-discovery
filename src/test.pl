animal(X) :- dog(X).
feeds(X, Y) :- person(X), animal(Y).
happy(X) :- animal(X), feeds(_, X).
happy(X) :- dog(X), pets(_, X).
dog(fido).
person(mary).
pets(mary, fido).

dnot(0,1). dnot(1,0).
dand(0,0,0). dand(0,1,0). dand(1,0,0). dand(1,1,1).
dor(0,0,0). dor(0,1,1). dor(1,0,1). dor(1,1,1).
dxor(0,0,0). dxor(0,1,1). dxor(1,0,1). dxor(1,1,0).

dnor(X, Y, Z, S) :- dor(X, Y, S1), dnor(S1, Z, S2), dor(S2, S). 
 