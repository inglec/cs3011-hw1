numeral(0).
numeral(-X)   :- numeral(X).
numeral(p(X)) :- numeral(X).
numeral(s(X)) :- numeral(X).
numeral(X+Y)  :- numeral(X), numeral(Y).
numeral(X-Y)  :- numeral(X), numeral(Y).

add(0, X, X).
add(s(X), Y, s(Z)) :- add(X, Y, A), simp(A, Z).
add(p(X), Y, p(Z)) :- add(X, Y, A), simp(A, Z).

add2(X, Y, Z) :- simp(X, A), simp(Y, B), add(A, B, C), simp(C, Z).

subtract(X, Y, Z) :- add2(X, -Y, Z).

simp(0, 0).
simp(p(0), p(0)).
simp(s(0), s(0)).
simp(p(s(X)), Z)    :- simp(X, Z).
simp(s(p(X)), Z)    :- simp(X, Z).
simp(p(p(X)), p(Z)) :- simp(p(X), Z).
simp(s(s(X)), s(Z)) :- simp(s(X), Z).
simp(-X, Z)         :- minus(X, A), simp(A, Z).
simp(X+Y, Z)        :- simp(X, A), simp(Y, B), add2(A, B, C), simp(C, Z).
simp(p(X+Y), p(Z))  :- simp(X, A), simp(Y, B), add2(A, B, C), simp(C, Z).
simp(s(X+Y), s(Z))  :- simp(X, A), simp(Y, B), add2(A, B, C), simp(C, Z).
simp(X-Y, Z)        :- simp(X, A), simp(Y, B), subtract(A, B, C), simp(C, Z).
simp(p(X-Y), p(Z))  :- simp(X, A), simp(Y, B), subtract(A, B, C), simp(C, Z).
simp(s(X-Y), s(Z))  :- simp(X, A), simp(Y, B), subtract(A, B, C), simp(C, Z).

minus(X, Y) :- simp(X, A), minusHelper(A, Y).
minusHelper(0, 0).
minusHelper(s(X), p(Y)) :- minusHelper(X, Y).
minusHelper(p(X), s(Y)) :- minusHelper(X, Y).
