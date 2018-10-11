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


bf_search(Path) :- init_state(S), bf_search([[S]],Path).
bf_search([[S|Path]|_], [S|Path]) :- goal(S).
bf_search([[S1|Path]|Partials], FinalPath) :-
    findall(S2,move(S1,S2),NewStates),
    expand([S1|Path], NewStates, NewPaths),
    append(Partials, NewPaths, NewPartials),
    bf_search(NewPartials, FinalPath).
expand(L1,L2,L3) :- findall([X|L1], member(X,L2),L3).
