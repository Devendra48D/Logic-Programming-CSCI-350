/* Function sum-up-numbers-simple(L, N) has a list L. L is a list, which may *contain as elements numbers and non-numbers. The predicate is true if N is the *sum of the numbers not in nested lists in L. If there are no such numbers, the *result is zero.
*Logic: - If the list is empty, result is 0
*       - If the first element is a non-number, result is sum of the rest of the *list
*       - If the first element is a number, result is sum of the number and sum of * the rest of the list.
*/


/*If the list is empty, result is 0*/
sum-up-numbers-simple([],0).

/*If the first element is a non-number, result is sum of the rest of the list*/
sum-up-numbers-simple(L, N):-
	[X|Y] = L,
	\+ number(X), 
	sum-up-numbers-simple(Y, Rem),
	N is Rem.

/*If the first element is a number, result is sum of the number and sum of the *rest of the list*/
sum-up-numbers-simple(L, N):-
	[X|Y] = L,
	number(X), 
	sum-up-numbers-simple(Y, Rem),
	N is X + Rem.