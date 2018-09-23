% middle(X,Xs)
% X is the middle element in the list Xs
middle(X, [X]).
middle(X, [First|Xs]) :-middle(X, Middle),append(Middle, [Last], Xs).