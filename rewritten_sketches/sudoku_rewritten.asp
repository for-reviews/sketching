%%%%% ORIGINAL SKETCH RULES %%%%%%
%      :- cell(X,Y1,N1),cell(X,Y2,N2),Y1 ?= Y2,N1 ?= N2.
%      :- cell(X1,Y,N1),cell(X2,Y,N2),X1 ?= X2,N1 ?= N2.
%      :- number(N),squares(S),in_square(S,N).
%%%%% DOMAIN AND GENERATORS %%%%%%
sketched_clauses(1..3).equalities(eq). equalities(eq).  equalities(leq). 
equalities(geq). equalities(le). equalities(ge). equalities(ne). equalities(unbound).

1 { decision_eq_1(X) :  equalities(X) } 1.
1 { decision_eq_2(X) :  equalities(X) } 1.
1 { decision_eq_3(X) :  equalities(X) } 1.
1 { decision_eq_4(X) :  equalities(X) } 1.

%%%%%% KEEP DOMAIN INFORMATION ABOUT DECISION VARIABLES %%%%%%

%%%%% NON-EXAMPLES FACTS %%%%%%
row(1). row(2). row(3). row(4). row(5). row(6). row(7). row(8). row(9). column(1). column(2). column(3). column(4). column(5). column(6). column(7). column(8). column(9). number(1). number(2). number(3). number(4). number(5). number(6). number(7). number(8). number(9). squares(1). squares(2). squares(3). squares(4). squares(5). squares(6). squares(7). squares(8). squares(9). square(1,1,1). square(1,1,2). square(1,1,3). square(1,2,1). square(1,2,2). square(1,2,3). square(1,3,1). square(1,3,2). square(1,3,3). square(2,1,4). square(2,1,5). square(2,1,6). square(2,2,4). square(2,2,5). square(2,2,6). square(2,3,4). square(2,3,5). square(2,3,6). square(3,1,7). square(3,1,8). square(3,1,9). square(3,2,7). square(3,2,8). square(3,2,9). square(3,3,7). square(3,3,8). square(3,3,9). square(4,4,1). square(4,4,2). square(4,4,3). square(4,5,1). square(4,5,2). square(4,5,3). square(4,6,1). square(4,6,2). square(4,6,3). square(5,4,4). square(5,4,5). square(5,4,6). square(5,5,4). square(5,5,5). square(5,5,6). square(5,6,4). square(5,6,5). square(5,6,6). square(6,4,7). square(6,4,8). square(6,4,9). square(6,5,7). square(6,5,8). square(6,5,9). square(6,6,7). square(6,6,8). square(6,6,9). square(7,7,1). square(7,7,2). square(7,7,3). square(7,8,1). square(7,8,2). square(7,8,3). square(7,9,1). square(7,9,2). square(7,9,3). square(8,7,4). square(8,7,5). square(8,7,6). square(8,8,4). square(8,8,5). square(8,8,6). square(8,9,4). square(8,9,5). square(8,9,6). square(9,7,7). square(9,7,8). square(9,7,9). square(9,8,7). square(9,8,8). square(9,8,9). square(9,9,7). square(9,9,8). square(9,9,9). 
%%%%%%  MATERIALIZED EQUALITY %%%%%%
          eq(eq , X, Y) :- X == Y, domain0(X), domain0(Y).
          eq(leq, X, Y) :- X <= Y, domain0(X), domain0(Y).
          eq(geq, X, Y) :- X >= Y, domain0(X), domain0(Y).
          eq(le , X, Y) :- X <  Y, domain0(X), domain0(Y).
          eq(ge , X, Y) :- X >  Y, domain0(X), domain0(Y).
          eq(ne , X, Y) :- X != Y, domain0(X), domain0(Y).
          eq(unbound, X, Y) :- domain0(X), domain0(Y).
      
%%%%%% SET DOMAIN VALUES %%%%%%
domain0(-20). domain0(-19). domain0(-18). domain0(-17). domain0(-16). domain0(-15). domain0(-14). domain0(-13). domain0(-12). domain0(-11). domain0(-10). domain0(-9). domain0(-8). domain0(-7). domain0(-6). domain0(-5). domain0(-4). domain0(-3). domain0(-2). domain0(-1). domain0(0). domain0(1). domain0(2). domain0(3). domain0(4). domain0(5). domain0(6). domain0(7). domain0(8). domain0(9). domain0(10). domain0(11). domain0(12). domain0(13). domain0(14). domain0(15). domain0(16). domain0(17). domain0(18). domain0(19). domain0(20). 

