tt :- succeed.
ff :- fail.

skip :- true.

%Tutto parte da una eval, che propagherà le due liste. A me basta solo avere la dichiarazione tipo add(E,E), tanto poi, se la chiama un eval iniziale, le passa ad un eval(add(..),L,F,Z), che le propaga. Non so se F(final) serve, ma comunque meglio tenerlo.
eval(num(X),L,F,X).
eval(+(A, B),L,F, Z) :- eval(A,L,F, A_R), eval(B,L,F, B_R), Z is A_R + B_R.
eval(*(A, B),L,F, Z) :- eval(A,L,F, A_R), eval(B,L,F, B_R), Z is A_R * B_R.
eval(-(A, B),L,F, Z) :- eval(A,L,F, A_R), eval(B,L,F, B_R), Z is A_R - B_R.
eval(/(A, B),L,F, Z) :- eval(A,L,F, A_R), eval(B,L,F, B_R), Z is A_R / B_R.
eval(>(A, B), L, F, Z) :- eval(A,L,F, A_R), eval(B,L,F, B_R), A_R > B_R.
eval(<(A, B), L, F, Z) :- eval(A,L,F, A_R), eval(B,L,F, B_R), A_R =< B_R.
eval(id(X), L,F, Z) :- id2(X,L,Z).
eval(set(I,E), L, Z, ZZ) :- eval(E, L ,Z, R), set2(I,R,L,ZZ). 

eval(if(B,C,C1), L, F, Z) :- eval(B, L, F, _) -> eval(C,L,F,Z) ; eval(C1,L,F,Z).

eval(while(tt,skip), L, F, L).
eval(while(B,C), L, F, Z) :- eval(B, L, F, _) -> eval(C,L,F,CR), eval(while(B,C), CR, F, Z) ; eval(while(tt, skip), L, F, Z).

eval(seq(C,C1), L, F, Z) :- eval(C,L,F,CR), eval(C1,CR,F,Z).

eval(skip, L, F, L).

exec(P,L,Z) :- eval(seq(P,skip),L, F, Z).

id2(X,[],Z) :- fail.
id2(H,[H,H1|_],H1).
id2(X,[H,H1|T],Z) :- id2(X,T,Z).

set2(I,R,[I,_|T],[I,R|T]).
set2(I,R,F,Z) :- \+member(I,F), append(F,[I,R],Z).
set2(I,R,[H,H1|T],[H,H1|Z]) :- set2(I,R,T,Z).
