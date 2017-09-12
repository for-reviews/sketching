%%%%% ORIGINAL SKETCH RULES %%%%%%
%      :- queen(w,Rw,Cw),queen(b,Rb,Cb),Rw ?= Rb.
%      :- queen(w,Rw,Cw),queen(b,Rb,Cb),Cw ?= Cb.
%      :- queen(w,Rw,Cw),queen(b,Rb,Cb),B_VAR_1 ?= B_VAR_2,?+(Rw,Rb,B_VAR_1),?+(Cw,Cb,B_VAR_2).
%%%%% DOMAIN AND GENERATORS %%%%%%
sketched_clauses(1..3).equalities(eq). equalities(eq).  equalities(leq). 
equalities(geq). equalities(le). equalities(ge). equalities(ne). equalities(unbound).
ops(plus). ops(minus). ops(mult). ops(div). ops(dist).

1 { decision_eq_1(X) :  equalities(X) } 1.
1 { decision_eq_2(X) :  equalities(X) } 1.
1 { decision_eq_3(X) :  equalities(X) } 1.
1 { decision_arithmetic_1(X) :  ops(X) } 1.
1 { decision_arithmetic_2(X) :  ops(X) } 1.

%%%%% NON-EXAMPLES FACTS %%%%%%

%%%%%%  MATERIALIZED EQUALITY %%%%%%
          eq(eq , X, Y) :- X == Y, domain0(X), domain0(Y).
          eq(leq, X, Y) :- X <= Y, domain0(X), domain0(Y).
          eq(geq, X, Y) :- X >= Y, domain0(X), domain0(Y).
          eq(le , X, Y) :- X <  Y, domain0(X), domain0(Y).
          eq(ge , X, Y) :- X >  Y, domain0(X), domain0(Y).
          eq(ne , X, Y) :- X != Y, domain0(X), domain0(Y).
          eq(unbound, X, Y) :- domain0(X), domain0(Y).
      
%%%%%% SET DOMAIN VALUES %%%%%%
domain0(1). domain0(2). domain0(3). domain0(4). domain0(5). domain0(6). domain0(7). domain0(8). domain0(9). domain0(10). 

 %%%%%%  MATERIALIZED ARITHMETIC %%%%%%
          arithmetic(plus, X, Y, Z)  :- Z = X + Y,  domain1(X), domain1(Y).
          arithmetic(minus, X, Y, Z) :- Z = X - Y,  domain1(X), domain1(Y).
          arithmetic(mult, X, Y, Z)  :- Z = X * Y,  domain1(X), domain1(Y).
          arithmetic(div, X, Y, Z)   :- Z = X / Y,  domain1(X), domain1(Y).
          arithmetic(dist, X, Y, Z)  :- Z = |X - Y|,domain1(X), domain1(Y). 
      
%%%%%% SET DOMAIN VALUES %%%%%%
domain1(1). domain1(2). domain1(3). domain1(4). domain1(5). domain1(6). domain1(7). domain1(8). domain1(9). domain1(10). 

examples(E) :- negative(E).
examples(E) :- positive(E).
domain_not(E) :- examples(E).
%%%%% NON-SKETCHED INFERENCE RULES %%%%%%
%%%%% FAILING RULES %%%%%%
fail :- not neg_sat(E), negative(E).
:- fail.
%%%%% SKETCHED INFERENCE RULES %%%%%%
%%%%% POSITIVE SKETCHED RULES %%%%%%
fail :- queen(Eaux,w,Rw,Cw),queen(Eaux,b,Rb,Cb),eq(Q_eq_1,Rw,Rb),decision_eq_1(Q_eq_1),positive(Eaux).
fail :- queen(Eaux,w,Rw,Cw),queen(Eaux,b,Rb,Cb),eq(Q_eq_2,Cw,Cb),decision_eq_2(Q_eq_2),positive(Eaux).
fail :- queen(Eaux,w,Rw,Cw),queen(Eaux,b,Rb,Cb),eq(Q_eq_3,B_VAR_1,B_VAR_2),arithmetic(Q_arithmetic_1,Rw,Rb,B_VAR_1),arithmetic(Q_arithmetic_2,Cw,Cb,B_VAR_2),decision_eq_3(Q_eq_3),decision_arithmetic_1(Q_arithmetic_1),decision_arithmetic_2(Q_arithmetic_2),positive(Eaux).
%%%%% NEGATIVE SKETCHED RULES %%%%%%
neg_sat(Eaux) :- queen(Eaux,w,Rw,Cw),queen(Eaux,b,Rb,Cb),eq(Q_eq_1,Rw,Rb),decision_eq_1(Q_eq_1),negative(Eaux).
neg_sat(Eaux) :- queen(Eaux,w,Rw,Cw),queen(Eaux,b,Rb,Cb),eq(Q_eq_2,Cw,Cb),decision_eq_2(Q_eq_2),negative(Eaux).
neg_sat(Eaux) :- queen(Eaux,w,Rw,Cw),queen(Eaux,b,Rb,Cb),eq(Q_eq_3,B_VAR_1,B_VAR_2),arithmetic(Q_arithmetic_1,Rw,Rb,B_VAR_1),arithmetic(Q_arithmetic_2,Cw,Cb,B_VAR_2),decision_eq_3(Q_eq_3),decision_arithmetic_1(Q_arithmetic_1),decision_arithmetic_2(Q_arithmetic_2),negative(Eaux).
%%%%% EXAMPLES %%%%%%
positive(0). queen(0,w,1,1). queen(0,w,2,2). queen(0,b,3,4). queen(0,b,4,3). 
positive(1). queen(1,b,1,1). queen(1,b,2,2). queen(1,w,3,4). queen(1,w,4,3). 
negative(2). queen(2,w,1,1). queen(2,w,2,2). queen(2,b,3,4). queen(2,b,4,4). 
negative(3). queen(3,b,2,2). queen(3,w,3,1). 
#show neg_sat/1.
#show decision_eq_1/1.
#show decision_eq_2/1.
#show decision_eq_3/1.
#show decision_arithmetic_1/1.
#show decision_arithmetic_2/1.
