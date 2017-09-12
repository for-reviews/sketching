#const k=2.

edge(a,b). edge(b,c). edge(c,d). edge(d,e). edge(e,f). edge(f,a).
edge(c,e).

edge(X,Y) :- edge(Y,X).

k { selected(X,Y) : edge(X,Y) } k. % pick k values in the domination set

domination_edge(X,Y) :- selected(X,Y).
domination_edge(Y,X) :- selected(X,Y).

covered(X,Y) :- edge(X,Y), domination_edge(Y,Z).
covered(Y,X) :- covered(X,Y).

fail :- edge(X,Y), not covered(X,Y), not domination_edge(X,Y).
:- not fail.

#show selected/2.
