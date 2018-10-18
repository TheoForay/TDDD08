%inter1(S1, S2, I) - Creates in I the intersection of
%the two sets S1 and S2
inter1([], S2, []).
inter1([H|T], S2, [H|TI]) :- memberl(H,S2), inter1(T,S2,TI).
inter1([H|T], S2, I) :- \+memberl(H,S2),inter1(T,S2,I).


%memberl(X, L) - is True if X is a member of the list L
memberl(X, [X|_]).
memberl(X, [H|T]) :- memberl(X, T).

%inter(S1,S2,I) - Performs the intersection of S1 and S2
%and then sorts the resulting list and put it in I
inter(S1,S2,I) :- inter1(S1,S2,K), sort(K,I).

%inter([a,g,o],[a,g],X). X = [a,g]
