#const k = 1.
edge(a,b). edge(a,c). edge(b,c). edge(c,d). edge(d,a). edge(b,d).

vertex(X) :- edge(X,_).
vertex(Y) :- edge(_,Y).

0 { deleted(X) : vertex(X) } k.

path(X,Y) :- edge(X,Y), not deleted(X), not deleted(Y).
path(X,Y) :- edge(X,Z), path(Z,Y), not deleted(X), not deleted(Y).

:- path(X,X).

#show deleted/1.
