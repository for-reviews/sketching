%%%%% ORIGINAL SKETCH RULES %%%%%%
%      :- sketched_p1(X),sketched_p2(X).
%%%%% DOMAIN AND GENERATORS %%%%%%
sketched_clauses(1..1).sketched_p1_choice(c_subsets).sketched_p1_choice(c_covered).
sketched_p2_choice(c_subsets).sketched_p2_choice(c_covered).

1 { decision_sketched_p1(X) :  sketched_p1_choice(X) } 1.
1 { decision_sketched_p2(X) :  sketched_p2_choice(X) } 1.

%%%%%% KEEP DOMAIN INFORMATION ABOUT DECISION VARIABLES %%%%%%
domain_not(X) :- sketched_p2_choice(X).

%%%%% NON-EXAMPLES FACTS %%%%%%
set(1). set(2). set(3). set(4). set(5). subsets(a). subsets(b). subsets(c). subsets(d). subsets(e). subset(a,1). subset(a,2). subset(a,3). subset(b,2). subset(b,5). subset(c,3). subset(c,4). subset(d,1). subset(d,3). subset(e,5). 
examples(E) :- negative(E).
examples(E) :- positive(E).
domain_not(E) :- examples(E).
sketched_p1(Eaux,c_subsets,X0) :- subsets(X0),examples(Eaux).
sketched_p1(Eaux,c_covered,X0) :- covered(Eaux,X0).

sketched_p2(Eaux,c_subsets,X0) :- subsets(X0),examples(Eaux).
sketched_p2(Eaux,c_covered,X0) :- covered(Eaux,X0).

%%%%% NON-SKETCHED INFERENCE RULES %%%%%%
covered(Eaux,S) :- hitting_set(Eaux,X),subset(S,X),examples(Eaux).
%%%%% FAILING RULES %%%%%%
fail :- not neg_sat(E), negative(E).
:- fail.
%%%%% SKETCHED INFERENCE RULES %%%%%%
%%%%% POSITIVE SKETCHED RULES %%%%%%
fail :- sketched_p1(Eaux,Q_sketched_p1,X),sketched_not_1(Eaux,Not_D1,Q_sketched_p2,X),decision_sketched_p1(Q_sketched_p1),decision_sketched_p2(Q_sketched_p2),positive(Eaux),decision_not_1(Not_D1).
%%%%% NEGATIVE SKETCHED RULES %%%%%%
neg_sat(Eaux) :- sketched_p1(Eaux,Q_sketched_p1,X),sketched_not_1(Eaux,Not_D1,Q_sketched_p2,X),decision_sketched_p1(Q_sketched_p1),decision_sketched_p2(Q_sketched_p2),negative(Eaux),decision_not_1(Not_D1).
%%%%% DECISION ON THE NEGATION %%%%%%
1 { decision_not_1(positive); decision_not_1(negative) } 1.
%%%%% REIFICATION OF THE NEGATION %%%%%%
sketched_not_1(Eaux,positive,Q_sketched_p2,X) :- sketched_p2(Eaux,Q_sketched_p2,X).
sketched_not_1(Eaux,negative,Q_sketched_p2,X) :- not sketched_p2(Eaux,Q_sketched_p2,X),domain_not(X),domain_not(Eaux),domain_not(Q_sketched_p2).
%%%%% DOMAIN OF THE NEGATION %%%%%%
domain_not(1). domain_not(2). domain_not(3). domain_not(4). domain_not(5). domain_not(a). domain_not(b). domain_not(c). domain_not(d). domain_not(e). domain_not(X) :- sketched_p2(Eaux,Q_sketched_p2,X).
domain_not(Eaux) :- sketched_p2(Eaux,Q_sketched_p2,X).
domain_not(Q_sketched_p2) :- sketched_p2(Eaux,Q_sketched_p2,X).

%%%%% EXAMPLES %%%%%%
positive(0). hitting_set(0,3). hitting_set(0,5). 
negative(1). hitting_set(1,1). 
#show neg_sat/1.
#show decision_sketched_p1/1.
#show decision_sketched_p2/1.
#show decision_not_1/1.
