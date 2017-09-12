node(a). node(b). node(c). node(d).

edge(a,b). edge(a,d).
edge(b,c). edge(b,d).
edge(c,d).

edge(Y,X) :- edge(X,Y).

colors(red). colors(green). colors(blue).

1 { color(X,C) : colors(C) } 1 :- node(X).

:- edge(X,Y), color(X,C1), color(Y,C2), C1 = C2. 

#show color/2.
 
