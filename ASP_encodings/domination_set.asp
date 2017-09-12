#const k=2.

edge(a,b). edge(a,c).
edge(b,c). edge(b,d).
edge(c,d).
edge(d,h).

vertex(X) :- edge(X,_).
vertex(X) :- edge(_,X).
edge(X,Y) :- edge(Y,X).

k { domination_set(X) : vertex(X) } k. % pick k values in the domination set

covered(X) :- edge(X,Y), domination_set(Y).

:- vertex(X), not covered(X).


