%%%%% ORIGINAL SKETCH RULES %%%%%%
%     path(X,Y) :- sketched_p1(X,Y),sketched_p2(X,Y).
%     path(X,Y) :- sketched_p1(X,Z),path(Z,Y),sketched_p2(X,Z).
%%%%% DOMAIN AND GENERATORS %%%%%%
sketched_clauses(1..2).sketched_p2_choice(c_edge).sketched_p2_choice(c_deleted).
sketched_p1_choice(c_edge).sketched_p1_choice(c_deleted).

1 { decision_sketched_p1(X) :  sketched_p1_choice(X) } 1.
1 { decision_sketched_p2(X) :  sketched_p2_choice(X) } 1.
1 { decision_sketched_p1(X) :  sketched_p1_choice(X) } 1.
1 { decision_sketched_p2(X) :  sketched_p2_choice(X) } 1.

%%%%%% KEEP DOMAIN INFORMATION ABOUT DECISION VARIABLES %%%%%%
domain_not(X) :- sketched_p1_choice(X).

%%%%% NON-EXAMPLES FACTS %%%%%%
edge(a,b). edge(b,d). edge(c,a). edge(c,d). edge(d,e). edge(e,f). edge(f,c). 
examples(E) :- negative(E).
examples(E) :- positive(E).
domain_not(E) :- examples(E).
sketched_p2(Eaux,c_edge,X0,X1) :- edge(X0,X1),examples(Eaux).
sketched_p2(Eaux,c_deleted,X0,X1) :- deleted(Eaux,X0,X1).

sketched_p1(Eaux,c_edge,X0,X1) :- edge(X0,X1),examples(Eaux).
sketched_p1(Eaux,c_deleted,X0,X1) :- deleted(Eaux,X0,X1).

%%%%% NON-SKETCHED INFERENCE RULES %%%%%%
%%%%% FAILING RULES %%%%%%
fail :- not neg_sat(E), negative(E).
:- fail.
%%%%% SKETCHED INFERENCE RULES %%%%%%
path(Eaux,X,Y) :- sketched_p1(Eaux,Q_sketched_p1,X,Y),sketched_not_1(Eaux,Not_D1,Q_sketched_p2,X,Y),decision_sketched_p1(Q_sketched_p1),decision_sketched_p2(Q_sketched_p2),examples(Eaux),decision_not_1(Not_D1).
path(Eaux,X,Y) :- sketched_p1(Eaux,Q_sketched_p1,X,Z),path(Eaux,Z,Y),sketched_not_2(Eaux,Not_D2,Q_sketched_p2,X,Z),decision_sketched_p1(Q_sketched_p1),decision_sketched_p2(Q_sketched_p2),examples(Eaux),decision_not_2(Not_D2).
%%%%% POSITIVE SKETCHED RULES %%%%%%
fail :- path(Eaux,X,X),positive(Eaux).
%%%%% NEGATIVE SKETCHED RULES %%%%%%
neg_sat(Eaux) :- path(Eaux,X,X),negative(Eaux).
%%%%% DECISION ON THE NEGATION %%%%%%
1 { decision_not_1(positive); decision_not_1(negative) } 1.
1 { decision_not_2(positive); decision_not_2(negative) } 1.
%%%%% REIFICATION OF THE NEGATION %%%%%%
sketched_not_1(Eaux,positive,Q_sketched_p2,X,Y) :- sketched_p2(Eaux,Q_sketched_p2,X,Y).
sketched_not_1(Eaux,negative,Q_sketched_p2,X,Y) :- not sketched_p2(Eaux,Q_sketched_p2,X,Y),domain_not(X),domain_not(Y),domain_not(Eaux),domain_not(Q_sketched_p2).
sketched_not_2(Eaux,positive,Q_sketched_p2,X,Z) :- sketched_p2(Eaux,Q_sketched_p2,X,Z).
sketched_not_2(Eaux,negative,Q_sketched_p2,X,Z) :- not sketched_p2(Eaux,Q_sketched_p2,X,Z),domain_not(X),domain_not(Z),domain_not(Eaux),domain_not(Q_sketched_p2).
%%%%% DOMAIN OF THE NEGATION %%%%%%
domain_not(a). domain_not(b). domain_not(c). domain_not(d). domain_not(e). domain_not(f). domain_not(X) :- sketched_p2(Eaux,Q_sketched_p2,X,Z).
domain_not(Z) :- sketched_p2(Eaux,Q_sketched_p2,X,Z).
domain_not(Eaux) :- sketched_p2(Eaux,Q_sketched_p2,X,Z).
domain_not(Q_sketched_p2) :- sketched_p2(Eaux,Q_sketched_p2,X,Z).

%%%%% EXAMPLES %%%%%%
positive(0). deleted(0,f,c). 
negative(1). deleted(1,b,d). 
#show neg_sat/1.
#show decision_sketched_p1/1.
#show decision_sketched_p2/1.
#show decision_sketched_p1/1.
#show decision_sketched_p2/1.
#show decision_not_1/1.
#show decision_not_2/1.
