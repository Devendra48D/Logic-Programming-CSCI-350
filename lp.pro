/* Function sum-up-numbers-simple(L, N) has a list L. L is a list, which may 
*contain as elements numbers and non-numbers. The predicate is true if N is the 
*sum of the numbers not in nested lists in L. If there are no such numbers, the 
*result is zero.
*Logic: - If the list is empty, result is 0
*       - If the first element is a non-number, result is sum of the rest of the 
*list
*       - If the first element is a number, result is sum of the number and sum of 
* the rest of the list.
*/


/*If the list is empty, result is 0*/

sum-up-numbers-simple([],0).

/*If the first element is a non-number, result is sum of the rest of the list*/
sum-up-numbers-simple(L, N):-
	[X|Y] = L,
	\+ number(X), 
	sum-up-numbers-simple(Y, Rem),
	N is Rem.

/*If the first element is a number, result is sum of the number and sum of the 
*rest of the list*/
sum-up-numbers-simple(L, N):-
	[X|Y] = L,
	number(X), 
	sum-up-numbers-simple(Y, Rem),
	N is X + Rem.



/* Function sum-up-numbers-general(L, N) has a list L. L is a list, which may 
*contain as elements numbers and non-numbers. The predicate is true if N is the 
*sum of all the numbers including in nested lists in L. If there are no 
*such numbers, the result is zero.
*Logic: - If the list is empty, result is 0
*       - If the first element is a list, result is sum of the sum of rest of 
* the list and sum of the elements in first list
*       - If the first element is a number, result is sum of the number and sum of 
* the rest of the list.
*       - If the first element is a non-number and non-list, result is sum of the 
* rest of the list
*/

/*If the list is empty, result is 0*/
sum-up-numbers-general([], 0).

/*Predicate to check whether an atom is a list*/
list([]).
list([A|B]).

/*If the first element is a number, result is sum of the number and sum of the 
*rest of the list*/
sum-up-numbers-general(L, N):-
	[X|Y] = L,
	number(X), 
	sum-up-numbers-general(Y, Rem),
	N is X + Rem.

/*If the first element is a list, result is sum of the sum of rest of the list
* and sum of the elements in first list*/
sum-up-numbers-general(L, N):-
	[X|Y] = L,
	\+ number(X),
	list(X), 
	sum-up-numbers-general(X, First),
	sum-up-numbers-general(Y, Rem),
	N is First + Rem.

/*If the first element is a non-number and non-list, result is sum of the 
*rest of the list*/
sum-up-numbers-general(L, N):-
	[X|Y] = L,
	\+ number(X),
	\+ list(X), 
	sum-up-numbers-general(Y, Rem),
	N is Rem.

/* min-above-min
*/
min(X, Y, X):-
	X < Y.
min(X, Y, Y):-
	X >= Y.

min-list(L, Low):-
	[X] = L,
	number(X), 
	Low is X.

min-list(L, Low):- 
	[X|Y] = L, 
	\+ number(X),
	min-list(Y, Low).

min-list(L, Low):-
	[X|Y] = L, 
	number(X),
	\+ min-list(Y, Second),
	Low is X.

min-list(L, Low):-
	[X|Y] = L, 
	number(X),
	min-list(Y, Second),
	number(Second),
	min(X, Second, Low).

next-big(L, Num, Ans):-
	[X] = L, 
	X > Num, 
	Ans is X.

next-big(L, Num, Ans):- 
	[X|Y] = L, 
	\+ number(X), 
	next-big(Y, Num, Ans).

next-big(L, Num, Ans):-
	[X|Y] = L, 
	number(X), 
	X > Num, 
	next-big(Y, Num, Second), 
	number(Second),
	min(X, Second, Ans).

next-big(L, Num, Ans):-
	[X|Y] = L, 
	number(X), 
	X > Num, 
	\+ next-big(Y, Num, Second), 
	Ans is X.	

next-big(L, Num, Ans):-
	[X|Y] = L, 
	number(X), 
	X =< Num, 
	next-big(Y, Num, Ans).	

min-above-min(L1, L2, N):-
	min-list(L2, Low),
	next-big(L1, Low, N).