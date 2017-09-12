%%%%% ORIGINAL SKETCH RULES %%%%%%
%      :- pre_assigned(I,F),assigned(I,F1),F ?= F1.
%      :- interfering(I),interfering(J),I != J,distance_interfering(D),assigned(I,F1),assigned(J,F2),B_VAR_1 ?= D,?+(F1,F2,B_VAR_1).
%      :- parallel_pairs(P,I,J),distance_parallel(D),assigned(I,F1),assigned(J,F2),B_VAR_2 ?= D,?+(F1,F2,B_VAR_2).
%%%%% DOMAIN AND GENERATORS %%%%%%
sketched_clauses(1..3).equalities(eq). equalities(eq).  equalities(leq). 
equalities(geq). equalities(le). equalities(ge). equalities(ne). equalities(unbound).
ops(plus). ops(minus). ops(mult). ops(div). ops(dist).

1 { decision_eq_1(X) :  equalities(X) } 1.
1 { decision_eq_2(X) :  equalities(X) } 1.
1 { decision_arithmetic_1(X) :  ops(X) } 1.
1 { decision_eq_3(X) :  equalities(X) } 1.
1 { decision_arithmetic_2(X) :  ops(X) } 1.

%%%%% NON-EXAMPLES FACTS %%%%%%
interfering(1). interfering(2). interfering(3). parallel_pairs(1,4,5). frequency(10). frequency(15). frequency(20). frequency(25). frequency(30). frequency(35). frequency(40). frequency(45). frequency(50). frequency(60). frequency(70). frequency(80). frequency(90). frequency(100). pre_assigned(1,10). pre_assigned(4,60). distance_interfering(15). distance_parallel(10). 
%%%%%%  MATERIALIZED EQUALITY %%%%%%
          eq(eq , X, Y) :- X == Y, domain0(X), domain0(Y).
          eq(leq, X, Y) :- X <= Y, domain0(X), domain0(Y).
          eq(geq, X, Y) :- X >= Y, domain0(X), domain0(Y).
          eq(le , X, Y) :- X <  Y, domain0(X), domain0(Y).
          eq(ge , X, Y) :- X >  Y, domain0(X), domain0(Y).
          eq(ne , X, Y) :- X != Y, domain0(X), domain0(Y).
          eq(unbound, X, Y) :- domain0(X), domain0(Y).
      
%%%%%% SET DOMAIN VALUES %%%%%%
domain0(-100). domain0(-99). domain0(-98). domain0(-97). domain0(-96). domain0(-95). domain0(-94). domain0(-93). domain0(-92). domain0(-91). domain0(-90). domain0(-89). domain0(-88). domain0(-87). domain0(-86). domain0(-85). domain0(-84). domain0(-83). domain0(-82). domain0(-81). domain0(-80). domain0(-79). domain0(-78). domain0(-77). domain0(-76). domain0(-75). domain0(-74). domain0(-73). domain0(-72). domain0(-71). domain0(-70). domain0(-69). domain0(-68). domain0(-67). domain0(-66). domain0(-65). domain0(-64). domain0(-63). domain0(-62). domain0(-61). domain0(-60). domain0(-59). domain0(-58). domain0(-57). domain0(-56). domain0(-55). domain0(-54). domain0(-53). domain0(-52). domain0(-51). domain0(-50). domain0(-49). domain0(-48). domain0(-47). domain0(-46). domain0(-45). domain0(-44). domain0(-43). domain0(-42). domain0(-41). domain0(-40). domain0(-39). domain0(-38). domain0(-37). domain0(-36). domain0(-35). domain0(-34). domain0(-33). domain0(-32). domain0(-31). domain0(-30). domain0(-29). domain0(-28). domain0(-27). domain0(-26). domain0(-25). domain0(-24). domain0(-23). domain0(-22). domain0(-21). domain0(-20). domain0(-19). domain0(-18). domain0(-17). domain0(-16). domain0(-15). domain0(-14). domain0(-13). domain0(-12). domain0(-11). domain0(-10). domain0(-9). domain0(-8). domain0(-7). domain0(-6). domain0(-5). domain0(-4). domain0(-3). domain0(-2). domain0(-1). domain0(0). domain0(1). domain0(2). domain0(3). domain0(4). domain0(5). domain0(6). domain0(7). domain0(8). domain0(9). domain0(10). domain0(11). domain0(12). domain0(13). domain0(14). domain0(15). domain0(16). domain0(17). domain0(18). domain0(19). domain0(20). domain0(21). domain0(22). domain0(23). domain0(24). domain0(25). domain0(26). domain0(27). domain0(28). domain0(29). domain0(30). domain0(31). domain0(32). domain0(33). domain0(34). domain0(35). domain0(36). domain0(37). domain0(38). domain0(39). domain0(40). domain0(41). domain0(42). domain0(43). domain0(44). domain0(45). domain0(46). domain0(47). domain0(48). domain0(49). domain0(50). domain0(51). domain0(52). domain0(53). domain0(54). domain0(55). domain0(56). domain0(57). domain0(58). domain0(59). domain0(60). domain0(61). domain0(62). domain0(63). domain0(64). domain0(65). domain0(66). domain0(67). domain0(68). domain0(69). domain0(70). domain0(71). domain0(72). domain0(73). domain0(74). domain0(75). domain0(76). domain0(77). domain0(78). domain0(79). domain0(80). domain0(81). domain0(82). domain0(83). domain0(84). domain0(85). domain0(86). domain0(87). domain0(88). domain0(89). domain0(90). domain0(91). domain0(92). domain0(93). domain0(94). domain0(95). domain0(96). domain0(97). domain0(98). domain0(99). domain0(100). 

 %%%%%%  MATERIALIZED ARITHMETIC %%%%%%
          arithmetic(plus, X, Y, Z)  :- Z = X + Y,  domain1(X), domain1(Y).
          arithmetic(minus, X, Y, Z) :- Z = X - Y,  domain1(X), domain1(Y).
          arithmetic(mult, X, Y, Z)  :- Z = X * Y,  domain1(X), domain1(Y).
          arithmetic(div, X, Y, Z)   :- Z = X / Y,  domain1(X), domain1(Y).
          arithmetic(dist, X, Y, Z)  :- Z = |X - Y|,domain1(X), domain1(Y). 
      
