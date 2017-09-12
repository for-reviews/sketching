#const k = 3.

edge(a,b). edge(a,c).
edge(b,c). edge(b,d).
edge(c,d).

vertex(X) :- edge(X,_).
vertex(X) :- edge(_,X).
edge(X,Y) :- edge(Y,X).

k { clique(X) : vertex(X) } k.

:- not edge(X,Y), clique(X), clique(Y), X != Y.
