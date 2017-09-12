%%%%% ORIGINAL SKETCH RULES %%%%%%
%      :- sketched_p(X),sketched_q(X).
%%%%% DOMAIN AND GENERATORS %%%%%%
sketched_clauses(1..1).sketched_p_choice(c_vertex).sketched_p_choice(c_covered).
sketched_q_choice(c_vertex).sketched_q_choice(c_covered).

1 { decision_sketched_p(X) :  sketched_p_choice(X) } 1.
1 { decision_sketched_q(X) :  sketched_q_choice(X) } 1.

%%%%%% KEEP DOMAIN INFORMATION ABOUT DECISION VARIABLES %%%%%%
domain_not(X) :- sketched_q_choice(X).

%%%%% NON-EXAMPLES FACTS %%%%%%
edge(a,b). edge(a,c). edge(b,c). edge(b,d). edge(c,d). edge(d,f). 
examples(E) :- negative(E).
examples(E) :- positive(E).
domain_not(E) :- examples(E).
sketched_p(Eaux,c_vertex,X0) :- vertex(X0),examples(Eaux).
sketched_p(Eaux,c_covered,X0) :- covered(Eaux,X0).

sketched_q(Eaux,c_vertex,X0) :- vertex(X0),examples(Eaux).
sketched_q(Eaux,c_covered,X0) :- covered(Eaux,X0).

%%%%% NON-SKETCHED INFERENCE RULES %%%%%%
covered(Eaux,X) :- edge(X,Y),domination_set(Eaux,Y),examples(Eaux).
vertex(X) :- edge(X,_),examples(Eaux).
vertex(X) :- edge(_,X),examples(Eaux).
edge(X,Y) :- edge(Y,X),examples(Eaux).
%%%%% FAILING RULES %%%%%%
fail :- not neg_sat(E), negative(E).
:- fail.
%%%%% SKETCHED INFERENCE RULES %%%%%%
%%%%% POSITIVE SKETCHED RULES %%%%%%
fail :- sketched_p(Eaux,Q_sketched_p,X),sketched_not_1(Eaux,Not_D1,Q_sketched_q,X),decision_sketched_p(Q_sketched_p),decision_sketched_q(Q_sketched_q),positive(Eaux),decision_not_1(Not_D1).
%%%%% NEGATIVE SKETCHED RULES %%%%%%
neg_sat(Eaux) :- sketched_p(Eaux,Q_sketched_p,X),sketched_not_1(Eaux,Not_D1,Q_sketched_q,X),decision_sketched_p(Q_sketched_p),decision_sketched_q(Q_sketched_q),negative(Eaux),decision_not_1(Not_D1).
%%%%% DECISION ON THE NEGATION %%%%%%
1 { decision_not_1(positive); decision_not_1(negative) } 1.
%%%%% REIFICATION OF THE NEGATION %%%%%%
sketched_not_1(Eaux,positive,Q_sketched_q,X) :- sketched_q(Eaux,Q_sketched_q,X).
sketched_not_1(Eaux,negative,Q_sketched_q,X) :- not sketched_q(Eaux,Q_sketched_q,X),domain_not(X),domain_not(Eaux),domain_not(Q_sketched_q).
%%%%% DOMAIN OF THE NEGATION %%%%%%
domain_not(a). domain_not(b). domain_not(c). domain_not(d). domain_not(e). domain_not(f). domain_not(X) :- sketched_q(Eaux,Q_sketched_q,X).
domain_not(Eaux) :- sketched_q(Eaux,Q_sketched_q,X).
domain_not(Q_sketched_q) :- sketched_q(Eaux,Q_sketched_q,X).

%%%%% EXAMPLES %%%%%%
positive(0). domination_set(0,b). domination_set(0,d). 
negative(1). domination_set(1,a). domination_set(1,b). 
#show neg_sat/1.
#show decision_sketched_p/1.
#show decision_sketched_q/1.
#show decision_not_1/1.
