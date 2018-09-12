e(a,b).
e(a,c).
e(b,c).
e(c,d).
e(d,h).
e(c,e).
e(d,f).
e(e,f).
e(e,g).
e(f,g).

%performing transitive closure for each node in the graph
path(X,Y) :- e(X,Y).
path(X,Y) :- e(X,Z), path(Z,Y).
%Usecase
%-------------------------------------------------------------------------------
%path(a,b). yes
%path(h,f). no
%-------------------------------------------------------------------------------


%path finder just like before, but now it gets recorded into a list
%First, I record a two-length path into a list as soon as i find an edge.
%Then, given that I have a list for the path (Z,Y), I just need to append the next 
path(X,Y,[X,Y]) :- e(X,Y).
path(X,Y,[X|L]) :- e(X,Z), path(Z,Y,L).
%Usecases%
%---------------------------------------------------------------------
%path(a,g,L). I want all the paths from a to g (if there are any paths)
%L = [a,b,c,d,f,g] ? ;
%L = [a,b,c,e,g] ? ;
%L = [a,b,c,e,f,g] ? ;
%L = [a,c,d,f,g] ? ;
%L = [a,c,e,g] ? ;
%L = [a,c,e,f,g] ? ;

%path(c,b,L). no, since c is not connected to b by any path.
%-----------------------------------------------------------------------
%è una chiamata che pero' il return è eseguito solo a ritroso, ed è per questo che funziona, poichè appende all'inizio. tutto a ritroso.

%npath returns yes or no, depending on wheter there exists a path from X to Y. Moreover, if the call to path(X,Y,L) returns true, it calls the predicate length on the returned list, in order to get its length.
npath(X,Y,G) :- path(X,Y,L), length(L,G).
%Usecases
%---------------------------------------------------------------------------------------------------------------
%npath(a,g,K).
%K = 6 ? ;
%K = 5 ? ;
%K = 6 ? ;
%K = 5 ? ;
%K = 4 ? ;
%K = 5 ? ;
%It reflects the previous test-query.

%npath(h,g,K). no. Since there is no path from h to g, the second predicate (length) will not be called at all.
%---------------------------------------------------------------------------------------------------------------
