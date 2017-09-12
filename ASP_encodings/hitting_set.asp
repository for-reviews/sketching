#const k=2.

set(1). set(2). set(3). set(4). set(5).
subsets(a). subsets(b). subsets(c). subsets(d). subsets(e).
subset(a,1). subset(a,2). subset(a,3).
subset(b,2). subset(b,5).
subset(c,3). subset(c,4).
subset(d,1). subset(d,3).
subset(e,5).

k { hitting_set(X) : set(X) } k.

covered(S) :- hitting_set(X), subset(S,X).

:- subsets(S), not covered(S).
