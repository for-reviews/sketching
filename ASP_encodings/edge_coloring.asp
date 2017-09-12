% search space definitions
1 { colored(X,Y,C) : color(C) } 1 :- edge(X,Y).

% if there are two colors for the same edge => not a model
:- colored(X,Y,C1), colored(X,Y,C2), C1 != C2.
% if adjacent edges have the same color => not a model
:- colored(X,Z,C), colored(Z,Y,C), X != Y.

% auxiliary predicates
edge(Y,X) :- edge(X,Y).
colored(Y,X,C) :- colored(X,Y,C).

% facts
color(r). color(g). color(b).
edge(1,2). edge(2,3). edge(3,4). edge(4,1). edge(2,5). edge(4,5).

#show colored/3.

