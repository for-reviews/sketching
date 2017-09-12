%%%%% ORIGINAL SKETCH RULES %%%%%%
%      :- edge(X,Y),clique(I,Xi),clique(J,Xj),I ?= J,Xi ?= Xj,X ?= Xi,Y ?= Xj.
%%%%% DOMAIN AND GENERATORS %%%%%%
sketched_clauses(1..1).equalities(eq). equalities(eq).  equalities(leq). 
equalities(geq). equalities(le). equalities(ge). equalities(ne). equalities(unbound).

1 { decision_eq_1(X) :  equalities(X) } 1.
1 { decision_eq_2(X) :  equalities(X) } 1.
1 { decision_eq_3(X) :  equalities(X) } 1.
1 { decision_eq_4(X) :  equalities(X) } 1.

%%%%%% KEEP DOMAIN INFORMATION ABOUT DECISION VARIABLES %%%%%%

%%%%% NON-EXAMPLES FACTS %%%%%%
edge(a,b). edge(a,c). edge(a,e). edge(a,f). edge(b,c). edge(b,d). edge(c,d). edge(f,e). 
%%%%%%  MATERIALIZED EQUALITY %%%%%%
          eq(eq , X, Y) :- X == Y, domain0(X), domain0(Y).
          eq(leq, X, Y) :- X <= Y, domain0(X), domain0(Y).
          eq(geq, X, Y) :- X >= Y, domain0(X), domain0(Y).
          eq(le , X, Y) :- X <  Y, domain0(X), domain0(Y).
          eq(ge , X, Y) :- X >  Y, domain0(X), domain0(Y).
          eq(ne , X, Y) :- X != Y, domain0(X), domain0(Y).
          eq(unbound, X, Y) :- domain0(X), domain0(Y).
      
%%%%%% SET DOMAIN VALUES %%%%%%
domain0(1). domain0(2). domain0(a). domain0(b). domain0(c). domain0(d). domain0(e). domain0(f). 

examples(E) :- negative(E).
examples(E) :- positive(E).
domain_not(E) :- examples(E).
%%%%% NON-SKETCHED INFERENCE RULES %%%%%%
vertex(X) :- edge(X,Y),examples(Eaux).
edge(Y,X) :- edge(X,Y),examples(Eaux).
%%%%% FAILING RULES %%%%%%
fail :- not neg_sat(E), negative(E).
:- fail.
%%%%% SKETCHED INFERENCE RULES %%%%%%
%%%%% POSITIVE SKETCHED RULES %%%%%%
fail :- sketched_not_1(Not_D1,X,Y),clique(Eaux,I,Xi),clique(Eaux,J,Xj),eq(Q_eq_1,I,J),eq(Q_eq_2,Xi,Xj),eq(Q_eq_3,X,Xi),eq(Q_eq_4,Y,Xj),decision_eq_1(Q_eq_1),decision_eq_2(Q_eq_2),decision_eq_3(Q_eq_3),decision_eq_4(Q_eq_4),positive(Eaux),decision_not_1(Not_D1).
%%%%% NEGATIVE SKETCHED RULES %%%%%%
neg_sat(Eaux) :- sketched_not_1(Not_D1,X,Y),clique(Eaux,I,Xi),clique(Eaux,J,Xj),eq(Q_eq_1,I,J),eq(Q_eq_2,Xi,Xj),eq(Q_eq_3,X,Xi),eq(Q_eq_4,Y,Xj),decision_eq_1(Q_eq_1),decision_eq_2(Q_eq_2),decision_eq_3(Q_eq_3),decision_eq_4(Q_eq_4),negative(Eaux),decision_not_1(Not_D1).
%%%%% DECISION ON THE NEGATION %%%%%%
1 { decision_not_1(positive); decision_not_1(negative) } 1.
%%%%% REIFICATION OF THE NEGATION %%%%%%
sketched_not_1(positive,X,Y) :- edge(X,Y).
sketched_not_1(negative,X,Y) :- not edge(X,Y),domain_not(X),domain_not(Y).
%%%%% DOMAIN OF THE NEGATION %%%%%%
domain_not(1). domain_not(2). domain_not(a). domain_not(b). domain_not(c). domain_not(d). domain_not(e). domain_not(f). domain_not(X) :- edge(X,Y).
domain_not(Y) :- edge(X,Y).

%%%%% EXAMPLES %%%%%%
positive(0). clique(0,1,a). clique(0,2,d). clique(0,1,f). clique(0,1,e). clique(0,2,b). clique(0,2,c). 
negative(1). clique(1,1,a). clique(1,1,d). clique(1,1,f). clique(1,1,e). clique(1,2,b). clique(1,2,c). 
#show neg_sat/1.
#show decision_eq_1/1.
#show decision_eq_2/1.
#show decision_eq_3/1.
#show decision_eq_4/1.
#show decision_not_1/1.
