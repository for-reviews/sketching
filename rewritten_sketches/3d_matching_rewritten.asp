%%%%% ORIGINAL SKETCH RULES %%%%%%
%      :- s(Id1),s(Id2),t(Id1,Indx1,V1),t(Id2,Indx2,V2),Id1 ?= Id2,V1 ?= V2,Indx1 ?= Indx2.
%%%%% DOMAIN AND GENERATORS %%%%%%
sketched_clauses(1..1).equalities(eq). equalities(eq).  equalities(leq). 
equalities(geq). equalities(le). equalities(ge). equalities(ne). equalities(unbound).

1 { decision_eq_1(X) :  equalities(X) } 1.
1 { decision_eq_2(X) :  equalities(X) } 1.
1 { decision_eq_3(X) :  equalities(X) } 1.

%%%%% NON-EXAMPLES FACTS %%%%%%
t(1,1,1). t(1,2,2). t(1,3,2). t(2,1,2). t(2,2,1). t(2,3,1). t(3,1,3). t(3,2,2). t(3,3,3). t(4,1,3). t(4,2,3). t(4,3,4). 
%%%%%%  MATERIALIZED EQUALITY %%%%%%
          eq(eq , X, Y) :- X == Y, domain0(X), domain0(Y).
          eq(leq, X, Y) :- X <= Y, domain0(X), domain0(Y).
          eq(geq, X, Y) :- X >= Y, domain0(X), domain0(Y).
          eq(le , X, Y) :- X <  Y, domain0(X), domain0(Y).
          eq(ge , X, Y) :- X >  Y, domain0(X), domain0(Y).
          eq(ne , X, Y) :- X != Y, domain0(X), domain0(Y).
          eq(unbound, X, Y) :- domain0(X), domain0(Y).
      
%%%%%% SET DOMAIN VALUES %%%%%%
domain0(1). domain0(2). domain0(3). domain0(4). 

examples(E) :- negative(E).
examples(E) :- positive(E).
domain_not(E) :- examples(E).
%%%%% NON-SKETCHED INFERENCE RULES %%%%%%
%%%%% FAILING RULES %%%%%%
fail :- not neg_sat(E), negative(E).
:- fail.
%%%%% SKETCHED INFERENCE RULES %%%%%%
%%%%% POSITIVE SKETCHED RULES %%%%%%
fail :- s(Eaux,Id1),s(Eaux,Id2),t(Id1,Indx1,V1),t(Id2,Indx2,V2),eq(Q_eq_1,Id1,Id2),eq(Q_eq_2,V1,V2),eq(Q_eq_3,Indx1,Indx2),decision_eq_1(Q_eq_1),decision_eq_2(Q_eq_2),decision_eq_3(Q_eq_3),positive(Eaux).
%%%%% NEGATIVE SKETCHED RULES %%%%%%
neg_sat(Eaux) :- s(Eaux,Id1),s(Eaux,Id2),t(Id1,Indx1,V1),t(Id2,Indx2,V2),eq(Q_eq_1,Id1,Id2),eq(Q_eq_2,V1,V2),eq(Q_eq_3,Indx1,Indx2),decision_eq_1(Q_eq_1),decision_eq_2(Q_eq_2),decision_eq_3(Q_eq_3),negative(Eaux).
%%%%% EXAMPLES %%%%%%
positive(0). s(0,2). s(0,3). 
positive(1). s(1,1). s(1,2). s(1,4). 
negative(2). s(2,1). s(2,3). 
negative(3). s(3,3). s(3,4). 
#show neg_sat/1.
#show decision_eq_1/1.
#show decision_eq_2/1.
#show decision_eq_3/1.
