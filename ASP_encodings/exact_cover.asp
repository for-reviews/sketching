set(1). set(2). set(3). set(4).
subsets(o). subsets(p). subsets(e).
element(o,1). element(o,3).
element(p,2). element(p,3).
element(e,2). element(e,4).

0 { selected(X) } 1 :- subsets(X).

covered(X) :- selected(S), element(S,X).

:- set(X), not covered(X).
:- selected(S1), selected(S2), element(S1,X), element(S2,Y), X = Y, S1 != S2. 

