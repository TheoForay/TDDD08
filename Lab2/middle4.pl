% middle(X,Xs)
% X is the middle element in the list Xs
middle(X, [First|Xs]) :-middle(X, Middle) ,append(Middle, [Last], Xs).
middle(X, [X]).