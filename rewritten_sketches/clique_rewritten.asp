%%%%% ORIGINAL SKETCH RULES %%%%%%
%      :- not edge(X,Y),sketched_p(X),sketched_q(Y),X ?= Y.
%%%%% DOMAIN AND GENERATORS %%%%%%
sketched_clauses(1..1).equalities(eq). equalities(eq).  equalities(leq). 
equalities(geq). equalities(le). equalities(ge). equalities(ne). equalities(unbound).
sketched_p_choice(c_vertex).sketched_p_choice(c_clique).
sketched_q_choice(c_vertex).sketched_q_choice(c_clique).

1 { decision_sketched_p(X) :  sketched_p_choice(X) } 1.
1 { decision_sketched_q(X) :  sketched_q_choice(X) } 1.
1 { decision_eq_1(X) :  equalities(X) } 1.

%%%%% NON-EXAMPLES FACTS %%%%%%
edge(a,b). edge(a,c). edge(b,c). edge(b,d). edge(c,d). 
%%%%%%  MATERIALIZED EQUALITY %%%%%%
          eq(eq , X, Y) :- X == Y, domain0(X), domain0(Y).
          eq(leq, X, Y) :- X <= Y, domain0(X), domain0(Y).
          eq(geq, X, Y) :- X >= Y, domain0(X), domain0(Y).
          eq(le , X, Y) :- X <  Y, domain0(X), domain0(Y).
          eq(ge , X, Y) :- X >  Y, domain0(X), domain0(Y).
          eq(ne , X, Y) :- X != Y, domain0(X), domain0(Y).
          eq(unbound, X, Y) :- domain0(X), domain0(Y).
      
%%%%%% SET DOMAIN VALUES %%%%%%
domain0(a). domain0(b). domain0(c). domain0(d). 

examples(E) :- negative(E).
examples(E) :- positive(E).
domain_not(E) :- examples(E).
sketched_p(Eaux,c_vertex,X0) :- vertex(X0),examples(Eaux).
sketched_p(Eaux,c_clique,X0) :- clique(Eaux,X0).

sketched_q(Eaux,c_vertex,X0) :- vertex(X0),examples(Eaux).
sketched_q(Eaux,c_clique,X0) :- clique(Eaux,X0).

%%%%% NON-SKETCHED INFERENCE RULES %%%%%%
vertex(X) :- edge(X,_),examples(Eaux).
vertex(X) :- edge(_,X),examples(Eaux).
edge(X,Y) :- edge(Y,X),examples(Eaux).
%%%%% FAILING RULES %%%%%%
fail :- not neg_sat(E), negative(E).
:- fail.
%%%%% SKETCHED INFERENCE RULES %%%%%%
%%%%% POSITIVE SKETCHED RULES %%%%%%
fail :- not edge(X,Y),sketched_p(Eaux,Q_sketched_p,X),sketched_q(Eaux,Q_sketched_q,Y),eq(Q_eq_1,X,Y),decision_sketched_p(Q_sketched_p),decision_sketched_q(Q_sketched_q),decision_eq_1(Q_eq_1),positive(Eaux).
%%%%% NEGATIVE SKETCHED RULES %%%%%%
neg_sat(Eaux) :- not edge(X,Y),sketched_p(Eaux,Q_sketched_p,X),sketched_q(Eaux,Q_sketched_q,Y),eq(Q_eq_1,X,Y),decision_sketched_p(Q_sketched_p),decision_sketched_q(Q_sketched_q),decision_eq_1(Q_eq_1),negative(Eaux).
%%%%% EXAMPLES %%%%%%
positive(0). clique(0,a). clique(0,b). clique(0,c). 
negative(1). clique(1,a). clique(1,d). 
#show neg_sat/1.
#show decision_sketched_p/1.
#show decision_sketched_q/1.
#show decision_eq_1/1.
