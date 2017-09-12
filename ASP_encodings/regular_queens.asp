#const k=8.

k { queen(Row,Col) : col(Col), row(Row) } k. 

col(1..k).
row(1..k).

:- queen(Rw,Cw), queen(Rb,Cb), Rw  = Rb, Cw != Cb.
:- queen(Rw,Cw), queen(Rb,Cb), Rw != Rb, Cw  = Cb.
:- queen(Rw,Cw), queen(Rb,Cb), Rw != Rb, | Rw - Rb | = | Cw - Cb |.

#show queen/2.
