init_state(s(3,3,0,0)).
goal(s(0,0,3,3)).



move(s(A,B,C,D),Z) :- AA is A-2, CC is C+2, positive(AA,B,CC,D), good_state(s(AA,B,CC,D)), Z = s(AA, B, CC, D).
move(s(A,B,C,D),Z) :- BB is B-2, DD is D+2,  positive(A,BB,C,DD), good_state(s(A,BB,C,DD)), Z = s(A, BB, C, DD).
move(s(A,B,C,D),Z) :- AA is A-1, CC is C+1, BB is B-1, DD is D+1,  positive(AA,BB,CC,DD),good_state(s(AA,BB,CC,DD)), Z = s(AA, BB, CC, DD).
move(s(A,B,C,D),Z) :- AA is A-1,CC is C+1,  positive(AA,B,CC,D), good_state(s(AA,B,CC,D)), Z = s(AA, B, CC, D).
move(s(A,B,C,D),Z) :- BB is B-1,DD is D+1,  positive(A,BB,C,DD), good_state(s(A,BB,C,DD)), Z = s(A, BB, C, DD).


good_state(s(A,B,C,D)) :- A  =< B, C =< D, D > 0, B > 0.
good_state(s(A,B,C,D)) :- A  =< B, C =< D, A == 0, B == 0.
good_state(s(A,B,C,D)) :- A  > B, C > D, D == 0, B == 0.
good_state(s(A,B,C,D)) :- A  > B, C =< D, B == 0.
good_state(s(A,B,C,D)) :- A  =< B, C > D, D == 0.

positive(A,B,C,D) :- A>=0, B>=0, C>=0, D>=0.

df_search(Path) :- init_state(S), df_search([S], Path).
df_search([S|Visited],[S|Visited]) :- goal(S).
df_search([S1|Visited], Path) :- move(S1,S2), nonmember(S2,[S1|Visited]), df_search([S2,S1|Visited], Path).
