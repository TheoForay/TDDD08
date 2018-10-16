%s(A,B,C,D) - A is the amount of Cannibals on the first bank, B is the amount of Missionaries on the first bank
%C is the amount of Cannibals on the final bank, and D is the amount of Missionaries on the final bank
init_state(s(3,3,0,0)).

%final state
goal(s(0,0,3,3)).

%moving characters by respecting the condition
move().
