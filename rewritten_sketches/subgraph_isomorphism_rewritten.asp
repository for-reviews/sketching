%%%%% ORIGINAL SKETCH RULES %%%%%%
%      :- map(X,N),map(Y,M),X ?= Y,N ?= M.
%      :- map(X,N),map(Y,M),sketched_p1(X,Y),sketched_p2(N,M).
%%%%% DOMAIN AND GENERATORS %%%%%%
sketched_clauses(1..2).equalities(eq). equalities(eq).  equalities(leq). 
equalities(geq). equalities(le). equalities(ge). equalities(ne). equalities(unbound).
sketched_p1_choice(c_edge1).sketched_p1_choice(c_edge2).
sketched_p2_choice(c_edge1).sketched_p2_choice(c_edge2).

1 { decision_eq_1(X) :  equalities(X) } 1.
1 { decision_eq_2(X) :  equalities(X) } 1.
1 { decision_sketched_p1(X) :  sketched_p1_choice(X) } 1.
1 { decision_sketched_p2(X) :  sketched_p2_choice(X) } 1.

%%%%%% KEEP DOMAIN INFORMATION ABOUT DECISION VARIABLES %%%%%%
domain_not(X) :- sketched_p2_choice(X).

%%%%% NON-EXAMPLES FACTS %%%%%%
edge1(a,b). edge1(a,e). edge1(b,c). edge1(b,d). edge1(d,c). edge1(d,d). edge2(1,1). edge2(1,2). edge2(1,3). edge2(1,4). edge2(2,4). edge2(3,4). edge2(3,5). edge2(5,6). 
%%%%%%  MATERIALIZED EQUALITY %%%%%%
          eq(eq , X, Y) :- X == Y, domain0(X), domain0(Y).
          eq(leq, X, Y) :- X <= Y, domain0(X), domain0(Y).
          eq(geq, X, Y) :- X >= Y, domain0(X), domain0(Y).
          eq(le , X, Y) :- X <  Y, domain0(X), domain0(Y).
          eq(ge , X, Y) :- X >  Y, domain0(X), domain0(Y).
          eq(ne , X, Y) :- X != Y, domain0(X), domain0(Y).
          eq(unbound, X, Y) :- domain0(X), domain0(Y).
      
%%%%%% SET DOMAIN VALUES %%%%%%
domain0(1). domain0(2). domain0(3). domain0(4). domain0(5). domain0(6). domain0(a). domain0(b). domain0(c). domain0(d). domain0(e). 

examples(E) :- negative(E).
examples(E) :- positive(E).
domain_not(E) :- examples(E).
sketched_p1(c_edge1,X0,X1) :- edge1(X0,X1).
sketched_p1(c_edge2,X0,X1) :- edge2(X0,X1).

sketched_p2(c_edge1,X0,X1) :- edge1(X0,X1).
sketched_p2(c_edge2,X0,X1) :- edge2(X0,X1).

%%%%% NON-SKETCHED INFERENCE RULES %%%%%%
edge1(Y,X) :- edge1(X,Y),examples(Eaux).
edge2(Y,X) :- edge2(X,Y),examples(Eaux).
%%%%% FAILING RULES %%%%%%
fail :- not neg_sat(E), negative(E).
:- fail.
%%%%% SKETCHED INFERENCE RULES %%%%%%
%%%%% POSITIVE SKETCHED RULES %%%%%%
fail :- map(Eaux,X,N),map(Eaux,Y,M),eq(Q_eq_1,X,Y),eq(Q_eq_2,N,M),decision_eq_1(Q_eq_1),decision_eq_2(Q_eq_2),positive(Eaux).
fail :- map(Eaux,X,N),map(Eaux,Y,M),sketched_p1(Q_sketched_p1,X,Y),sketched_not_1(Not_D1,Q_sketched_p2,N,M),decision_sketched_p1(Q_sketched_p1),decision_sketched_p2(Q_sketched_p2),positive(Eaux),decision_not_1(Not_D1).
%%%%% NEGATIVE SKETCHED RULES %%%%%%
neg_sat(Eaux) :- map(Eaux,X,N),map(Eaux,Y,M),eq(Q_eq_1,X,Y),eq(Q_eq_2,N,M),decision_eq_1(Q_eq_1),decision_eq_2(Q_eq_2),negative(Eaux).
neg_sat(Eaux) :- map(Eaux,X,N),map(Eaux,Y,M),sketched_p1(Q_sketched_p1,X,Y),sketched_not_1(Not_D1,Q_sketched_p2,N,M),decision_sketched_p1(Q_sketched_p1),decision_sketched_p2(Q_sketched_p2),negative(Eaux),decision_not_1(Not_D1).
%%%%% DECISION ON THE NEGATION %%%%%%
1 { decision_not_1(positive); decision_not_1(negative) } 1.
%%%%% REIFICATION OF THE NEGATION %%%%%%
sketched_not_1(positive,Q_sketched_p2,N,M) :- sketched_p2(Q_sketched_p2,N,M).
sketched_not_1(negative,Q_sketched_p2,N,M) :- not sketched_p2(Q_sketched_p2,N,M),domain_not(N),domain_not(M),domain_not(Q_sketched_p2).
%%%%% DOMAIN OF THE NEGATION %%%%%%
domain_not(1). domain_not(2). domain_not(3). domain_not(4). domain_not(5). domain_not(6). domain_not(a). domain_not(b). domain_not(c). domain_not(d). domain_not(e). domain_not(N) :- sketched_p2(Q_sketched_p2,N,M).
domain_not(M) :- sketched_p2(Q_sketched_p2,N,M).
domain_not(Q_sketched_p2) :- sketched_p2(Q_sketched_p2,N,M).

%%%%% EXAMPLES %%%%%%
positive(0). map(0,d,1). map(0,b,3). map(0,a,5). map(0,c,4). map(0,e,6). 
negative(1). map(1,d,3). map(1,b,1). map(1,a,5). map(1,c,4). map(1,e,6). 
negative(2). map(2,d,1). map(2,b,1). map(2,a,1). map(2,c,1). map(2,e,1). 
#show neg_sat/1.
#show decision_eq_1/1.
#show decision_eq_2/1.
#show decision_sketched_p1/1.
#show decision_sketched_p2/1.
#show decision_not_1/1.
