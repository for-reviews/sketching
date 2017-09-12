#const k=2.

subsets(w). subsets(o). subsets(p). subsets(e).
element(o,1). element(o,3).
element(p,2). element(p,3).
element(e,2). element(e,4).
element(w,1). element(w,2). element(w,3). element(w,4). 

k { selected(S) : subsets(S) } k.

:- selected(S1), selected(S2), element(S1,X), element(S2,Y), X = Y, S1 != S2. 
