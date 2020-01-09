vowel(X):- member(X,[a,e,i,o,u]).

nr_vowel([],0).
nr_vowel([X|T],N):- vowel(X),nr_vowel(T,N1),N is N1+1,!.
nr_vowel([X|T],N):- nr_vowel(T,N).
