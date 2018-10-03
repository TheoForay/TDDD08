?- load_files([absmach,scanner]).

%The parameters that you pass are actually the return values. And the one in the head as well is the returning format.
pgm(X) --> cmd(X). 
pgm(seq(X,Y)) --> cmd(X), [;], pgm(Y).
cmd(skip) --> [skip].
cmd(set(X,Y)) --> id(X), [:=], expr(Y).
cmd(if(X,Y,Z)) --> [if], bool(X), [then], pgm(Y), [else],pgm(Z), [fi].
cmd(while(X,Y)) --> [while], bool(X), [do], pgm(Y), [od].
bool(X > Y) --> expr(X), [>], expr(Y).
bool(X < Y) --> expr(X), [<], expr(Y).
expr(X*Y) --> factor(X), [*], expr(Y).
expr(X+Y) --> factor(X), [+], expr(Y).
expr(X-Y) --> factor(X), [-], expr(Y).
expr(X/Y) --> factor(X), [/], expr(Y).
expr(X) --> factor(X).
factor(X+Y) --> term(X), [+], factor(Y).
factor(X) --> term(X).
term(num(Y)) --> [Y], {number(Y)}.
term(X) --> [X], {nonvar(X)}.
id(id(X)) --> [X], {nonvar(X)}.

parse(Tokens, Out) :- pgm(Out, Tokens, []).

run(In, String, Tokens) :-
scan(String, Tokens),
parse(Tokens, AbstStx).
%execute(In, AbstStx, Out).

%run([x=3],"y:=1; z:=0; while x>z do z:=z+1; y:=y*z od",Res).

