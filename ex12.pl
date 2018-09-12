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

%path finder just like before, but now it gets recorded into a list
%First, I record a two-length path into a list as soon as i find an edge.
%Then, given that I have a list for the path (Z,Y), I just need to append the next 
path(X,Y,[X,Y]) :- e(X,Y).
path(X,Y,[X|L]) :- e(X,Z), path(Z,Y,L). %è una chiamata che pero' il return è eseguito solo a ritroso, ed è per questo che funziona, poichè appende all'inizio. tutto a ritroso.

npath(X,Y,G) :- path(X,Y,L), length(L,G).


write(path(a,g,L)).
