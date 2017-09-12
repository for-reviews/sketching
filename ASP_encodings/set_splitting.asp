
set(1). set(2). set(3). set(4). set(5). set(6).
element(1,1). element(1,2). 
element(2,3). element(2,4). element(2,5). 
element(3,2). element(3,3). element(3,6). 
element(4,1). element(4,4). element(4,6). 
element(5,2). element(5,5). 

group(0). group(1).

1 { split(X,G) : group(G) } 1 :- set(X).

good_subset(I) :- element(I,X), element(I,Y), split(X,G), split(Y,H), G != H.
subset(I) :- element(I,_).

:- subset(I), not good_subset(I).

#show split/2.
