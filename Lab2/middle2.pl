% middle(X,Xs)
% X is the middle element in the list Xs
middle(X, [First|Xs]) :-append(Middle, [Last], Xs),middle(X, Middle).
middle(X, [X]).