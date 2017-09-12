#const k = 2.

cliques(1..k).

edge(a,b). edge(a,c). edge(a,e). edge(a,f).
edge(b,c). edge(b,d).
edge(c,d).
edge(f,e).

vertex(X) :- edge(X,Y).
edge(Y,X) :- edge(X,Y).

1 { clique(I,X) : cliques(I) } 1 :- vertex(X).

:- not edge(X,Y), clique(I,X), clique(I,Y), X != Y.

#show clique/2.
