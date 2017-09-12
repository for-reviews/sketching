%%%%% ORIGINAL SKETCH RULES %%%%%%
%     path(X,Y) :- edge(X,Y),deleted(X),deleted(Y).
%     path(X,Y) :- edge(X,Z),path(Z,Y),deleted(X),deleted(Y).
%      :- path(X,X).
%%%%% DOMAIN AND GENERATORS %%%%%%
sketched_clauses(1..3).

%%%%%% KEEP DOMAIN INFORMATION ABOUT DECISION VARIABLES %%%%%%

%%%%% NON-EXAMPLES FACTS %%%%%%
edge(a,b). edge(a,c). edge(b,c). edge(c,d). edge(d,a). edge(b,d). 
examples(E) :- negative(E).
examples(E) :- positive(E).
domain_not(E) :- examples(E).
%%%%% NON-SKETCHED INFERENCE RULES %%%%%%
%%%%% FAILING RULES %%%%%%
fail :- not neg_sat(E), negative(E).
:- fail.
%%%%% SKETCHED INFERENCE RULES %%%%%%
path(Eaux,X,Y) :- edge(X,Y),sketched_not_1(Eaux,Not_D1,X),sketched_not_2(Eaux,Not_D2,Y),examples(Eaux),decision_not_1(Not_D1),decision_not_2(Not_D2).
path(Eaux,X,Y) :- edge(X,Z),path(Eaux,Z,Y),sketched_not_3(Eaux,Not_D3,X),sketched_not_4(Eaux,Not_D4,Y),examples(Eaux),decision_not_3(Not_D3),decision_not_4(Not_D4).
%%%%% POSITIVE SKETCHED RULES %%%%%%
fail :- sketched_not_5(Eaux,Not_D5,X,X),positive(Eaux),decision_not_5(Not_D5).
%%%%% NEGATIVE SKETCHED RULES %%%%%%
neg_sat(Eaux) :- sketched_not_5(Eaux,Not_D5,X,X),negative(Eaux),decision_not_5(Not_D5).
%%%%% DECISION ON THE NEGATION %%%%%%
1 { decision_not_1(positive); decision_not_1(negative) } 1.
1 { decision_not_2(positive); decision_not_2(negative) } 1.
1 { decision_not_3(positive); decision_not_3(negative) } 1.
1 { decision_not_4(positive); decision_not_4(negative) } 1.
1 { decision_not_5(positive); decision_not_5(negative) } 1.
%%%%% REIFICATION OF THE NEGATION %%%%%%
sketched_not_1(Eaux,positive,X) :- deleted(Eaux,X).
sketched_not_1(Eaux,negative,X) :- not deleted(Eaux,X),domain_not(X),domain_not(Eaux).
sketched_not_2(Eaux,positive,Y) :- deleted(Eaux,Y).
sketched_not_2(Eaux,negative,Y) :- not deleted(Eaux,Y),domain_not(Y),domain_not(Eaux).
sketched_not_3(Eaux,positive,X) :- deleted(Eaux,X).
sketched_not_3(Eaux,negative,X) :- not deleted(Eaux,X),domain_not(X),domain_not(Eaux).
sketched_not_4(Eaux,positive,Y) :- deleted(Eaux,Y).
sketched_not_4(Eaux,negative,Y) :- not deleted(Eaux,Y),domain_not(Y),domain_not(Eaux).
sketched_not_5(Eaux,positive,X,X) :- path(Eaux,X,X).
sketched_not_5(Eaux,negative,X,X) :- not path(Eaux,X,X),domain_not(X),domain_not(X),domain_not(Eaux).
%%%%% DOMAIN OF THE NEGATION %%%%%%
domain_not(a). domain_not(b). domain_not(c). domain_not(d). domain_not(e). domain_not(f). domain_not(X) :- path(Eaux,X,X).
domain_not(X) :- path(Eaux,X,X).
domain_not(Eaux) :- path(Eaux,X,X).

%%%%% EXAMPLES %%%%%%
positive(0). deleted(0,d). 
negative(1). deleted(1,b). 
#show neg_sat/1.
#show decision_not_1/1.
#show decision_not_2/1.
#show decision_not_3/1.
#show decision_not_4/1.
#show decision_not_5/1.
