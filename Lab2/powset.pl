%powset(S,L) - Returns a subset of S into L
powset([], []).
powset([H|T], [H|L]) :- powset(T,L).
powset([H|T], L) :- powset(T,L).

%powerset(S,R) - Returns all subsets of S into a R
powerset(S, R) :- findall(X, powset(S,X), R).

%powerset([a,b,c], X).
%X = [[a,b,c],[a,b],[a,c],[a],[b,c],[b],[c],[]]
