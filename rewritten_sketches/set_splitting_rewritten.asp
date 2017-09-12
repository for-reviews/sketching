%%%%% ORIGINAL SKETCH RULES %%%%%%
%      :- sketched_p1(I),sketched_p2(I).
%     good_subset(I1) :- element(I1,X),element(I2,Y),split(X,G),split(Y,H),G ?= H,I1 ?= I2.
%%%%% DOMAIN AND GENERATORS %%%%%%
sketched_clauses(1..2).equalities(eq). equalities(eq).  equalities(leq). 
equalities(geq). equalities(le). equalities(ge). equalities(ne). equalities(unbound).
sketched_p2_choice(c_subset).sketched_p2_choice(c_good_subset).
sketched_p1_choice(c_subset).sketched_p1_choice(c_good_subset).

1 { decision_sketched_p1(X) :  sketched_p1_choice(X) } 1.
1 { decision_sketched_p2(X) :  sketched_p2_choice(X) } 1.
1 { decision_eq_1(X) :  equalities(X) } 1.
1 { decision_eq_2(X) :  equalities(X) } 1.

%%%%%% KEEP DOMAIN INFORMATION ABOUT DECISION VARIABLES %%%%%%
domain_not(X) :- sketched_p1_choice(X).

%%%%% NON-EXAMPLES FACTS %%%%%%
group(0). group(1). set(1). set(2). set(3). set(4). set(5). set(6). element(1,1). element(1,2). element(2,3). element(2,4). element(2,5). element(3,2). element(3,3). element(3,6). element(4,1). element(4,4). element(4,6). element(5,2). element(5,5). 
%%%%%%  MATERIALIZED EQUALITY %%%%%%
          eq(eq , X, Y) :- X == Y, domain0(X), domain0(Y).
          eq(leq, X, Y) :- X <= Y, domain0(X), domain0(Y).
          eq(geq, X, Y) :- X >= Y, domain0(X), domain0(Y).
          eq(le , X, Y) :- X <  Y, domain0(X), domain0(Y).
          eq(ge , X, Y) :- X >  Y, domain0(X), domain0(Y).
          eq(ne , X, Y) :- X != Y, domain0(X), domain0(Y).
          eq(unbound, X, Y) :- domain0(X), domain0(Y).
      
%%%%%% SET DOMAIN VALUES %%%%%%
domain0(0). domain0(1). domain0(2). domain0(3). domain0(4). domain0(5). domain0(6). domain0(7). domain0(8). domain0(9). domain0(10). 

examples(E) :- negative(E).
examples(E) :- positive(E).
domain_not(E) :- examples(E).
sketched_p2(Eaux,c_subset,X0) :- subset(X0),examples(Eaux).
sketched_p2(Eaux,c_good_subset,X0) :- good_subset(Eaux,X0).

sketched_p1(Eaux,c_subset,X0) :- subset(X0),examples(Eaux).
sketched_p1(Eaux,c_good_subset,X0) :- good_subset(Eaux,X0).

%%%%% NON-SKETCHED INFERENCE RULES %%%%%%
subset(I) :- element(I,X),examples(Eaux).
%%%%% FAILING RULES %%%%%%
fail :- not neg_sat(E), negative(E).
:- fail.
%%%%% SKETCHED INFERENCE RULES %%%%%%
good_subset(Eaux,I1) :- element(I1,X),element(I2,Y),split(Eaux,X,G),split(Eaux,Y,H),eq(Q_eq_1,G,H),eq(Q_eq_2,I1,I2),decision_eq_1(Q_eq_1),decision_eq_2(Q_eq_2),examples(Eaux).
%%%%% POSITIVE SKETCHED RULES %%%%%%
fail :- sketched_p1(Eaux,Q_sketched_p1,I),sketched_not_1(Eaux,Not_D1,Q_sketched_p2,I),decision_sketched_p1(Q_sketched_p1),decision_sketched_p2(Q_sketched_p2),positive(Eaux),decision_not_1(Not_D1).
%%%%% NEGATIVE SKETCHED RULES %%%%%%
neg_sat(Eaux) :- sketched_p1(Eaux,Q_sketched_p1,I),sketched_not_1(Eaux,Not_D1,Q_sketched_p2,I),decision_sketched_p1(Q_sketched_p1),decision_sketched_p2(Q_sketched_p2),negative(Eaux),decision_not_1(Not_D1).
%%%%% DECISION ON THE NEGATION %%%%%%
1 { decision_not_1(positive); decision_not_1(negative) } 1.
%%%%% REIFICATION OF THE NEGATION %%%%%%
sketched_not_1(Eaux,positive,Q_sketched_p2,I) :- sketched_p2(Eaux,Q_sketched_p2,I).
sketched_not_1(Eaux,negative,Q_sketched_p2,I) :- not sketched_p2(Eaux,Q_sketched_p2,I),domain_not(I),domain_not(Eaux),domain_not(Q_sketched_p2).
%%%%% DOMAIN OF THE NEGATION %%%%%%
domain_not(0). domain_not(1). domain_not(2). domain_not(3). domain_not(4). domain_not(5). domain_not(6). domain_not(7). domain_not(8). domain_not(9). domain_not(10). domain_not(I) :- sketched_p2(Eaux,Q_sketched_p2,I).
domain_not(Eaux) :- sketched_p2(Eaux,Q_sketched_p2,I).
domain_not(Q_sketched_p2) :- sketched_p2(Eaux,Q_sketched_p2,I).

%%%%% EXAMPLES %%%%%%
positive(0). split(0,1,0). split(0,2,1). split(0,4,1). split(0,6,1). split(0,3,0). split(0,5,0). 
negative(1). split(1,1,0). split(1,2,0). split(1,4,1). split(1,6,1). split(1,3,0). split(1,5,0). 
#show neg_sat/1.
#show decision_sketched_p1/1.
#show decision_sketched_p2/1.
#show decision_eq_1/1.
#show decision_eq_2/1.
#show decision_not_1/1.
