%%%%% ORIGINAL SKETCH RULES %%%%%%
%      :- sketched_p1(X,Y),sketched_p2(X,Y).
%%%%% DOMAIN AND GENERATORS %%%%%%
sketched_clauses(1..1).sketched_p1_choice(c_covered).sketched_p1_choice(c_domination_edge).sketched_p1_choice(c_edge).
sketched_p2_choice(c_covered).sketched_p2_choice(c_domination_edge).sketched_p2_choice(c_edge).

1 { decision_sketched_p1(X) :  sketched_p1_choice(X) } 1.
1 { decision_sketched_p2(X) :  sketched_p2_choice(X) } 1.

%%%%%% KEEP DOMAIN INFORMATION ABOUT DECISION VARIABLES %%%%%%
domain_not(X) :- sketched_p2_choice(X).

%%%%% NON-EXAMPLES FACTS %%%%%%
edge(a,b). edge(b,c). edge(c,d). edge(d,e). edge(e,f). edge(f,a). edge(c,e). 
examples(E) :- negative(E).
examples(E) :- positive(E).
domain_not(E) :- examples(E).
sketched_p1(Eaux,c_covered,X0,X1) :- covered(Eaux,X0,X1).
sketched_p1(Eaux,c_domination_edge,X0,X1) :- domination_edge(Eaux,X0,X1).
sketched_p1(Eaux,c_edge,X0,X1) :- edge(X0,X1),examples(Eaux).

sketched_p2(Eaux,c_covered,X0,X1) :- covered(Eaux,X0,X1).
sketched_p2(Eaux,c_domination_edge,X0,X1) :- domination_edge(Eaux,X0,X1).
sketched_p2(Eaux,c_edge,X0,X1) :- edge(X0,X1),examples(Eaux).

%%%%% NON-SKETCHED INFERENCE RULES %%%%%%
covered(Eaux,X,Y) :- edge(X,Y),domination_edge(Eaux,Y,Z),examples(Eaux).
edge(Y,X) :- edge(X,Y),examples(Eaux).
domination_edge(Eaux,Y,X) :- domination_edge(Eaux,X,Y),examples(Eaux).
covered(Eaux,Y,X) :- covered(Eaux,X,Y),examples(Eaux).
%%%%% FAILING RULES %%%%%%
fail :- not neg_sat(E), negative(E).
:- fail.
%%%%% SKETCHED INFERENCE RULES %%%%%%
%%%%% POSITIVE SKETCHED RULES %%%%%%
fail :- sketched_p1(Eaux,Q_sketched_p1,X,Y),sketched_not_1(Eaux,Not_D1,Q_sketched_p2,X,Y),decision_sketched_p1(Q_sketched_p1),decision_sketched_p2(Q_sketched_p2),positive(Eaux),decision_not_1(Not_D1).
%%%%% NEGATIVE SKETCHED RULES %%%%%%
neg_sat(Eaux) :- sketched_p1(Eaux,Q_sketched_p1,X,Y),sketched_not_1(Eaux,Not_D1,Q_sketched_p2,X,Y),decision_sketched_p1(Q_sketched_p1),decision_sketched_p2(Q_sketched_p2),negative(Eaux),decision_not_1(Not_D1).
%%%%% DECISION ON THE NEGATION %%%%%%
1 { decision_not_1(positive); decision_not_1(negative) } 1.
%%%%% REIFICATION OF THE NEGATION %%%%%%
sketched_not_1(Eaux,positive,Q_sketched_p2,X,Y) :- sketched_p2(Eaux,Q_sketched_p2,X,Y).
sketched_not_1(Eaux,negative,Q_sketched_p2,X,Y) :- not sketched_p2(Eaux,Q_sketched_p2,X,Y),domain_not(X),domain_not(Y),domain_not(Eaux),domain_not(Q_sketched_p2).
%%%%% DOMAIN OF THE NEGATION %%%%%%
domain_not(a). domain_not(b). domain_not(c). domain_not(d). domain_not(e). domain_not(f). domain_not(X) :- sketched_p2(Eaux,Q_sketched_p2,X,Y).
domain_not(Y) :- sketched_p2(Eaux,Q_sketched_p2,X,Y).
domain_not(Eaux) :- sketched_p2(Eaux,Q_sketched_p2,X,Y).
domain_not(Q_sketched_p2) :- sketched_p2(Eaux,Q_sketched_p2,X,Y).

%%%%% EXAMPLES %%%%%%
positive(0). domination_edge(0,e,f). domination_edge(0,c,b). 
negative(1). domination_edge(1,a,b). domination_edge(1,a,f). 
#show neg_sat/1.
#show decision_sketched_p1/1.
#show decision_sketched_p2/1.
#show decision_not_1/1.
