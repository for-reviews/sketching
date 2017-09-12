edge1(a,b). edge1(a,e). edge1(b,c). edge1(b,d). edge1(d,c). edge1(d,d). 
edge2(1,1). edge2(1,2). edge2(1,3). edge2(1,4). edge2(2,4). edge2(3,4). edge2(3,5). edge2(5,6).

vertex1(X) :- edge1(X,Y).
edge1(Y,X) :- edge1(X,Y).

vertex2(X) :- edge2(X,Y).
edge2(Y,X) :- edge2(X,Y).

1 { map(X,N) : vertex2(N) } 1 :- vertex1(X).

:- map(X,N), map(Y,M), X != Y, N = M.
:- map(X,N), map(Y,M), edge1(X,Y), not edge2(N,M).

#show map/2.