examples(E) :- negative(E).
examples(E) :- positive(E).
domain_not(E) :- examples(E).
%%%%% NON-SKETCHED INFERENCE RULES %%%%%%
in_square(Eaux,S,N) :- cell(Eaux,X,Y,N),square(S,X,Y),examples(Eaux).
%%%%% FAILING RULES %%%%%%
fail :- not neg_sat(E), negative(E).
:- fail.
%%%%% SKETCHED INFERENCE RULES %%%%%%
%%%%% POSITIVE SKETCHED RULES %%%%%%
fail :- cell(Eaux,X,Y1,N1),cell(Eaux,X,Y2,N2),eq(Q_eq_1,Y1,Y2),eq(Q_eq_2,N1,N2),decision_eq_1(Q_eq_1),decision_eq_2(Q_eq_2),positive(Eaux).
fail :- cell(Eaux,X1,Y,N1),cell(Eaux,X2,Y,N2),eq(Q_eq_3,X1,X2),eq(Q_eq_4,N1,N2),decision_eq_3(Q_eq_3),decision_eq_4(Q_eq_4),positive(Eaux).
fail :- number(N),squares(S),sketched_not_1(Eaux,Not_D1,S,N),positive(Eaux),decision_not_1(Not_D1).
%%%%% NEGATIVE SKETCHED RULES %%%%%%
neg_sat(Eaux) :- cell(Eaux,X,Y1,N1),cell(Eaux,X,Y2,N2),eq(Q_eq_1,Y1,Y2),eq(Q_eq_2,N1,N2),decision_eq_1(Q_eq_1),decision_eq_2(Q_eq_2),negative(Eaux).
neg_sat(Eaux) :- cell(Eaux,X1,Y,N1),cell(Eaux,X2,Y,N2),eq(Q_eq_3,X1,X2),eq(Q_eq_4,N1,N2),decision_eq_3(Q_eq_3),decision_eq_4(Q_eq_4),negative(Eaux).
neg_sat(Eaux) :- number(N),squares(S),sketched_not_1(Eaux,Not_D1,S,N),negative(Eaux),decision_not_1(Not_D1).
%%%%% DECISION ON THE NEGATION %%%%%%
1 { decision_not_1(positive); decision_not_1(negative) } 1.
%%%%% REIFICATION OF THE NEGATION %%%%%%
sketched_not_1(Eaux,positive,S,N) :- in_square(Eaux,S,N).
sketched_not_1(Eaux,negative,S,N) :- not in_square(Eaux,S,N),domain_not(S),domain_not(N),domain_not(Eaux).
%%%%% DOMAIN OF THE NEGATION %%%%%%
domain_not(-20). domain_not(-19). domain_not(-18). domain_not(-17). domain_not(-16). domain_not(-15). domain_not(-14). domain_not(-13). domain_not(-12). domain_not(-11). domain_not(-10). domain_not(-9). domain_not(-8). domain_not(-7). domain_not(-6). domain_not(-5). domain_not(-4). domain_not(-3). domain_not(-2). domain_not(-1). domain_not(0). domain_not(1). domain_not(2). domain_not(3). domain_not(4). domain_not(5). domain_not(6). domain_not(7). domain_not(8). domain_not(9). domain_not(10). domain_not(11). domain_not(12). domain_not(13). domain_not(14). domain_not(15). domain_not(16). domain_not(17). domain_not(18). domain_not(19). domain_not(20). domain_not(S) :- in_square(Eaux,S,N).
domain_not(N) :- in_square(Eaux,S,N).
domain_not(Eaux) :- in_square(Eaux,S,N).

