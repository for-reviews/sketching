%%%%% ORIGINAL SKETCH RULES %%%%%%
%      :- cell(X,Y1,N1),cell(X,Y2,N2),Y1 ?= Y2,N1 ?= N2.
%      :- cell(X1,Y,N1),cell(X2,Y,N2),X1 ?= X2,N1 ?= N2.
%%%%% DOMAIN AND GENERATORS %%%%%%
sketched_clauses(1..2).equalities(eq). equalities(eq).  equalities(leq). 
equalities(geq). equalities(le). equalities(ge). equalities(ne). equalities(unbound).

1 { decision_eq_1(X) :  equalities(X) } 1.
1 { decision_eq_2(X) :  equalities(X) } 1.
1 { decision_eq_3(X) :  equalities(X) } 1.
1 { decision_eq_4(X) :  equalities(X) } 1.

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
domain0(1). domain0(2). domain0(3). domain0(a). domain0(b). domain0(c). 

examples(E) :- negative(E).
examples(E) :- positive(E).
domain_not(E) :- examples(E).
%%%%% NON-SKETCHED INFERENCE RULES %%%%%%
%%%%% FAILING RULES %%%%%%
fail :- not neg_sat(E), negative(E).
:- fail.
%%%%% SKETCHED INFERENCE RULES %%%%%%
%%%%% POSITIVE SKETCHED RULES %%%%%%
fail :- cell(Eaux,X,Y1,N1),cell(Eaux,X,Y2,N2),eq(Q_eq_1,Y1,Y2),eq(Q_eq_2,N1,N2),decision_eq_1(Q_eq_1),decision_eq_2(Q_eq_2),positive(Eaux).
fail :- cell(Eaux,X1,Y,N1),cell(Eaux,X2,Y,N2),eq(Q_eq_3,X1,X2),eq(Q_eq_4,N1,N2),decision_eq_3(Q_eq_3),decision_eq_4(Q_eq_4),positive(Eaux).
%%%%% NEGATIVE SKETCHED RULES %%%%%%
neg_sat(Eaux) :- cell(Eaux,X,Y1,N1),cell(Eaux,X,Y2,N2),eq(Q_eq_1,Y1,Y2),eq(Q_eq_2,N1,N2),decision_eq_1(Q_eq_1),decision_eq_2(Q_eq_2),negative(Eaux).
neg_sat(Eaux) :- cell(Eaux,X1,Y,N1),cell(Eaux,X2,Y,N2),eq(Q_eq_3,X1,X2),eq(Q_eq_4,N1,N2),decision_eq_3(Q_eq_3),decision_eq_4(Q_eq_4),negative(Eaux).
%%%%% EXAMPLES %%%%%%
positive(0). cell(0,1,1,a). cell(0,1,2,b). cell(0,1,3,c). cell(0,2,1,c). cell(0,2,2,a). cell(0,2,3,b). cell(0,3,1,b). cell(0,3,2,c). cell(0,3,3,a). 
negative(1). cell(1,1,1,b). cell(1,1,2,a). cell(1,1,3,c). cell(1,2,1,c). cell(1,2,2,a). cell(1,2,3,b). cell(1,3,1,b). cell(1,3,2,c). cell(1,3,3,a). 
negative(2). cell(2,1,1,c). cell(2,1,2,b). cell(2,1,3,c). cell(2,2,1,a). cell(2,2,2,a). cell(2,2,3,b). cell(2,3,1,b). cell(2,3,2,c). cell(2,3,3,a). 
#show neg_sat/1.
#show decision_eq_1/1.
#show decision_eq_2/1.
#show decision_eq_3/1.
#show decision_eq_4/1.
