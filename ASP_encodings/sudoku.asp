% board declaration
row(1..9). column(1..9). number(1..9). 
square(1,1..3,1..3). square(2,1..3,4..6). square(3,1..3,7..9).
square(4,4..6,1..3). square(5,4..6,4..6). square(6,4..6,7..9).
square(7,7..9,1..3). square(8,7..9,4..6). square(9,7..9,7..9).

% define search space
1 { cell(X,Y,N) : number(N) } 1 :- row(X), column(Y).
in_square(S,N) :- cell(X,Y,N), square(S,X,Y).

% actual constraints
:- cell(X,Y1,N), cell(X,Y2,N), Y1 != Y2.
:- cell(X1,Y,N), cell(X2,Y,N), X1 != X2.
fail :- number(N), not in_square(S, N), square(S,_,_).

:- not fail.

#show cell/3.
