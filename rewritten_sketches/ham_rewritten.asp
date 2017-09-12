%%%%% ORIGINAL SKETCH RULES %%%%%%
%      :- sketched_p(Y),sketched_q(Y).
%%%%% DOMAIN AND GENERATORS %%%%%%
sketched_clauses(1..1).sketched_q_choice(c_node).sketched_q_choice(c_reached).
sketched_p_choice(c_node).sketched_p_choice(c_reached).

1 { decision_sketched_p(X) :  sketched_p_choice(X) } 1.
1 { decision_sketched_q(X) :  sketched_q_choice(X) } 1.

%%%%%% KEEP DOMAIN INFORMATION ABOUT DECISION VARIABLES %%%%%%
domain_not(X) :- sketched_p_choice(X).

%%%%% NON-EXAMPLES FACTS %%%%%%
node(a). node(b). node(c). 
examples(E) :- negative(E).
examples(E) :- positive(E).
domain_not(E) :- examples(E).
sketched_q(Eaux,c_node,X0) :- node(X0),examples(Eaux).
sketched_q(Eaux,c_reached,X0) :- reached(Eaux,X0).

sketched_p(Eaux,c_node,X0) :- node(X0),examples(Eaux).
sketched_p(Eaux,c_reached,X0) :- reached(Eaux,X0).

%%%%% NON-SKETCHED INFERENCE RULES %%%%%%
reached(Eaux,Y) :- cycle(Eaux,a,Y),examples(Eaux).
reached(Eaux,Y) :- cycle(Eaux,X,Y),reached(Eaux,X),examples(Eaux).
%%%%% FAILING RULES %%%%%%
fail :- not neg_sat(E), negative(E).
:- fail.
%%%%% SKETCHED INFERENCE RULES %%%%%%
%%%%% POSITIVE SKETCHED RULES %%%%%%
fail :- sketched_p(Eaux,Q_sketched_p,Y),sketched_not_1(Eaux,Not_D1,Q_sketched_q,Y),decision_sketched_p(Q_sketched_p),decision_sketched_q(Q_sketched_q),positive(Eaux),decision_not_1(Not_D1).
%%%%% NEGATIVE SKETCHED RULES %%%%%%
neg_sat(Eaux) :- sketched_p(Eaux,Q_sketched_p,Y),sketched_not_1(Eaux,Not_D1,Q_sketched_q,Y),decision_sketched_p(Q_sketched_p),decision_sketched_q(Q_sketched_q),negative(Eaux),decision_not_1(Not_D1).
%%%%% DECISION ON THE NEGATION %%%%%%
1 { decision_not_1(positive); decision_not_1(negative) } 1.
%%%%% REIFICATION OF THE NEGATION %%%%%%
sketched_not_1(Eaux,positive,Q_sketched_q,Y) :- sketched_q(Eaux,Q_sketched_q,Y).
sketched_not_1(Eaux,negative,Q_sketched_q,Y) :- not sketched_q(Eaux,Q_sketched_q,Y),domain_not(Y),domain_not(Eaux),domain_not(Q_sketched_q).
%%%%% DOMAIN OF THE NEGATION %%%%%%
domain_not(a). domain_not(b). domain_not(c). domain_not(Y) :- sketched_q(Eaux,Q_sketched_q,Y).
domain_not(Eaux) :- sketched_q(Eaux,Q_sketched_q,Y).
domain_not(Q_sketched_q) :- sketched_q(Eaux,Q_sketched_q,Y).

%%%%% EXAMPLES %%%%%%
positive(0). cycle(0,a,b). cycle(0,b,c). cycle(0,c,a). 
negative(1). cycle(1,a,b). cycle(1,b,a). 
#show neg_sat/1.
#show decision_sketched_p/1.
#show decision_sketched_q/1.
#show decision_not_1/1.
