%unionl(S1, S2, U) - Creates the union the two sets S1 and S2 into U
unionl([], S, S).
unionl([H|T], S2, U) :- memberl(H,S2), unionl(T, S2, U).
unionl([H|T], S2, [H|TU]) :- \+memberl(H, S2), unionl(T, S2, TU).


%memberl(X, L) - is True if X is a member of the list L
memberl(X, [X|_]).
memberl(X, [H|T]) :- memberl(X, T).