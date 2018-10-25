:- use_module(library(clpfd)).

% container(B, M, D).
% B - container id
% M - number of men required
% D - time to unload the container
container(a,2,2).
container(b,4,1).
container(c,2,2).
container(d,1,1).

% on(B1, B2).
on(a,d).
on(b,c).
on(c,d).

%t_t_constraint(L, TotalTime) - TotalTime must be greater or equal than other times.
t_t_constraint([], _).
t_t_constraint([E|Es], TotalTime) :-
	TotalTime #>= E,
	t_t_constraint(Es, TotalTime).

%global_constraints(I, ST, ET) - applies the different constaints on the unloading containers
global_constraints([], [], []).
global_constraints([Id|I], [S1|S], [E1|E]) :-
	helper(Id, I, S1, S, E1, E),
	global_constraints(I, S, E).

helper(_Id, [], _S1, [], _E1, []).
helper(Id, [Id1|I], S1, [S2|S], E1, [E2|E]) :-
	constraint(Id, Id1, S1, S2, E1, E2),
	helper(Id, I, S1, S, E1, E).

constraint(Id, Id1, _S, _S1, _E, _E1) :-
	\+ on(Id, Id1),
	\+ on(Id1, Id).

%If one container is under another, then its ST of unloading will be greater or equal to the end of the unloading time of the one that is on him
constraint(Id, Id1, _S, S1, E, _E1) :-
	on(Id, Id1),
	S1 #>= E.

constraint(Id, Id1, S, _S1, _E, E1) :-
	on(Id1, Id),
	S #>= E1.

%schedule(StartTime, EndTime, Cost, Workers, TotalTime) - C is the total C to unload the containers.
schedule(ST, ET, C, W, TotalTime) :-
findall([Identifiers, Resources, Durations], container(Identifiers, Resources, Durations), Containers),
to_list(Containers, I, R, D),
length(I, NoTasks),
length(ET, NoTasks),
length(ST, NoTasks),
domain(ST, 0, 99),
domain(ET, 0, 99),
W in 0..99,
TotalTime in 1..99,
t_t_constraint(ET, TotalTime),
global_constraints(I, ST, ET),
generate_tasks(ST, D, ET, R, Tasks),
cumulative(Tasks, [limit(W)]),
C #= W * TotalTime,
append(ET, ST, Vars),
labeling([minimize(C)], [C | Vars]).

to_list([], [], [], []).
to_list([[Id, Res, Time]| C], [Id|Tid], [Res|Tres], [Time|Ttime]) :-
	to_list(C, Tid, Tres, Ttime).

%generate_tasks(S, D, E, R, T) - creates the tasks (container unload) to do for each linked elements of these lists.
generate_tasks([], [], [], [], []).
generate_tasks([ST|S], [Time|D], [ET|E], [Res|Tres], [Task|T]) :-
	Task = task(ST, Time, ET, Res, 0),
	generate_tasks(S, D, E, Tres, T).


%Example of query to use the actual 'data base':
%schedule(ST,ET,C,W,TT).
%ST = [1,0,1,3],
%ET = [3,1,3,4],
%C = 16,
%W = 4,
%TT = 4 ? ;
%no
