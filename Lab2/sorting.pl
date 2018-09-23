%issorted(L) - L is a sorted list in ascending order.
issorted([]).
issorted([H]).
issorted( [H,H1|T] ) :- H<H1
	,issorted([H1|T]).

%ssort(L,Ls) - Sorts L with a Selection Sort and put this result into Ls. 
ssort( [], [] ).
ssort( [H], [H]).
ssort( [H|L], [X|L1] ) :- min([H|L], X), remove(X,[H|L],N), ssort(N, L1).

%min(L,X) - returns the minimum element of the list L in X/
min([H], H).
min( [H,H1|T], X) :- H1>=H, min( [H|T], X).
min( [H,H1|T], X) :- H>=H1, min( [H1|T], X).

%remove(X, L, O) - removes X from L and put this result in O.
remove(X, [X|L], L).
remove(X, [H|L], [H|O]) :- remove(X, L, O).