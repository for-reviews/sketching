%%%%% ORIGINAL SKETCH RULES %%%%%%
%      :- colored(X1,Y1,C1),colored(X2,Y2,C2),X1 ?= X2,Y1 ?= Y2,C1 ?= C2.
%%%%% DOMAIN AND GENERATORS %%%%%%
sketched_clauses(1..1).equalities(eq). equalities(eq).  equalities(leq). 
equalities(geq). equalities(le). equalities(ge). equalities(ne). equalities(unbound).

1 { decision_eq_1(X) :  equalities(X) } 1.
1 { decision_eq_2(X) :  equalities(X) } 1.
1 { decision_eq_3(X) :  equalities(X) } 1.

%%%%% NON-EXAMPLES FACTS %%%%%%
color(r). color(g). color(b). edge(1,2). edge(2,3). edge(3,4). edge(4,1). edge(2,5). edge(4,5). 
%%%%%%  MATERIALIZED EQUALITY %%%%%%
          eq(eq , X, Y) :- X == Y, domain0(X), domain0(Y).
          eq(leq, X, Y) :- X <= Y, domain0(X), domain0(Y).
          eq(geq, X, Y) :- X >= Y, domain0(X), domain0(Y).
          eq(le , X, Y) :- X <  Y, domain0(X), domain0(Y).
          eq(ge , X, Y) :- X >  Y, domain0(X), domain0(Y).
          eq(ne , X, Y) :- X != Y, domain0(X), domain0(Y).
          eq(unbound, X, Y) :- domain0(X), domain0(Y).
      
%%%%%% SET DOMAIN VALUES %%%%%%
domain0(1). domain0(2). domain0(3). domain0(4). domain0(5). domain0(r). domain0(g). domain0(b). 

examples(E) :- negative(E).
examples(E) :- positive(E).
domain_not(E) :- examples(E).
%%%%% NON-SKETCHED INFERENCE RULES %%%%%%
edge(Y,X) :- edge(X,Y),examples(Eaux).
colored(Eaux,Y,X,C) :- colored(Eaux,X,Y,C),examples(Eaux).
%%%%% FAILING RULES %%%%%%
fail :- not neg_sat(E), negative(E).
:- fail.
%%%%% SKETCHED INFERENCE RULES %%%%%%
%%%%% POSITIVE SKETCHED RULES %%%%%%
fail :- colored(Eaux,X1,Y1,C1),colored(Eaux,X2,Y2,C2),eq(Q_eq_1,X1,X2),eq(Q_eq_2,Y1,Y2),eq(Q_eq_3,C1,C2),decision_eq_1(Q_eq_1),decision_eq_2(Q_eq_2),decision_eq_3(Q_eq_3),positive(Eaux).
%%%%% NEGATIVE SKETCHED RULES %%%%%%
neg_sat(Eaux) :- colored(Eaux,X1,Y1,C1),colored(Eaux,X2,Y2,C2),eq(Q_eq_1,X1,X2),eq(Q_eq_2,Y1,Y2),eq(Q_eq_3,C1,C2),decision_eq_1(Q_eq_1),decision_eq_2(Q_eq_2),decision_eq_3(Q_eq_3),negative(Eaux).
%%%%% EXAMPLES %%%%%%
positive(0). colored(0,1,2,b). colored(0,2,3,r). colored(0,3,4,b). colored(0,1,4,g). colored(0,2,5,g). colored(0,4,5,r). 
negative(1). colored(1,1,2,r). colored(1,2,3,r). colored(1,3,4,b). colored(1,1,4,g). colored(1,2,5,g). colored(1,4,5,r). 
#show neg_sat/1.
#show decision_eq_1/1.
#show decision_eq_2/1.
#show decision_eq_3/1.
