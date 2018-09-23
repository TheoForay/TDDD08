%inter(S1, S2, I) - Creates in I the intersection of the two sets S1 and S2
inter([], S2, []).
inter([H|T], S2, [H|TI]) :- memberl(H,S2),inter(T,S2,TI).
inter([H|T], S2, I) :- \+memberl(H,S2),inter(T,S2,I).


%memberl(X, L) - is True if X is a member of the list L
memberl(X, [X|_]).
memberl(X, [H|T]) :- memberl(X, T).