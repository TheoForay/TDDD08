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

%schedule(StartTime, EndTime, Cost, Workers, TimeUsed) - Cost is the total cost to unload the containers.
schedule(StartTime, EndTime, Cost, Workers, TimeUsed) :-

%Load all containers and place Identifiers, Resources and Durations in single lists.
findall([Identifiers, Resources, Durations], container(Identifiers, Resources, Durations), Containers),
to_list(Containers, I, R, D),

%length - length of the StartTime and EndTime lists.
length(I, NoTasks),
length(EndTime, NoTasks),
length(StartTime, NoTasks),
domain(StartTime, 0, 99),
domain(EndTime, 0, 99),
Workers in 0..99,
TimeUsed in 1..99,
time_used_constraints(EndTime, TimeUsed),
container_constraints(I, StartTime, EndTime),
generate_tasks(StartTime, D, EndTime, R, Tasks),
cumulative(Tasks, [limit(Workers)]),
Cost #= Workers * TimeUsed,
append(EndTime, StartTime, Vars),
labeling([minimize(Cost)], [Cost | Vars]).

%to_list(L1, L2, L3, L4).
%L1 - list of identifiers, resources and durations, then
%L2 - list of identifiers,
%L3 - list of resources and
%L4 - list of durations.
to_list([], [], [], []).
to_list([[Identifier, Resource, Duration]| Containers], [Identifier|I], [Resource|R], [Duration|D]) :-
	to_list(Containers, I, R, D).


%time_used_constraints(L, TimeUsed).
%If L is a list of end times, TimeUsed will be greater or equal to every one of them.
time_used_constraints([], _).
time_used_constraints([E|Es], TimeUsed) :-
	TimeUsed #>= E,
	time_used_constraints(Es, TimeUsed).

%container_constraints(I, StartTime, EndTime).
%If I is a list of identifiers, then
%StartTime- and EndTime elements will be set to right constraint depend on
%which container to unload first (example: on(X, Y), unload X before Y).
container_constraints([], [], []).
container_constraints([Id|I], [S1|S], [E1|E]) :-
	helper(Id, I, S1, S, E1, E),
	container_constraints(I, S, E).

helper(_Id, [], _S1, [], _E1, []).
helper(Id, [Id1|I], S1, [S2|S], E1, [E2|E]) :-
	constraint(Id, Id1, S1, S2, E1, E2),
	helper(Id, I, S1, S, E1, E).

constraint(Id, Id1, _S, _S1, _E, _E1) :-
	\+ on(Id, Id1),
	\+ on(Id1, Id).

%If one container is under another, then its StartTime of unloading will be greater or equal to the end of the unloading time of the one that is on him
constraint(Id, Id1, _S, S1, E, _E1) :-
	on(Id, Id1),
	S1 #>= E.

constraint(Id, Id1, S, _S1, _E, E1) :-
	on(Id1, Id),
	S #>= E1.

%generate_tasks(S, D, E, R, T).
%If S, D, E and R is list of equal lengths, then
%T will be a list that contains tasks to do (in this case, unload containers).
generate_tasks([], [], [], [], []).
generate_tasks([StartTime|S], [Duration|D], [EndTime|E], [Resource|R], [Task|T]) :-
	Task = task(StartTime, Duration, EndTime, Resource, 0),
generate_tasks(S, D, E, R, T).