%%%%%% SET DOMAIN VALUES %%%%%%
domain1(-100). domain1(-99). domain1(-98). domain1(-97). domain1(-96). domain1(-95). domain1(-94). domain1(-93). domain1(-92). domain1(-91). domain1(-90). domain1(-89). domain1(-88). domain1(-87). domain1(-86). domain1(-85). domain1(-84). domain1(-83). domain1(-82). domain1(-81). domain1(-80). domain1(-79). domain1(-78). domain1(-77). domain1(-76). domain1(-75). domain1(-74). domain1(-73). domain1(-72). domain1(-71). domain1(-70). domain1(-69). domain1(-68). domain1(-67). domain1(-66). domain1(-65). domain1(-64). domain1(-63). domain1(-62). domain1(-61). domain1(-60). domain1(-59). domain1(-58). domain1(-57). domain1(-56). domain1(-55). domain1(-54). domain1(-53). domain1(-52). domain1(-51). domain1(-50). domain1(-49). domain1(-48). domain1(-47). domain1(-46). domain1(-45). domain1(-44). domain1(-43). domain1(-42). domain1(-41). domain1(-40). domain1(-39). domain1(-38). domain1(-37). domain1(-36). domain1(-35). domain1(-34). domain1(-33). domain1(-32). domain1(-31). domain1(-30). domain1(-29). domain1(-28). domain1(-27). domain1(-26). domain1(-25). domain1(-24). domain1(-23). domain1(-22). domain1(-21). domain1(-20). domain1(-19). domain1(-18). domain1(-17). domain1(-16). domain1(-15). domain1(-14). domain1(-13). domain1(-12). domain1(-11). domain1(-10). domain1(-9). domain1(-8). domain1(-7). domain1(-6). domain1(-5). domain1(-4). domain1(-3). domain1(-2). domain1(-1). domain1(0). domain1(1). domain1(2). domain1(3). domain1(4). domain1(5). domain1(6). domain1(7). domain1(8). domain1(9). domain1(10). domain1(11). domain1(12). domain1(13). domain1(14). domain1(15). domain1(16). domain1(17). domain1(18). domain1(19). domain1(20). domain1(21). domain1(22). domain1(23). domain1(24). domain1(25). domain1(26). domain1(27). domain1(28). domain1(29). domain1(30). domain1(31). domain1(32). domain1(33). domain1(34). domain1(35). domain1(36). domain1(37). domain1(38). domain1(39). domain1(40). domain1(41). domain1(42). domain1(43). domain1(44). domain1(45). domain1(46). domain1(47). domain1(48). domain1(49). domain1(50). domain1(51). domain1(52). domain1(53). domain1(54). domain1(55). domain1(56). domain1(57). domain1(58). domain1(59). domain1(60). domain1(61). domain1(62). domain1(63). domain1(64). domain1(65). domain1(66). domain1(67). domain1(68). domain1(69). domain1(70). domain1(71). domain1(72). domain1(73). domain1(74). domain1(75). domain1(76). domain1(77). domain1(78). domain1(79). domain1(80). domain1(81). domain1(82). domain1(83). domain1(84). domain1(85). domain1(86). domain1(87). domain1(88). domain1(89). domain1(90). domain1(91). domain1(92). domain1(93). domain1(94). domain1(95). domain1(96). domain1(97). domain1(98). domain1(99). domain1(100). 

