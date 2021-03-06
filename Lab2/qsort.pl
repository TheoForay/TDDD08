%part(P, List, L, R) - create the partition of List 
%into two lists:
%L with the elements of List less or equal than P
%R with the elements of List greater than P
part(_, [], [], []).
part(P, [H|T], [H|L], R) :- P >= H, part(P, T, L, R).
part(P, [H|T], L, [H|R]) :- H > P, part(P, T, L, R).

%qsort(L,Ls) - Sorts L with a Quick Sort and Ls 
%is this sorted list.
qsort([], []).
qsort([H|T],S):-part(H,T,L,R),
		qsort(L,S1),
		qsort(R,S2),
		append(S1,[H|S2],S).

%qsort([1,0,9,3,7], X). X = [0,1,3,7,9]
