%%%%% ORIGINAL SKETCH RULES %%%%%%
%      :- queen(R1,C1),queen(R2,C2),R1 = R2,C1 ?= C2.
%      :- queen(R1,C1),queen(R2,C2),R1 ?= R2,C1 = C2.
%      :- queen(R1,C1),queen(R2,C2),R1 ?= R2,B_VAR_1 ?= B_VAR_2,?+(R1,R2,B_VAR_1),?+(C1,C2,B_VAR_2).
%%%%% DOMAIN AND GENERATORS %%%%%%
sketched_clauses(1..3).equalities(eq). equalities(eq).  equalities(leq). 
equalities(geq). equalities(le). equalities(ge). equalities(ne). equalities(unbound).
ops(plus). ops(minus). ops(mult). ops(div). ops(dist).

1 { decision_eq_1(X) :  equalities(X) } 1.
1 { decision_eq_2(X) :  equalities(X) } 1.
1 { decision_eq_3(X) :  equalities(X) } 1.
1 { decision_eq_4(X) :  equalities(X) } 1.
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
domain0(-20). domain0(-19). domain0(-18). domain0(-17). domain0(-16). domain0(-15). domain0(-14). domain0(-13). domain0(-12). domain0(-11). domain0(-10). domain0(-9). domain0(-8). domain0(-7). domain0(-6). domain0(-5). domain0(-4). domain0(-3). domain0(-2). domain0(-1). domain0(0). domain0(1). domain0(2). domain0(3). domain0(4). domain0(5). domain0(6). domain0(7). domain0(8). domain0(9). domain0(10). domain0(11). domain0(12). domain0(13). domain0(14). domain0(15). domain0(16). domain0(17). domain0(18). domain0(19). domain0(20). 

 %%%%%%  MATERIALIZED ARITHMETIC %%%%%%
          arithmetic(plus, X, Y, Z)  :- Z = X + Y,  domain1(X), domain1(Y).
          arithmetic(minus, X, Y, Z) :- Z = X - Y,  domain1(X), domain1(Y).
          arithmetic(mult, X, Y, Z)  :- Z = X * Y,  domain1(X), domain1(Y).
          arithmetic(div, X, Y, Z)   :- Z = X / Y,  domain1(X), domain1(Y).
          arithmetic(dist, X, Y, Z)  :- Z = |X - Y|,domain1(X), domain1(Y). 
      
%%%%%% SET DOMAIN VALUES %%%%%%
domain1(-20). domain1(-19). domain1(-18). domain1(-17). domain1(-16). domain1(-15). domain1(-14). domain1(-13). domain1(-12). domain1(-11). domain1(-10). domain1(-9). domain1(-8). domain1(-7). domain1(-6). domain1(-5). domain1(-4). domain1(-3). domain1(-2). domain1(-1). domain1(0). domain1(1). domain1(2). domain1(3). domain1(4). domain1(5). domain1(6). domain1(7). domain1(8). domain1(9). domain1(10). domain1(11). domain1(12). domain1(13). domain1(14). domain1(15). domain1(16). domain1(17). domain1(18). domain1(19). domain1(20). 

examples(E) :- negative(E).
examples(E) :- positive(E).
domain_not(E) :- examples(E).
%%%%% NON-SKETCHED INFERENCE RULES %%%%%%
%%%%% FAILING RULES %%%%%%
fail :- not neg_sat(E), negative(E).
:- fail.
%%%%% SKETCHED INFERENCE RULES %%%%%%
%%%%% POSITIVE SKETCHED RULES %%%%%%
fail :- queen(Eaux,R1,C1),queen(Eaux,R2,C2),R1 = R2,eq(Q_eq_1,C1,C2),decision_eq_1(Q_eq_1),positive(Eaux).
fail :- queen(Eaux,R1,C1),queen(Eaux,R2,C2),eq(Q_eq_2,R1,R2),C1 = C2,decision_eq_2(Q_eq_2),positive(Eaux).
fail :- queen(Eaux,R1,C1),queen(Eaux,R2,C2),eq(Q_eq_3,R1,R2),eq(Q_eq_4,B_VAR_1,B_VAR_2),arithmetic(Q_arithmetic_1,R1,R2,B_VAR_1),arithmetic(Q_arithmetic_2,C1,C2,B_VAR_2),decision_eq_3(Q_eq_3),decision_eq_4(Q_eq_4),decision_arithmetic_1(Q_arithmetic_1),decision_arithmetic_2(Q_arithmetic_2),positive(Eaux).
%%%%% NEGATIVE SKETCHED RULES %%%%%%
neg_sat(Eaux) :- queen(Eaux,R1,C1),queen(Eaux,R2,C2),R1 = R2,eq(Q_eq_1,C1,C2),decision_eq_1(Q_eq_1),negative(Eaux).
neg_sat(Eaux) :- queen(Eaux,R1,C1),queen(Eaux,R2,C2),eq(Q_eq_2,R1,R2),C1 = C2,decision_eq_2(Q_eq_2),negative(Eaux).
neg_sat(Eaux) :- queen(Eaux,R1,C1),queen(Eaux,R2,C2),eq(Q_eq_3,R1,R2),eq(Q_eq_4,B_VAR_1,B_VAR_2),arithmetic(Q_arithmetic_1,R1,R2,B_VAR_1),arithmetic(Q_arithmetic_2,C1,C2,B_VAR_2),decision_eq_3(Q_eq_3),decision_eq_4(Q_eq_4),decision_arithmetic_1(Q_arithmetic_1),decision_arithmetic_2(Q_arithmetic_2),negative(Eaux).
%%%%% EXAMPLES %%%%%%
positive(0). queen(0,1,8). queen(0,2,2). queen(0,3,5). queen(0,4,3). queen(0,5,1). queen(0,6,7). queen(0,7,4). queen(0,8,6). 
positive(1). queen(1,1,2). queen(1,2,5). queen(1,3,7). queen(1,4,1). queen(1,5,3). queen(1,6,8). queen(1,7,6). queen(1,8,4). 
negative(2). queen(2,1,1). queen(2,2,2). queen(2,3,3). queen(2,4,4). 
#show neg_sat/1.
#show decision_eq_1/1.
#show decision_eq_2/1.
#show decision_eq_3/1.
#show decision_eq_4/1.
#show decision_arithmetic_1/1.
#show decision_arithmetic_2/1.
