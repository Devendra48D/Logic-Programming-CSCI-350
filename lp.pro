sum-up-numbers-simple([],0).
sum-up-numbers-simple([X|Y], num):-
	\+ \+ number(X), 
	sum-up-numbers-simple(Y, rem),
	num is X + rem.
