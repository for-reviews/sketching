%%%%% ORIGINAL SKETCH RULES %%%%%%
%      :- sketched_q1(X),sketched_q2(X).
%      :- sketched_p1(S1),sketched_p2(S2),element(S1,X),element(S2,Y),S1 ?= S2,X ?= Y.
%%%%% DOMAIN AND GENERATORS %%%%%%
sketched_clauses(1..2).equalities(eq). equalities(eq).  equalities(leq). 
equalities(geq). equalities(le). equalities(ge). equalities(ne). equalities(unbound).
sketched_p1_choice(c_subsets).sketched_p1_choice(c_selected).
sketched_q2_choice(c_set).sketched_q2_choice(c_covered).
sketched_p2_choice(c_subsets).sketched_p2_choice(c_selected).
sketched_q1_choice(c_set).sketched_q1_choice(c_covered).

1 { decision_sketched_q1(X) :  sketched_q1_choice(X) } 1.
1 { decision_sketched_q2(X) :  sketched_q2_choice(X) } 1.
1 { decision_sketched_p1(X) :  sketched_p1_choice(X) } 1.
1 { decision_sketched_p2(X) :  sketched_p2_choice(X) } 1.
1 { decision_eq_1(X) :  equalities(X) } 1.
1 { decision_eq_2(X) :  equalities(X) } 1.

%%%%%% KEEP DOMAIN INFORMATION ABOUT DECISION VARIABLES %%%%%%
domain_not(X) :- sketched_q1_choice(X).

%%%%% NON-EXAMPLES FACTS %%%%%%
set(1). set(2). set(3). set(4). subsets(o). subsets(p). subsets(e). element(o,1). element(o,3). element(p,2). element(p,3). element(e,2). element(e,4). element(w,1). element(w,2). element(w,3). element(w,4). 
%%%%%%  MATERIALIZED EQUALITY %%%%%%
          eq(eq , X, Y) :- X == Y, domain0(X), domain0(Y).
          eq(leq, X, Y) :- X <= Y, domain0(X), domain0(Y).
          eq(geq, X, Y) :- X >= Y, domain0(X), domain0(Y).
          eq(le , X, Y) :- X <  Y, domain0(X), domain0(Y).
          eq(ge , X, Y) :- X >  Y, domain0(X), domain0(Y).
          eq(ne , X, Y) :- X != Y, domain0(X), domain0(Y).
          eq(unbound, X, Y) :- domain0(X), domain0(Y).
      
%%%%%% SET DOMAIN VALUES %%%%%%
domain0(1). domain0(2). domain0(3). domain0(4). domain0(o). domain0(p). domain0(e). domain0(w). 

examples(E) :- negative(E).
examples(E) :- positive(E).
domain_not(E) :- examples(E).
sketched_p1(Eaux,c_subsets,X0) :- subsets(X0),examples(Eaux).
sketched_p1(Eaux,c_selected,X0) :- selected(Eaux,X0).

sketched_q2(Eaux,c_set,X0) :- set(X0),examples(Eaux).
sketched_q2(Eaux,c_covered,X0) :- covered(Eaux,X0).

sketched_p2(Eaux,c_subsets,X0) :- subsets(X0),examples(Eaux).
sketched_p2(Eaux,c_selected,X0) :- selected(Eaux,X0).

sketched_q1(Eaux,c_set,X0) :- set(X0),examples(Eaux).
sketched_q1(Eaux,c_covered,X0) :- covered(Eaux,X0).

%%%%% NON-SKETCHED INFERENCE RULES %%%%%%
covered(Eaux,X) :- selected(Eaux,S),element(S,X),examples(Eaux).
%%%%% FAILING RULES %%%%%%
fail :- not neg_sat(E), negative(E).
:- fail.
%%%%% SKETCHED INFERENCE RULES %%%%%%
%%%%% POSITIVE SKETCHED RULES %%%%%%
fail :- sketched_q1(Eaux,Q_sketched_q1,X),sketched_not_1(Eaux,Not_D1,Q_sketched_q2,X),decision_sketched_q1(Q_sketched_q1),decision_sketched_q2(Q_sketched_q2),positive(Eaux),decision_not_1(Not_D1).
fail :- sketched_p1(Eaux,Q_sketched_p1,S1),sketched_p2(Eaux,Q_sketched_p2,S2),element(S1,X),element(S2,Y),eq(Q_eq_1,S1,S2),eq(Q_eq_2,X,Y),decision_sketched_p1(Q_sketched_p1),decision_sketched_p2(Q_sketched_p2),decision_eq_1(Q_eq_1),decision_eq_2(Q_eq_2),positive(Eaux).
%%%%% NEGATIVE SKETCHED RULES %%%%%%
neg_sat(Eaux) :- sketched_q1(Eaux,Q_sketched_q1,X),sketched_not_1(Eaux,Not_D1,Q_sketched_q2,X),decision_sketched_q1(Q_sketched_q1),decision_sketched_q2(Q_sketched_q2),negative(Eaux),decision_not_1(Not_D1).
neg_sat(Eaux) :- sketched_p1(Eaux,Q_sketched_p1,S1),sketched_p2(Eaux,Q_sketched_p2,S2),element(S1,X),element(S2,Y),eq(Q_eq_1,S1,S2),eq(Q_eq_2,X,Y),decision_sketched_p1(Q_sketched_p1),decision_sketched_p2(Q_sketched_p2),decision_eq_1(Q_eq_1),decision_eq_2(Q_eq_2),negative(Eaux).
%%%%% DECISION ON THE NEGATION %%%%%%
1 { decision_not_1(positive); decision_not_1(negative) } 1.
%%%%% REIFICATION OF THE NEGATION %%%%%%
sketched_not_1(Eaux,positive,Q_sketched_q2,X) :- sketched_q2(Eaux,Q_sketched_q2,X).
sketched_not_1(Eaux,negative,Q_sketched_q2,X) :- not sketched_q2(Eaux,Q_sketched_q2,X),domain_not(X),domain_not(Eaux),domain_not(Q_sketched_q2).
%%%%% DOMAIN OF THE NEGATION %%%%%%
domain_not(1). domain_not(2). domain_not(3). domain_not(4). domain_not(o). domain_not(p). domain_not(e). domain_not(w). domain_not(X) :- sketched_q2(Eaux,Q_sketched_q2,X).
domain_not(Eaux) :- sketched_q2(Eaux,Q_sketched_q2,X).
domain_not(Q_sketched_q2) :- sketched_q2(Eaux,Q_sketched_q2,X).

%%%%% EXAMPLES %%%%%%
positive(0). selected(0,w). 
positive(1). selected(1,o). selected(1,e). 
negative(2). selected(2,p). selected(2,e). 
negative(3). selected(3,o). 
#show neg_sat/1.
#show decision_sketched_q1/1.
#show decision_sketched_q2/1.
#show decision_sketched_p1/1.
#show decision_sketched_p2/1.
#show decision_eq_1/1.
#show decision_eq_2/1.
#show decision_not_1/1.
