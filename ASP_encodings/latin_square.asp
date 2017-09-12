% board declaration
row(1..3). column(1..3). letter(a). letter(b). letter(c).

% define search space
1 { cell(X,Y,N) : letter(N) } 1 :- row(X), column(Y).

% actual constraints
:- cell(X,Y1,N), cell(X,Y2,N), Y1 != Y2.
:- cell(X1,Y,N), cell(X2,Y,N), X1 != X2.

% some fixed cells can be put here

#show cell/3.
