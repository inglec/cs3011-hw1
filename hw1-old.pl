% https://www.scss.tcd.ie/Tim.Fernando/LPN/hw1.pdf

numeral(0).
numeral(-X)   :- numeral(X).
numeral(s(X)) :- numeral(X). % s(X) = successor of X. Recursively define all natural numbers.
numeral(p(X)) :- numeral(X). % p(X) = predecessor of X.
numeral(X+Y)  :- numeral(X), numeral(Y). % X+Y is a numeral if X and Y are numerals.
numeral(X-Y)  :- numeral(X), numeral(Y). % X-Y is a numeral if X and Y are numerals.

add(0, X, X). % 0 + X = X
add(s(X), Y, s(Z)) :- add(X, Y, Z). % (x+1) + y = (z+1) if x + y = z

add2(0, 0, 0). % Base case. Cannot use add(0, X, X) as s(0+s(0)) would unify with X.

add2(-X, Y, Z) :- minus(X, A), add2(A, Y, Z).
add2(X, -Y, Z) :- minus(Y, A), add2(X, A, Z).

add2(A+B, Y, Z) :-     add2(A, B, X), add2(X, Y, Z).
add2(X, A+B, Z) :-     add2(A, B, Y), add2(X, Y, Z).
add2(A-B, Y, Z) :- subtract(A, B, X), add2(X, Y, Z).
add2(X, A-B, Z) :- subtract(A, B, Y), add2(X, Y, Z).

add2(s(p(X)), Y, Z) :- add2(X, Y, Z). % s(p(X)) => X
add2(p(s(X)), Y, Z) :- add2(X, Y, Z). % p(s(X)) => X
add2(X, s(p(Y)), Z) :- add2(X, Y, Z). % s(p(Y)) => Y
add2(X, p(s(Y)), Z) :- add2(X, Y, Z). % p(s(Y)) => Y
add2(s(X), p(Y), Z) :- add2(X, Y, Z). % s(X)+p(Y) => X+Y
add2(p(X), s(Y), Z) :- add2(X, Y, Z). % p(X)+s(Y) => X+Y

add2(s(X), Y, s(Z)) :- add2(X, Y, Z). % Pattern match using s(X)
add2(p(X), Y, p(Z)) :- add2(X, Y, Z). % Pattern match using p(X)
add2(X, s(Y), s(Z)) :- add2(X, Y, Z). % Pattern match using s(Y)
add2(X, p(Y), p(Z)) :- add2(X, Y, Z). % Pattern match using p(Y)

subtract(X, Y, Z) :- add2(X, -Y, Z).

minus(0, 0). % 0 => 0
minus(-X, X). % -X => X
minus(A+B, Y) :-      add(A, B, X), minus(X, Y).
minus(A-B, Y) :- subtract(A, B, X), minus(X, Y).
minus(s(p(X)), Y) :- minus(X, Y). % s(p(X)) => X
minus(p(s(X)), Y) :- minus(X, Y). % s(p(X)) => X
minus(s(X), p(Y)) :- minus(X, Y). % s(X) => p(X)
minus(p(X), s(Y)) :- minus(X, Y). % p(X) => s(X)
