%load needed files.
?- load_files([absmach,scanner]).

%construct the DCG according to the specification
pgm(X) --> cmd(X). 
pgm(seq(X,Y)) --> cmd(X), [;], pgm(Y).
cmd(skip) --> [skip].
cmd(set(X,Y)) --> id(X), [:=], expr(Y).
cmd(if(X,Y,Z)) --> [if], bool(X), [then], pgm(Y),
		   [else],pgm(Z), [fi].
cmd(while(X,Y)) --> [while], bool(X), [do], pgm(Y), [od].
bool(X > Y) --> expr(X), [>], expr(Y).
bool(X < Y) --> expr(X), [<], expr(Y).
expr(X*Y) --> factor(X), [*], expr(Y).
expr(X) --> factor(X).
factor(X+Y) --> term(X), [+], factor(Y).
factor(X) --> term(X).
term(num(Y)) --> [Y], {number(Y)}.
term(X) --> [X], {nonvar(X)}.
id(X) --> [X], {nonvar(X)}.

%parse(T,O) : T = Tokens, O = Output program object
parse(Tokens, Out) :- pgm(Out, Tokens, []).

%run(I,S,O) : I = Initial Environment, S = String to be parsed,
%             O = Output Environment
run(In, String, Out) :-
scan(String, Tokens),
parse(Tokens, AbstStx),
execute(AbstStx, In, Out).

/*
Example query:
-----------------------------------------------------------
run([x,3],"y:=1; z:=0; while x>z do z:=z+1; y:=y*z od",Res).
Res = [x,3,y,6,z,3]
*/

