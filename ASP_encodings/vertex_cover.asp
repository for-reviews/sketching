#const k = 3.

edge(a,b). edge(a,c).
edge(b,c). edge(b,d).
edge(c,d).

vertex(X) :- edge(X,_).
vertex(X) :- edge(_,X).
edge(X,Y) :- edge(Y,X).

k { vertex_cover(X) : vertex(X) } k.

covered(X,Y) :- edge(X,Y), vertex_cover(X).
covered(Y,X) :- covered(X,Y).

:- edge(X,Y), not covered(X,Y).
