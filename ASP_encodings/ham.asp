node(a). node(b). node(c).
edge(a,b). edge(b,c). edge(c,a).

1 { cycle(X,Y) : edge(X,Y) } 1 :- node(X).
1 { cycle(X,Y) : edge(X,Y) } 1 :- node(Y).

reached(Y) :- cycle(a,Y).
reached(Y) :- cycle(X,Y), reached(X).

:- node(Y), not reached(Y).

#show cycle/2.
