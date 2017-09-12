% This is a clean human readable version of the aggregate sketch for Equal Subset Problem

% possible aggregate choices
aggregates(sum). aggregates(min). aggregates(max). aggregates(count).

% decision on the sketched variables
1 { decision1(X) : aggregates(X) } 1.
1 { decision2(X) : aggregates(X) } 1.

% examples 
positive(0). select_two(0,1). select_one(0,2). select_one(0,3). select_one(0,4). select_one(0,5).  select_one(0,6).
positive(1). select_one(1,1). select_two(1,2). select_two(1,3). select_two(1,4). select_two(1,5).  select_two(1,6).
negative(2). select_one(2,1). select_one(2,2). select_one(2,6). select_two(2,3). select_two(2,4).  select_two(2,5).

% auxiliary predicates to keep indices
examples(E) :- positive(E).
examples(E) :- negative(E).

% problem facts
set(1..5).
value(1,2). value(2,3). value(3,1). value(4,-4). value(5,2). value(6,0).

% skeched predicates reification
aggregate1(E,S,sum) :- S = #sum{   V,X : value(X,V), select_one(E,X) }, examples(E).
aggregate1(E,S,cnt) :- S = #count{ V,X : value(X,V), select_one(E,X) }, examples(E).
aggregate1(E,S,min) :- S = #min{   V,X : value(X,V), select_one(E,X) }, examples(E).
aggregate1(E,S,max) :- S = #max{   V,X : value(X,V), select_one(E,X) }, examples(E).

aggregate2(E,S,sum) :- S = #sum{   V,X : value(X,V), select_two(E,X) }, examples(E).
aggregate2(E,S,cnt) :- S = #count{ V,X : value(X,V), select_two(E,X) }, examples(E).
aggregate2(E,S,min) :- S = #min{   V,X : value(X,V), select_two(E,X) }, examples(E).
aggregate2(E,S,max) :- S = #max{   V,X : value(X,V), select_two(E,X) }, examples(E).

% split constraints

%positive rules
fail :- S1 != S2, aggregate1(E, S1, D1), decision1(D1), aggregate2(E, S2, D2), decision2(D2), positive(E).  
fail :- set(X), not select_one(E,X), not select_two(E,X), positive(E).
fail :- select_one(E,X), select_two(E,X), positive(E).

%negative rules
neg_sat(E) :- S1 != S2, aggregate1(E, S1, D1), decision1(D1), aggregate2(E, S2, D2), decision2(D2), negative(E).  
neg_sat(E) :- set(X), not select_one(E,X), not select_two(E,X), negative(E).
neg_sat(E) :- select_one(E,X), select_two(E,X), negative(E).

% failing conditions
fail :- negative(E), not neg_sat(E).
:- fail.

#show decision1/1.
#show decision2/1.
#show neg_sat/1.
