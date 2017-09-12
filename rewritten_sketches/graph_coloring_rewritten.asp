%%%%% ORIGINAL SKETCH RULES %%%%%%
%      :- sketched_p1(X,Y),sketched_p2(X,Z),sketched_p3(Y,H),Z ?= H,X ?= Y,X ?= Z,Y ?= Z.
%%%%% DOMAIN AND GENERATORS %%%%%%
sketched_clauses(1..1).equalities(eq). equalities(eq).  equalities(leq). 
equalities(geq). equalities(le). equalities(ge). equalities(ne). equalities(unbound).
sketched_p1_choice(c_edge).sketched_p1_choice(c_color).
sketched_p2_choice(c_edge).sketched_p2_choice(c_color).
sketched_p3_choice(c_edge).sketched_p3_choice(c_color).

1 { decision_sketched_p1(X) :  sketched_p1_choice(X) } 1.
1 { decision_sketched_p2(X) :  sketched_p2_choice(X) } 1.
1 { decision_sketched_p3(X) :  sketched_p3_choice(X) } 1.
1 { decision_eq_1(X) :  equalities(X) } 1.
1 { decision_eq_2(X) :  equalities(X) } 1.
1 { decision_eq_3(X) :  equalities(X) } 1.
1 { decision_eq_4(X) :  equalities(X) } 1.

%%%%% NON-EXAMPLES FACTS %%%%%%
edge(a,b). edge(b,c). edge(c,a). 
%%%%%%  MATERIALIZED EQUALITY %%%%%%
          eq(eq , X, Y) :- X == Y, domain0(X), domain0(Y).
          eq(leq, X, Y) :- X <= Y, domain0(X), domain0(Y).
          eq(geq, X, Y) :- X >= Y, domain0(X), domain0(Y).
          eq(le , X, Y) :- X <  Y, domain0(X), domain0(Y).
          eq(ge , X, Y) :- X >  Y, domain0(X), domain0(Y).
          eq(ne , X, Y) :- X != Y, domain0(X), domain0(Y).
          eq(unbound, X, Y) :- domain0(X), domain0(Y).
      
%%%%%% SET DOMAIN VALUES %%%%%%
domain0(blue). domain0(red). domain0(green). domain0(a). domain0(b). domain0(c). 

examples(E) :- negative(E).
examples(E) :- positive(E).
domain_not(E) :- examples(E).
sketched_p1(Eaux,c_edge,X0,X1) :- edge(X0,X1),examples(Eaux).
sketched_p1(Eaux,c_color,X0,X1) :- color(Eaux,X0,X1).

sketched_p2(Eaux,c_edge,X0,X1) :- edge(X0,X1),examples(Eaux).
sketched_p2(Eaux,c_color,X0,X1) :- color(Eaux,X0,X1).

sketched_p3(Eaux,c_edge,X0,X1) :- edge(X0,X1),examples(Eaux).
sketched_p3(Eaux,c_color,X0,X1) :- color(Eaux,X0,X1).

%%%%% NON-SKETCHED INFERENCE RULES %%%%%%
edge(Y,X) :- edge(X,Y),examples(Eaux).
%%%%% FAILING RULES %%%%%%
fail :- not neg_sat(E), negative(E).
:- fail.
%%%%% SKETCHED INFERENCE RULES %%%%%%
%%%%% POSITIVE SKETCHED RULES %%%%%%
fail :- sketched_p1(Eaux,Q_sketched_p1,X,Y),sketched_p2(Eaux,Q_sketched_p2,X,Z),sketched_p3(Eaux,Q_sketched_p3,Y,H),eq(Q_eq_1,Z,H),eq(Q_eq_2,X,Y),eq(Q_eq_3,X,Z),eq(Q_eq_4,Y,Z),decision_sketched_p1(Q_sketched_p1),decision_sketched_p2(Q_sketched_p2),decision_sketched_p3(Q_sketched_p3),decision_eq_1(Q_eq_1),decision_eq_2(Q_eq_2),decision_eq_3(Q_eq_3),decision_eq_4(Q_eq_4),positive(Eaux).
%%%%% NEGATIVE SKETCHED RULES %%%%%%
neg_sat(Eaux) :- sketched_p1(Eaux,Q_sketched_p1,X,Y),sketched_p2(Eaux,Q_sketched_p2,X,Z),sketched_p3(Eaux,Q_sketched_p3,Y,H),eq(Q_eq_1,Z,H),eq(Q_eq_2,X,Y),eq(Q_eq_3,X,Z),eq(Q_eq_4,Y,Z),decision_sketched_p1(Q_sketched_p1),decision_sketched_p2(Q_sketched_p2),decision_sketched_p3(Q_sketched_p3),decision_eq_1(Q_eq_1),decision_eq_2(Q_eq_2),decision_eq_3(Q_eq_3),decision_eq_4(Q_eq_4),negative(Eaux).
%%%%% EXAMPLES %%%%%%
positive(0). color(0,a,blue). color(0,b,red). color(0,c,green). 
negative(1). color(1,a,blue). color(1,b,red). color(1,c,blue). 
#show neg_sat/1.
#show decision_sketched_p1/1.
#show decision_sketched_p2/1.
#show decision_sketched_p3/1.
#show decision_eq_1/1.
#show decision_eq_2/1.
#show decision_eq_3/1.
#show decision_eq_4/1.