examples(E) :- negative(E).
examples(E) :- positive(E).
domain_not(E) :- examples(E).
%%%%% NON-SKETCHED INFERENCE RULES %%%%%%
%%%%% FAILING RULES %%%%%%
fail :- not neg_sat(E), negative(E).
:- fail.
%%%%% SKETCHED INFERENCE RULES %%%%%%
%%%%% POSITIVE SKETCHED RULES %%%%%%
fail :- pre_assigned(I,F),assigned(Eaux,I,F1),eq(Q_eq_1,F,F1),decision_eq_1(Q_eq_1),positive(Eaux).
fail :- interfering(I),interfering(J),I != J,distance_interfering(D),assigned(Eaux,I,F1),assigned(Eaux,J,F2),eq(Q_eq_2,B_VAR_1,D),arithmetic(Q_arithmetic_1,F1,F2,B_VAR_1),decision_eq_2(Q_eq_2),decision_arithmetic_1(Q_arithmetic_1),positive(Eaux).
fail :- parallel_pairs(P,I,J),distance_parallel(D),assigned(Eaux,I,F1),assigned(Eaux,J,F2),eq(Q_eq_3,B_VAR_2,D),arithmetic(Q_arithmetic_2,F1,F2,B_VAR_2),decision_eq_3(Q_eq_3),decision_arithmetic_2(Q_arithmetic_2),positive(Eaux).
%%%%% NEGATIVE SKETCHED RULES %%%%%%
neg_sat(Eaux) :- pre_assigned(I,F),assigned(Eaux,I,F1),eq(Q_eq_1,F,F1),decision_eq_1(Q_eq_1),negative(Eaux).
neg_sat(Eaux) :- interfering(I),interfering(J),I != J,distance_interfering(D),assigned(Eaux,I,F1),assigned(Eaux,J,F2),eq(Q_eq_2,B_VAR_1,D),arithmetic(Q_arithmetic_1,F1,F2,B_VAR_1),decision_eq_2(Q_eq_2),decision_arithmetic_1(Q_arithmetic_1),negative(Eaux).
neg_sat(Eaux) :- parallel_pairs(P,I,J),distance_parallel(D),assigned(Eaux,I,F1),assigned(Eaux,J,F2),eq(Q_eq_3,B_VAR_2,D),arithmetic(Q_arithmetic_2,F1,F2,B_VAR_2),decision_eq_3(Q_eq_3),decision_arithmetic_2(Q_arithmetic_2),negative(Eaux).
%%%%% EXAMPLES %%%%%%
positive(0). assigned(0,1,10). assigned(0,2,40). assigned(0,3,100). assigned(0,4,60). assigned(0,5,70). 
negative(1). assigned(1,1,10). assigned(1,2,15). assigned(1,3,20). assigned(1,4,60). assigned(1,5,70). 
negative(2). assigned(2,1,5). assigned(2,2,40). assigned(2,3,100). assigned(2,4,60). assigned(2,5,70). 
negative(3). assigned(3,1,15). assigned(3,2,40). assigned(3,3,100). assigned(3,4,60). assigned(3,5,70). 
negative(4). assigned(4,1,10). assigned(4,2,40). assigned(4,3,100). assigned(4,4,60). assigned(4,5,65). 
negative(5). assigned(5,1,10). assigned(5,2,40). assigned(5,3,100). assigned(5,4,60). assigned(5,5,85). 
#show neg_sat/1.
#show decision_eq_1/1.
#show decision_eq_2/1.
#show decision_arithmetic_1/1.
#show decision_eq_3/1.
#show decision_arithmetic_2/1.
