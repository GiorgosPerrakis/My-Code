/* Solves the Zebra Puzzle:
**   http://en.wikipedia.org/wiki/Zebra_Puzzle
**
** The data structure representation for houses is:
**   house(Nationality, Color, Animal, Drink, Smoke)
*/

zebra(Houses) :-
    Houses = [house(norwegian, _, _, _, _),
	      house(_, blue, _, _, _),
	      house(_, _, _, milk, _), _, _],
    member(house(english, red, _, _, _), Houses),
    member(house(spanish, _, dog, _, _), Houses),
    member(house(_, green, _, coffee, _), Houses),
    member(house(ukranian, _, _, tea, _), Houses),
    sublist5([house(_, white, _, _, _), house(_, green, _, _, _)], Houses),
    member(house(_, _, snails, _, old_gold), Houses),
    member(house(_, yellow, _, _, kools), Houses),
    next_to(house(_, _, _, _, chesterfields), house(_, _, fox, _, _), Houses),
    next_to(house(_, _, _, _, kools), house(_, _, horse, _, _), Houses),
    member(house(_, _, _, orange_juice, lucky_strike), Houses),
    member(house(japanese, _, _, _, parliaments), Houses).

sublist5([X,Y], [X,Y,_,_,_]).
sublist5([X,Y], [_,X,Y,_,_]).
sublist5([X,Y], [_,_,X,Y,_]).
sublist5([X,Y], [_,_,_,X,Y]).

next_to(H1, H2, Houses) :- sublist5([H1,H2], Houses).
next_to(H1, H2, Houses) :- sublist5([H2,H1], Houses).
