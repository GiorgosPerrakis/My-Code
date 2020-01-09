winner(L) :-
    L = [_,_,_], triple(L, Triada), is_winning(Triada).

triple(L, T) :- member(T, L).
triple(L, T) :- transpose(L, LT), member(T, LT).
triple([[A,_,_], [_,B,_], [_,_,C]], [A,B,C]).
triple([[_,_,A], [_,B,_], [C,_,_]], [A,B,C]).

transpose([[A,B,C],[D,E,F],[G,H,I]], [[A,D,G],[B,E,H],[C,F,I]]).

is_winning([x,x,x]).
is_winning([x,x,b]).
is_winning([x,b,x]).
is_winning([b,x,x]).
