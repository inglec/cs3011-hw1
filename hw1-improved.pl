numeral(0).
numeral(-X)   :- numeral(X).
numeral(p(X)) :- numeral(X).
numeral(s(X)) :- numeral(X).
numeral(X+Y)  :- numeral(X), numeral(Y).
numeral(X-Y)  :- numeral(X), numeral(Y).

% Add function. add(X, Y, Z) must receive X and Y in its simplest form.
add(0, X, X). % Base case: 0+X=X
add(s(X), Y, s(Z)) :- add(X, Y, Z). % Remove s.
add(p(X), Y, p(Z)) :- add(X, Y, Z). % Remove p.

% Add function. add2(X, Y, Z) can process X and Y in complex form.
add2(X, Y, Z) :- simp(X, A), simp(Y, B), add(A, B, C), simp(C, Z).

% Subtract function. subtract(X, Y, Z) returns X-Y in Z.
subtract(X, Y, Z) :- add2(X, -Y, Z).

% Simplify function. simp(X, Z) will return X in its simplest form in Z.
simp(0, 0).         % Base case.
simp(p(0), p(0)).   % Base case.
simp(s(0), s(0)).   % Base case.
simp(p(s(X)), Z)    :- simp(X, Z).  % Cancel p and s.
simp(s(p(X)), Z)    :- simp(X, Z).  % Cancel s and p.
simp(p(p(X)), p(Z)) :- simp(p(X), Z).   % Remove p.
simp(s(s(X)), s(Z)) :- simp(s(X), Z).   % Remove s.
simp(-X, Z)         :- minus(X, A), simp(A, Z).
simp(X+Y, Z)        :- add2(X, Y, Z).
simp(p(X+Y), p(Z))  :- add2(X, Y, Z).
simp(s(X+Y), s(Z))  :- add2(X, Y, Z).
simp(X-Y, Z)        :- subtract(X, Y, Z).
simp(p(X-Y), p(Z))  :- subtract(X, Y, Z).
simp(s(X-Y), s(Z))  :- subtract(X, Y, Z).

% Minus function. minus(X, Z) will return the inverse of X in Z.
minus(X, Z) :- simp(X, A), minusHelper(A, Z).
minusHelper(0, 0). % Base case: 0^(-1)=0
minusHelper(s(X), p(Z)) :- minusHelper(X, Z).   % Change s to p.
minusHelper(p(X), s(Z)) :- minusHelper(X, Z).   % Change p to s.
