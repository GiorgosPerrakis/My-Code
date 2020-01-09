%%
%% A non-tail recursive version of a factorial predicate
%%
fact(0, 1).
fact(N, F) :-
    N > 0, N1 is N-1, fact(N1, G), F is G*N.

%%
%% A tail recursive version of a factorial predicate
%%
fact_tail(N, F) :-
    fact_tail_aux(N, 1, F).

fact_tail_aux(0, Acc, Acc).
fact_tail_aux(N, Acc, F) :-
    N > 0, N1 is N-1, Acc1 is Acc*N, fact_tail_aux(N1, Acc1, F).

%%
%% A predicate that returns permutations of a list
%%
perm([], []).
perm([H|T], Perms) :-
    perm(T, TP), delete(H, Perms, TP).

delete(X, [X|T], T).
delete(X, [H|T], [H|R]) :- delete(X, T, R).

