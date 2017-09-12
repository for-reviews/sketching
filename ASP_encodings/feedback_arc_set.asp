#const k = 1.

edge(a,b). 
edge(b,d).
edge(c,a). edge(c,d).
edge(d,e).
edge(e,f).
edge(f,c).

vertex(X) :- edge(X,_).
vertex(Y) :- edge(_,Y).

0 { deleted(X,Y) : edge(X,Y) } k.

path(X,Y) :- edge(X,Y), not deleted(X,Y).
path(X,Y) :- edge(X,Z), path(Z,Y), not deleted(X,Z).

:- path(X,X).

#show deleted/2.
