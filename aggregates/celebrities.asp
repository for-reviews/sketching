% This is a clean human readable version of the sketch for the Finding Celebrities Problem

% Problem: Given a list of people at a party and for each person the list of
% people they know at the party, we want to find the celebrities at the party. 
% A celebrity is a person that everybody at the party knows but that 
% only knows other celebrities. At least one celebrity is present at the party.

knows(2,0).
knows(3,0).

knows(0,1).
knows(2,1).
knows(3,1).

knows(0,2).
knows(3,2).


positive(0). celebrity(0,1).
negative(1). celebrity(1,0). celebrity(1,1). celebrity(1,2).

% put all examples into 
examples(E) :- negative(E).
examples(E) :- positive(E).

% auxiliary extract some info
person(X) :- knows(_, X).
person(X) :- knows(X, _).

aggregates(min). aggregates(max). aggregates(count). aggregates(sum). 
1 { decision_num(D)   : aggregates(D) } 1.
1 { decision_knows(D) : aggregates(D) } 1.

aggregate_num(N,sum)   :- N = #sum{   P:person(P) }.
aggregate_num(N,count) :- N = #count{ P:person(P) }.
aggregate_num(N,max)   :- N = #max{   P:person(P) }.
aggregate_num(N,min)   :- N = #min{   P:person(P) }.

aggregate_knows(E,N,C,sum)   :- N = #sum{ P : knows(P, C), person(P) }, celebrity(E,C), examples(E).
aggregate_knows(E,N,C,count) :- N = #count{ P : knows(P, C), person(P) }, celebrity(E,C), examples(E).
aggregate_knows(E,N,C,max)   :- N = #max{ P : knows(P, C), person(P) }, celebrity(E,C), examples(E).
aggregate_knows(E,N,C,min)   :- N = #min{ P : knows(P, C) , person(P) }, celebrity(E,C), examples(E).

num_p(N) :- aggregate_num(N,D), decision_num(D).

fail :- celebrity(E,C),
        person(C),  
        num_p(N),
        aggregate_knows(E,S,C,D), 
        S < N - 1,
        decision_knows(D),
        positive(E).

neg_sat(E) :- celebrity(E,C),
        person(C),  
        num_p(N),
        aggregate_knows(E,S,C,D), 
        S < N - 1,
        decision_knows(D),
        negative(E).

fail :- celebrity(E,C), person(C), not celebrity(E,P), knows(C, P), positive(E).
neg_sat(E) :- celebrity(E,C), person(C), not celebrity(E,P), knows(C, P), negative(E).
fail :- negative(E), not neg_sat(E).
:- fail.

#show decision_num/1.
#show neg_sat/1.
