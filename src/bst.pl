
% Quicksort algorithm (for comparison purposes):
% qsort(+AList,-SortedList)

qsort([],[]).
qsort([H|T],R) :- getle(H,T,L1), getgt(H,T,L2), qsort(L1,Ls1), qsort(L2,Ls2), 
                  append(Ls1,[H],Li), append(Li,Ls2,R).

getle(_,[],[]).
getle(X,[H|T],[H|R]) :- X >= H, getle(X,T,R).
getle(X,[_|T],R) :- getle(X,T,R).

getgt(_,[],[]).
getgt(X,[H|T],[H|R]) :- X < H, getgt(X,T,R).
getgt(X,[_|T],R) :- getgt(X,T,R).

% A binary tree is either empty (nil) or a structure tree(V,L,R), with
% V a value and L and R binary trees.

% search_tree(+Element, +Tree, -Node)

search_tree(_,nil,nil).
search_tree(X,tree(X,L,R),tree(X,L,R)).
search_tree(X,tree(Y,_,R),T) :- X > Y, search_tree(X,R,T). 
search_tree(X,tree(Y,L,_),T) :- X < Y, search_tree(X,L,T). 

% insert_tree(+Element,+Tree,-NewTree)

insert_tree(X,nil,tree(X,nil,nil)).
insert_tree(X,tree(X,L,R),tree(X,L1,R)) :- insert_tree(X,L,L1).
insert_tree(X,tree(Y,L,R),tree(Y,T,R)) :- X < Y, insert_tree(X,L,T).
insert_tree(X,tree(Y,L,R),tree(Y,L,T)) :- X > Y, insert_tree(X,R,T).

% inorder(+Tree,-List)

inorder(nil,[]).
inorder(tree(X,L,R),Ls) :- inorder(L,Ls1), inorder(R,Ls2), 
                           append(Ls1,[X|Ls2],Ls). 

% sort(+AList, -SortedList)

% sort_tree/2 (main)
sort_tree(L,R) :- sort_tree(L,R,nil).  

% sort_tree/3 (workhorse)
sort_tree([],R,T) :- inorder(T,R).
sort_tree([X|Rest],R,T) :- insert_tree(X,T,T1), sort_tree(Rest,R,T1).

% The usual find_min(+T,-V) and find_max(+T,-V)

find_max(tree(V,_,nil),V).
find_max(tree(_,_,R),V1) :- find_max(R,V1).

find_min(tree(V,nil,_),V).
find_min(tree(_,L,_),V1) :- find_min(L,V1).

% Now for the most exotic operation: delete(+V,+T,-T1)

delete(_,nil,nil).
delete(V,tree(V,nil,R),R).
delete(V,tree(V,L,nil),L).
delete(V,tree(V,L,R),tree(M,L1,R)) :- find_max(L,M), delete(M,L,L1).
delete(V,tree(V1,L,R),tree(V1,L1,R)) :- V < V1, delete(V,L,L1).
delete(V,tree(V1,L,R),tree(V1,L,R1)) :- V > V1, delete(V,R,R1).
