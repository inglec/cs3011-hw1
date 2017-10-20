% https://www.scss.tcd.ie/Tim.Fernando/LPN/hw1.pdf

numeral(0).
numeral(s(X)) :- numeral(X).    % s(X) = successor of X. Recursively define all natural numbers.
numeral(X+Y)  :- numeral(X), numeral(Y). % X+Y is a numeral if X and Y are numerals.

add(0, X, X). % 0 + X = X
add(s(X), Y, s(Z)) :- add(X, Y, Z). % (x+1) + y = (z+1) if x + y = z

add2(0, 0, 0).
add2(s(X), Y, s(Z)) :- add2(X, Y, Z).
add2(X,s(Y), s(Z)) :- add2(X, Y, Z).
add2(A+B, Y, Z) :- add2(A, B, X), add2(X, Y, Z).
add2(X, A+B, Z) :- add2(A, B, Y), add2(X, Y, Z).
