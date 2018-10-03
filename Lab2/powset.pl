%powset(S,L) - Returns a subset of S into L
powset([H|T], L) :- powset(T,L).
powset([H|T], [H|L]) :- powset(T,L).
powset([], []).

%powerset(S,R) - Returns all subsets of S into a R
powerset(S, R) :- findall(X, powset(S,X), RR), sort(RR,R).

%powerset([a,b,c], X).
%X = [[],[a],[a,b],[a,b,c],[a,c],[b],[b,c],[c]] 
