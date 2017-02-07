/* Predicate sum-up-numbers-simple(L, N) has a list L. L is a list, which may 
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


/* Predicate sum-up-numbers-general(L, N) has a list L. L is a list, which may 
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
	is_list(X), 
	sum-up-numbers-general(X, First),
	sum-up-numbers-general(Y, Rem),
	N is First + Rem.

/*If the first element is a non-number and non-list, result is sum of the 
*rest of the list*/
sum-up-numbers-general(L, N):-
	[X|Y] = L,
	\+ number(X),
	\+ is_list(X), 
	sum-up-numbers-general(Y, Rem),
	N is Rem.

/* start of min-above-min 
*/

/* min to compare two numbers */
min(X, Y, X):-
	X < Y.
min(X, Y, Y):-
	X >= Y.

/* Predicate min-list takes one parameter L, a list of numbers and non-numbers without *any nested lists and returns the smallest number in L. If no such number is present, returns #F.

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
/* Predicate next-big takes two parameters, L a list containing numbers and non-numbers but no *nested lists
* and num a number. next-big returns the smallest of the numbers that are larger 
*than num in L.
* If there are no such numbers in L, the result is #F.
*
* Logic: - If num is not a number, the result is #F.
*        - If L is empty, the result i #F.
*       - If there is only one element in L that is smaller than or equal to num, the *result is #F
*        - If there is only one element in L that is larger than num, the result is *the only number
*      - If there is only one element in L and it is a non number, the result is #F.
*    - If the first element is not a number, the rest of the list is used to find the *result
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

/* Predicate min-above-min takes two parameters, L1 and L2 that are both lists which do not *contain nested lists
*Both L1 and L2 may have non-numeric elements; returns the minimum of the numbers in *L1 that are larger than
* the smallest number in L2.
* If there is no number in L2, the function returns the minimum of numbers in L1.
* If there is no number in L1 that is larger than the minimum of L1, the result is #F.
*
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

/* Predicate all-unique is a helper predicate for common-unique-elements. 
*  It takes in one parameter L, a simple list. The result is True if all
*  the elements in L are unique, False otherwise. 
* Logic - The result for empty list is True. 
*       - If the first element is not present in the rest of the list, 
*		  the result is the result from the rest of the list.
*/

/* The result for empty list is True. */
all-unique([]).

/*If the first element is not present in the rest of the list, 
* the result is the result from the rest of the list.*/
all-unique(L):-
	[X|Y] = L, 
	\+ member(X, Y),
	\+ is_list(X), 
	all-unique(Y).

/* Predicate remove-duplicates is a helper predicate for common-unique-elements.
* It takes one parameter L, a simple list, and removes all the duplicates from L.
* The result is S.
* Logic - The result for empty list is [].
*       - If the first element is present in rest of the list, the result is 
*         the result from the rest of the list. 
*       - If the first element is not present in rest of the list, the result 
*         the first element appended with the result from the rest of the list.  
*/

/* the result for empty list is [].*/
remove-duplicates([],[]).

/* If the first element is not present in rest of the list, the result 
* the first element appended with the result from the rest of the list.*/
remove-duplicates(L, S):-
	[X|Y] = L, 
	\+ member(X, Y),
	remove-duplicates(Y, Second), 
	append([X], Second, S).

/*If the first element is present in rest of the list, the result is 
* the result from the rest of the list. */
remove-duplicates(L, S):-
	[X|Y] = L, 
	member(X, Y),
	remove-duplicates(Y, S).


/* Predicate unique-elements takes one parameter L, a general list (which may
* contain nested sub-lists). The result is Ans, a simple list with all the 
* unique elements of L.
* This is a helper predicate for common-unique-elements. 
* Logic - Get all the elements of L including the elements of sub-lists in L
*         and store it in a temporary list Temp. Remove duplicates from Temp
*         and store it in Ans. The result is Ans.
*/

/*empty-list*/
unique-elements([],[]).

/* first element of L is not a list, append first element with the 
*  the result from rest of the list.
*/
unique-elements(L, Ans):-
	[X|Y] = L, 
	\+ is_list(X),
	unique-elements(Y, Z), 
	append([X], Z, Temp),
	remove-duplicates(Temp, Ans).

/* first element of L is a list, append result from first element with the 
*  the result from rest of the list.
*/
unique-elements(L, Ans):-
	[X|Y] = L, 
	is_list(X), 
	unique-elements(X, A1), 
	unique-elements(Y, A2), 
	append(A1, A2, Temp),
	remove-duplicates(Temp, Ans).


/* Predicate common is a helper predicate for common-unique-elements
* It takes two parameters L1 and L2 that are simple lists without sublists. 
* common returns the elements that are present in both L1 and L2 as N. 
* The result is N.
*
* Logic - If either or both L1 or L2 is empty, the result is [].
*       - If the first element of L1 is in L2, the result is [first element] 
*         appended with the result from rest of L1 and L2.
*       - If the first element of L1 is not in L2, the result is  
*         common from rest of L1 and L2.
*/

/* either L1 or L2 is empty */
common([],[],[]).
common(X, [], []).
common([], X, []).

/* first element of L1 is in L2 */
common(L1, L2, N):-
	[X|Y] = L1, 
	member(X, L2),
	common(Y, L2, Tail), 
	append([X], Tail, N).

/* first element of L1 is not in L2 */
common(L1, L2, N):-
	[X|Y] = L1, 
	\+ member(X, L2), 
	common(Y, L2, N).

/* Predicate common-unique-elements(L1,L2,N) takes L1 and L2 that are both general *lists, which may contain nested lists. The predicate is true if N is a simple list 
*(i.e. a list without sub-lists) of the items that appear in both L1 and L2 (including *the sub-lists within). The elements in the result list must be unique.
*
* Logic - Flattens L1 and L2, store the unique elements of L1 and L2
* in First and Second respectively. First and Second do not have nested list. 
* Find the common elements between First and Second, and store it in N. 
* N is the result. All the elements in N are unique. 
*/

/* empty lists */
common-unique-elements([],[],[]).

/* L1 and L2 have some common unique elements */
common-unique-elements(L1, L2, N):-
	unique-elements(L1, First), 
	unique-elements(L2, Second),
	common(First, Second, N), 
	all-unique(N).