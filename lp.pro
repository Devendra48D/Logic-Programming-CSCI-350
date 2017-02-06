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

/* start of min-above-min 
*/

/* min to compare two numbers */
min(X, Y, X):-
	X < Y.
min(X, Y, Y):-
	X >= Y.

/*min-list takes one parameter L, a list of numbers and non-numbers without any nested *lists and returns the smallest number in L. If no such number is present, returns #F.

*Logic: 
*        - If the list has only one number, the nuumber is the answer
*    - If the first element is not a number, the answer is minimum from the rest of *the list
*        - If the first element is a number and the minimum for the rest of the list *is not a number, the answer is the first number
*       - If the first element is a number and the minimum for the rest is also a *number, the answer is minimum of these two values.
*/

/* list with only one number */
min-list(L, Low):-
	[X] = L,
	number(X), 
	Low is X.

/* first element is not a number */
min-list(L, Low):- 
	[X|Y] = L, 
	\+ number(X),
	min-list(Y, Low).

/* first element is a number and min of rest of the list is not a number */
min-list(L, Low):-
	[X|Y] = L, 
	number(X),
	\+ min-list(Y, Second),
	Low is X.

/* first element is a number and min of rest of the list also a number */
min-list(L, Low):-
	[X|Y] = L, 
	number(X),
	min-list(Y, Second),
	number(Second),
	min(X, Second, Low).

/*next-big*/
/* next-big takes two parameters, L a list containing numbers and non-numbers but no *nested lists
* and num a number. next-big returns the smallest of the numbers that are larger 
*than num in L.
* If there are no such numbers in L, the result is #F.
*
* Logic: - If num is not a number, the result is #F.
*        - If L is empty, the result i #F.
*       - If there is only one element in L that is smaller than or equal to num, the *result is #F
*        - If there is only one element in L that is larger than num, the result is *the only number
*      - If there is only one element in L and it is a non number, the result is #F.
*    - If the first element is not a number, the rest of the list is used to find the result
*      - If the first number is larger than num and there is a result from the rest of the list, the minimum of these two is the answer.
*       - If the first number is larger than num and there is no result from the rest of the list,the result is the first number
*       - If the first number is less than or equal to num or the first element is not *a number, the rest of the list is used to find the result
*/

/*only one element in L the element is a number that is larger than num */
next-big(L, Num, Ans):-
	[X] = L, 
	number(X),
	X > Num, 
	Ans is X.

/*first element is not a number and there are more elements in the list */
next-big(L, Num, Ans):- 
	[X|Y] = L, 
	\+ number(X), 
	next-big(Y, Num, Ans).

/* first number is less than or equal to num*/
next-big(L, Num, Ans):-
	[X|Y] = L, 
	number(X), 
	X =< Num, 
	next-big(Y, Num, Ans).

/*first number is larger than num and there is a result from the rest of the list*/
next-big(L, Num, Ans):-
	[X|Y] = L, 
	number(X), 
	X > Num, 
	next-big(Y, Num, Second), 
	number(Second),
	min(X, Second, Ans).

/* first number is larger than num and there is no result from the rest of the list*/
next-big(L, Num, Ans):-
	[X|Y] = L, 
	number(X), 
	X > Num, 
	\+ next-big(Y, Num, Second), 
	Ans is X.	

/* min-above-min takes two parameters, L1 and L2 that are both lists which do not *contain nested lists
*Both L1 and L2 may have non-numeric elements; returns the minimum of the numbers in *L1 that are larger than
* the smallest number in L2.
* If there is no number in L2, the function returns the minimum of numbers in L1.
* If there is no number in L1 that is larger than the minimum of L1, the result is #F.

* Logic: 
*        - If L2 is empty or does not have a minimum, the result is minimum of L1.
*        - If L2 has a minimum number, the result is (next-big L1 (min-list L2)) 
*/

/*If the second list has a minimum, the result is next-big 
*of the second list. */
min-above-min(L1, L2, N):-
	min-list(L2, Low),
	next-big(L1, Low, N).

/*If the second list does not have a minimum, the result is the 
 * minimum of first list */
min-above-min(L1, L2, N):-
	\+ min-list(L2, Low),
	min-list(L1, N).

/* start of common-unique-elements */
common-unique-elements([],[],[]).

all-unique([]).

all-unique(L):-
	[X|Y] = L, 
	\+ member(X, Y),
	\+ list(X), 
	all-unique(Y).

unique-elements([],[]).

unique-elements(L, Ans):-
	[X|Y] = L,
	[X|Z] = Ans,
	\+ list(X),
	unique-elements(Y, Z).

unique-elements(L, Ans):-
	[X|Y] = L, 
	list(X),
	unique-elements(X|Left),
	unique-elements(Y|Right),
	append(Left, Right, Ans).

common-unique-elements(L1, L2, N):-
	unique-elements(L1, First), 
	unique-element(L2, Second),
	common(First, Second, N), 
	all-unique(N).

