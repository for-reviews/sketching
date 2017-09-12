link(I) :- interfering(I).
link(I) :- parallel_pairs(P,I,J).
parallel_pairs(P,I,J) :- parallel_pairs(P,J,I).

1 { assigned(I,F) : frequency(F) } 1 :- link(I).

:- pre_assigned(I,F), assigned(I,F1), F != F1.
:- interfering(I), interfering(J), I != J, distance_interfering(D), assigned(I,F1), assigned(J,F2), | F1 - F2 | <= D.
:- parallel_pairs(P,I,J), distance_parallel(D), assigned(I,F1), assigned(J,F2), | F1 - F2 | != D.
:- assigned(I,F1), assigned(J,F2), I != J, F1 = F2.

interfering(1). interfering(2). interfering(3).
parallel_pairs(1,4,5). parallel_pairs(2,7,8).

frequency(10). frequency(20). frequency(30). frequency(40). frequency(50). 
frequency(60). frequency(70). frequency(80). frequency(90). frequency(100). 

pre_assigned(1,10).
pre_assigned(4,60).

distance_interfering(10).
distance_parallel(10).

#show assigned/2.