%%%%% EXAMPLES %%%%%%
positive(0). cell(0,1,1,6). cell(0,1,2,9). cell(0,1,3,7). cell(0,2,1,5). cell(0,2,2,1). cell(0,2,3,8). cell(0,3,1,2). cell(0,3,2,3). cell(0,3,3,4). cell(0,1,4,2). cell(0,1,5,1). cell(0,1,6,5). cell(0,2,4,4). cell(0,2,5,3). cell(0,2,6,6). cell(0,3,4,8). cell(0,3,5,7). cell(0,3,6,9). cell(0,1,7,4). cell(0,1,8,3). cell(0,1,9,8). cell(0,2,7,7). cell(0,2,8,2). cell(0,2,9,9). cell(0,3,7,6). cell(0,3,8,1). cell(0,3,9,5). cell(0,4,1,1). cell(0,4,2,2). cell(0,4,3,3). cell(0,5,1,7). cell(0,5,2,8). cell(0,5,3,9). cell(0,6,1,4). cell(0,6,2,5). cell(0,6,3,6). cell(0,4,4,9). cell(0,4,5,6). cell(0,4,6,4). cell(0,5,4,1). cell(0,5,5,5). cell(0,5,6,3). cell(0,6,4,7). cell(0,6,5,2). cell(0,6,6,8). cell(0,4,7,8). cell(0,4,8,5). cell(0,4,9,7). cell(0,5,7,2). cell(0,5,8,4). cell(0,5,9,6). cell(0,6,7,3). cell(0,6,8,9). cell(0,6,9,1). cell(0,7,1,8). cell(0,7,2,6). cell(0,7,3,5). cell(0,8,1,9). cell(0,8,2,7). cell(0,8,3,2). cell(0,9,1,3). cell(0,9,2,4). cell(0,9,3,1). cell(0,7,4,3). cell(0,7,5,9). cell(0,7,6,2). cell(0,8,4,6). cell(0,8,5,4). cell(0,8,6,1). cell(0,9,4,5). cell(0,9,5,8). cell(0,9,6,7). cell(0,7,7,1). cell(0,7,8,7). cell(0,7,9,4). cell(0,8,7,5). cell(0,8,8,8). cell(0,8,9,3). cell(0,9,7,9). cell(0,9,8,6). cell(0,9,9,2). 
negative(1). cell(1,1,1,5). cell(1,1,2,9). cell(1,1,3,7). cell(1,2,1,6). cell(1,2,2,1). cell(1,2,3,8). cell(1,3,1,2). cell(1,3,2,3). cell(1,3,3,4). cell(1,1,4,2). cell(1,1,5,1). cell(1,1,6,5). cell(1,2,4,4). cell(1,2,5,3). cell(1,2,6,6). cell(1,3,4,8). cell(1,3,5,7). cell(1,3,6,9). cell(1,1,7,4). cell(1,1,8,3). cell(1,1,9,8). cell(1,2,7,7). cell(1,2,8,2). cell(1,2,9,9). cell(1,3,7,6). cell(1,3,8,1). cell(1,3,9,5). cell(1,4,1,1). cell(1,4,2,2). cell(1,4,3,3). cell(1,5,1,7). cell(1,5,2,8). cell(1,5,3,9). cell(1,6,1,4). cell(1,6,2,5). cell(1,6,3,6). cell(1,4,4,9). cell(1,4,5,6). cell(1,4,6,4). cell(1,5,4,1). cell(1,5,5,5). cell(1,5,6,3). cell(1,6,4,7). cell(1,6,5,2). cell(1,6,6,8). cell(1,4,7,8). cell(1,4,8,5). cell(1,4,9,7). cell(1,5,7,2). cell(1,5,8,4). cell(1,5,9,6). cell(1,6,7,3). cell(1,6,8,9). cell(1,6,9,1). cell(1,7,1,8). cell(1,7,2,6). cell(1,7,3,5). cell(1,8,1,9). cell(1,8,2,7). cell(1,8,3,2). cell(1,9,1,3). cell(1,9,2,4). cell(1,9,3,1). cell(1,7,4,3). cell(1,7,5,9). cell(1,7,6,2). cell(1,8,4,6). cell(1,8,5,4). cell(1,8,6,1). cell(1,9,4,5). cell(1,9,5,8). cell(1,9,6,7). cell(1,7,7,1). cell(1,7,8,7). cell(1,7,9,4). cell(1,8,7,5). cell(1,8,8,8). cell(1,8,9,3). cell(1,9,7,9). cell(1,9,8,6). cell(1,9,9,2). 
negative(2). cell(2,1,1,9). cell(2,1,2,6). cell(2,1,3,7). cell(2,2,1,5). cell(2,2,2,1). cell(2,2,3,8). cell(2,3,1,2). cell(2,3,2,3). cell(2,3,3,4). cell(2,1,4,2). cell(2,1,5,1). cell(2,1,6,5). cell(2,2,4,4). cell(2,2,5,3). cell(2,2,6,6). cell(2,3,4,8). cell(2,3,5,7). cell(2,3,6,9). cell(2,1,7,4). cell(2,1,8,3). cell(2,1,9,8). cell(2,2,7,7). cell(2,2,8,2). cell(2,2,9,9). cell(2,3,7,6). cell(2,3,8,1). cell(2,3,9,5). cell(2,4,1,1). cell(2,4,2,2). cell(2,4,3,3). cell(2,5,1,7). cell(2,5,2,8). cell(2,5,3,9). cell(2,6,1,4). cell(2,6,2,5). cell(2,6,3,6). cell(2,4,4,9). cell(2,4,5,6). cell(2,4,6,4). cell(2,5,4,1). cell(2,5,5,5). cell(2,5,6,3). cell(2,6,4,7). cell(2,6,5,2). cell(2,6,6,8). cell(2,4,7,8). cell(2,4,8,5). cell(2,4,9,7). cell(2,5,7,2). cell(2,5,8,4). cell(2,5,9,6). cell(2,6,7,3). cell(2,6,8,9). cell(2,6,9,1). cell(2,7,1,8). cell(2,7,2,6). cell(2,7,3,5). cell(2,8,1,9). cell(2,8,2,7). cell(2,8,3,2). cell(2,9,1,3). cell(2,9,2,4). cell(2,9,3,1). cell(2,7,4,3). cell(2,7,5,9). cell(2,7,6,2). cell(2,8,4,6). cell(2,8,5,4). cell(2,8,6,1). cell(2,9,4,5). cell(2,9,5,8). cell(2,9,6,7). cell(2,7,7,1). cell(2,7,8,7). cell(2,7,9,4). cell(2,8,7,5). cell(2,8,8,8). cell(2,8,9,3). cell(2,9,7,9). cell(2,9,8,6). cell(2,9,9,2). 
#show neg_sat/1.
#show decision_eq_1/1.
#show decision_eq_2/1.
#show decision_eq_3/1.
#show decision_eq_4/1.
#show decision_not_1/1.
