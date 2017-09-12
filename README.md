# SkASP -- Sketched Answer Set Programming
## Structure of the repository

This readme contains examples of sketched answer set programs (*below*), [requirements and how to run guide](https://github.com/for-reviews/sketching#how-to-run-and-requirements), [a note on predefined operators](https://github.com/for-reviews/sketching#domains-of-predefined-sketching-operators), [an example of full sketch rewriting](https://github.com/for-reviews/sketching#full-example-of-rewritten-sketch-black-and-white-queens), and the [table](https://github.com/for-reviews/sketching#full-table-of-sketched-problems) with all sketches, ASP models of the problems, rewritten sketches (into ASP) and links to the descriptions. Also here you can find [proof](proof.pdf) for the rewriting theorem and lemmas. 

The readers interested in runtime results, detailed grounding estimates, feature comparison with ILASP, implemenation details on preferences, applications to query sketching, and other extra questions, we refer to [supplimenatary materials](supplimenatary.pdf).

* **sketches** contains sketches of the most popular NP completed problems and puzzles, such as Set Packing, Hamiltonian Path, Graph Coloring, Graph Clique, Hitting Set, Domination Set, N Queen Problem (regular and black and white versions), Three Dimensional Matching, Sudoku, Subgraph Isomorphism, Radio Frequency Assignment, Vertex Cover, Latin Square, etc. See [the complete table](https://github.com/for-reviews/sketching#full-table-of-sketched-problems) with descriptions below.
* **ASP_encodings** contains ASP encodings for most of the sketched problems
* **rewritten_sketches** contains sketches rewritten into ASP (obtained by running the algorithm on corresponding sketch)

## Dataset overview

In table below, we provide an overview of the dataset and its properties, such the number of sketched variable in each problem and the number of rules, other columns denote the number of particular type of sketched variables, e.g., "# ?not" indicates how many atom with the sketched negation are in the program. Of course, one can introduce a different set of sketched variables for each problem but to give a more complete picture of the experimental settings we describe the dataset as it has been used in the experiments (where the number and position of sketched variables are fixed).


| **Problem** | **# Sketched** | **# ?=** | **# ?+** | **# ?not** | **# ?p** | **# Rules** |
| --- | --- | --- | --- | --- | --- | --- |
| Graph Clique            |        3              |   1  |  0    |    0    |   2   |    4    |
| 3D Matching             |        3              |   3  |  0    |    0    |   0   |    1    |
| Graph Coloring          |        7              |   4  |  0    |    0    |   3   |    2    |
| Domination Set          |        3              |   0  |  0    |    1    |   2   |    5    |
| Exact Cover             |        7              |   2  |  0    |    1    |   4   |    3    |
| Sudoku                  |        5              |   4  |  0    |    1    |   0   |    4    |
| B\&W Queens             |        5              |   3  |  2    |    0    |   0   |    3    |
| Hitting Set             |        3              |   0  |  0    |    1    |   2   |    2    |
| FAP                     |        3              |   0  |  0    |    1    |   2   |    3    |
| Feedback Arc Set        |        4              |   0  |  0    |    2    |   2   |    3    |
| Latin Square            |        4              |   4  |  0    |    0    |   0   |    2    |
| Edge Domination         |        3              |   0  |  0    |    1    |   2   |    5    |
| FAP                     |        5              |   3  |  2    |    0    |   0   |    3    |
| Set Packing             |        4              |   2  |  0    |    0    |   2   |    1    |
| Clique Cover            |        4              |   3  |  0    |    1    |   0   |    3    |
| Feedback Set            |        5              |   0  |  0    |    5    |   0   |    3    |
| Edge Coloring           |        3              |   3  |  0    |    0    |   0   |    3    |
| Set Splitting           |        5              |   2  |  0    |    1    |   2   |    3    |
| N Queens                |        6              |   4  |  2    |    0    |   0   |    3    |
| Vertex Cover            |        3              |   0  |  0    |    1    |   2   |    4    |
| Subgraph Isom-ism       |        5              |   2  |  0    |    1    |   2   |    4    |

## Sketching Examples
Here in the sketches we use the symbol & to join atom and we put [...] around the sketched arithmetic expressions to simplify the parsing. While in the paper we use *default preferences*, here we demonstrate various features of Sketched ASP such as user-defined preferences.

### Clique

Let us start with a classic NP problem of finding a clique of size k, a standard encoding (file [clique.asp](/ASP_encodings/clique.asp)) would look like 
```
#const k = 3.

% pick k vertices as a clique
k { clique(X) : vertex(X) } k.

% if there is no edge between two different nodes in the clique, it's not a solution
:- not edge(X,Y), clique(X), clique(Y), X != Y. % (*)

% facts
edge(a,b). edge(a,c). edge(b,c). edge(b,d). edge(c,d).

% auxilary predicates
vertex(X) :- edge(X,_).
vertex(X) :- edge(_,X).
edge(X,Y) :- edge(Y,X).
```

The idea here is that integrity constraint (\*) is quite complex, so we can learn it from simple examples with the following sketch (file [clique.sasp](/sketches/clique.sasp))
```
[SKETCH]
:- not edge(X,Y) & ?p(X) & ?q(Y) & X ?= Y.

vertex(X) :- edge(X,_).
vertex(X) :- edge(_,X).
edge(X,Y) :- edge(Y,X).

[EXAMPLES]
positive: clique(a). clique(b). clique(c).
negative: clique(a). clique(d).

[SKETCHEDVAR]
?p/1 : vertex, clique
?q/1 : vertex, clique

[DOMAIN]
?= : a,b,c,d

[FACTS]
edge(a,b). edge(a,c).
edge(b,c). edge(b,d).
edge(c,d).

# Optional here to remove solutions like a < b in place of a != b 
[PREFERENCES]
?= : = -> max, != -> max
```

The sketcher's output looks like this:
```
$ python3 sketcher_sources/solver.py sketches/clique.sasp 
solution # 0
decision_eq_1 is ['ne']
decision_sketched_p is ['c_clique']
decision_sketched_q is ['c_clique']
```

The last line of the sketch can be written in full (max is the abbreviated value for maximum priority and the default value is 1) as
```
[PREFERENCES]
?= : = -> 3, != -> 3, < -> 1, > -> 1, <= -> 1, >= -> 1.
```

### Black and White Queens

Let us demonstrate how multiple constraints can be sketched at the same time on the problem of black and white queens (black do not attack black and white do not attack white), as follows (file [queens.sasp](/sketches/queens.sasp))
```
[SKETCH]
:- queen(w,Rw,Cw) & queen(b,Rb,Cb) & Rw ?= Rb.
:- queen(w,Rw,Cw) & queen(b,Rb,Cb) & Cw ?= Cb.
:- queen(w,Rw,Cw) & queen(b,Rb,Cb) & [ Rw ?+ Rb ] ?= [ Cw ?+ Cb ].

[DOMAIN]
?= : 1..10
?+ : 1..10

[FACTS]

[EXAMPLES]
positive: queen(w,1,1). queen(w,2,2). queen(b,3,4). queen(b,4,3). 
positive: queen(b,1,1). queen(b,2,2). queen(w,3,4). queen(w,4,3). 
negative: queen(w,1,1). queen(w,2,2). queen(b,3,4). queen(b,4,4).
negative: queen(b,2,2). queen(w,3,1).
```
Here we see that three constraints have been sketched and with just two negative and two positive examples it can reconstruct all of the predicates correctly.

## Set Packing

The other classical problem is called Set Packing: given a set X and a set of its subsets S, pick k subsets from S in such a way that they are all pairwise disjoint. A canonical ASP encoding (file [set_packing.asp](/ASP_encodings/set_packing.asp)) looks as follows 
```
#const k=2.
% selecting k subsets
k { selected(S) : subsets(S) } k.
% removing models where the selected subsets overlap
:- selected(S1), selected(S2), element(S1,X), element(S2,Y), X = Y, S1 != S2. 
% data
subsets(w). subsets(o). subsets(p). subsets(e).
element(o,1). element(o,3).
element(p,2). element(p,3).
element(e,2). element(e,4).
element(w,1). element(w,2). element(w,3). element(w,4). 
```

The constraint is quite complex and relation between predicates and variables might be unclear for a person new to ASP, so we can quantify this uncertainty as follows (file [set_packing.sasp](/sketches/set_packing.sasp)):
```
[SKETCH]
:- ?p1(S1) & ?p2(S2) & element(S1,X) & element(S2,Y) & S1 ?= S2 & X ?= Y.

[EXAMPLES]
positive:  selected(w).
positive:  selected(o). selected(e).
negative:  selected(p). selected(e).

[SKETCHEDVAR]
?p1/1 : subsets, selected
?p2/1 : subsets, selected

[PREFERENCES]
?= : = -> max, != -> max, unbound -> max.

[DOMAIN]
?= : 1, 2, 3, 4, o, p, e, w

[FACTS]
subsets(o). subsets(p). subsets(e).
element(o,1). element(o,3).
element(p,2). element(p,3).
element(e,2). element(e,4).
element(w,1). element(w,2). element(w,3). element(w,4). 
```
Here we showed that we uncertain of predicates and relationships between variables, also indicated that we don't expect less or more to be in place of ?=. The meaning of "unbound" is two variables are not connected, so simply speaking this replaces A ?= B with True in case of "unbound".


## Three dimensional matching 

A classical NP complete problem, where one needs to find triples in such a way that they don't intersect on any of the dimensions, see the Wikipedia figure 

3-dimensional matchings. (a) Input T. (b)–(c) Solutions.
![3 dimensional matching](/figures/3-dimensional-matching.png?raw=true)

For details we refer to [3d matching in Wikipedia](https://en.wikipedia.org/wiki/3-dimensional_matching)

The idea is, we know that some constrain should hold between two triplets, but we are not sure exactly what should happen (file [3d_matching.sasp](/sketches/3d_matching.sasp))
```
[SKETCH]
:- s(Id1) & s(Id2) & t(Id1,Indx1,V1) & t(Id2,Indx2,V2) & Id1 ?= Id2 & V1 ?= V2 & Indx1 ?= Indx2.

[EXAMPLES]
positive: s(2). s(3).
positive: s(1). s(2). s(4).
negative: s(1). s(3).
negative: s(3). s(4).

[DOMAIN]
?= : 1, 2, 3, 4

[FACTS]
t(1,1,1). t(1,2,2). t(1,3,2).
t(2,1,2). t(2,2,1). t(2,3,1).
t(3,1,3). t(3,2,2). t(3,3,3).
t(4,1,3). t(4,2,3). t(4,3,4).

[PREFERENCES]
?= : = -> max, != -> max, unbound -> max.
```
Given a couple of negative and positive examples, we correctly reconstruct the solution

**Output:**
```
$ python3 sketcher_sources/solver.py sketches/3d_matching.sasp 
solution # 0
decision_eq_1 is ['ne']
decision_eq_2 is ['eq']
decision_eq_3 is ['eq']
```
## Graph Coloring

Let's start with a canonical constraint for graph coloring:
```
:- edge(X,Y), color(X,C1), color(Y,C2), C1 = C2.
```
It says that two adjacent nodes must be of two different colors


Let's try to consider an extreme case of sketching, we are unsure of all predicates and of all relationships between all variables (file [graph_coloring.sasp](/sketches/graph_coloring.sasp)):
```
[SKETCH]
:- ?p1(X,Y) & ?p2(X,Z) & ?p3(Y,H) & Z ?= H & X ?= Y & X ?= Z & Y ?= Z.
edge(Y,X) :- edge(X,Y).

[EXAMPLES]
positive: color(a,blue). color(b,red). color(c,green).
negative: color(a,blue). color(b,red). color(c,blue).

[SKETCHEDVAR]
?p1/2 : edge, color
?p2/2 : edge, color
?p3/2 : edge, color

[DOMAIN]
?= : blue, red, green, a, b, c

[FACTS]
edge(a,b). edge(b,c). edge(c,a).

# It removes ~300 dominated solutions here
[PREFERENCES]
?= : = -> max, != -> max.
```
What is interesting, it is enough to specify one positive and one negative example to reconstruct original constraint exactly, also a simple preference statement allows to eliminate all non-dominant (~300 solutions) and the system outputs only one solution which is correct.
```
python3 sketcher_sources/solver.py sketches/graph_coloring.sasp 
solution # 0
decision_eq_1 is ['eq']
decision_eq_2 is ['ne']
decision_eq_3 is ['ne']
decision_eq_4 is ['ne']
decision_sketched_p1 is ['c_edge']
decision_sketched_p2 is ['c_color']
decision_sketched_p3 is ['c_color']
```

## Hamiltonian Path

A classical encoding for the Hamiltonian Path (the ASP encoding is due to the book [Answer Set Solving in Practice](http://potassco.sourceforge.net/book.html)) looks like 

```
1 { cycle (X,Y) : edge (X,Y) } 1 :- node(X).
1 { cycle (X,Y) : edge (X,Y) } 1 :- node(Y).

reached(Y) :- cycle(a, Y).
reached(Y) :- cycle(X, Y), reached(X).

:- node(Y), not reached(Y).
```

We will sketch the last integrity constraint (file [ham.sasp](/sketches/ham.sasp)), note that we also sketch negation here by using ?not keyword
```
[SKETCH]
reached(Y) :- cycle(a, Y).
reached(Y) :- cycle(X, Y) & reached(X).
:- ?p(Y) & ?not ?q(Y).

[EXAMPLES]
positive: cycle(a,b). cycle(b,c). cycle(c,a).
negative: cycle(a,b). cycle(b,a).

[SKETCHEDVAR]
?p/1 : node, reached
?q/1 : node, reached

[FACTS]
node(a). node(b). node(c).

[DOMAIN]
not : a,b,c
```

## Subgraph Isomorphism
Here we present a sketch for a well known problem called subgraph isomorphism that has great practical value in the field of structured pattern mining.

The sketch is targeted towards two constraints: the mapping must be injective the first sketched clause and second must preserve the edges. As we can see with just one positive and two negative examples it can find complex structure involving negation and inequalities as well as sketched predicates in the clauses. The sketch and the corresponding ASP encoding can be found in the files [subgraph_isomorphism.sasp](sketches/subgraph_isomorphism.sasp) and [subgraph_isomorphism.asp](ASP_encodings/subgraph_isomorphism.asp)
```
[SKETCH]
:- map(X,N) & map(Y,M) & X ?= Y & N ?= M.
:- map(X,N) & map(Y,M) & ?p1(X,Y) & ?not ?p2(N,M).

%auxilary predicates
edge1(Y,X) :- edge1(X,Y).
edge2(Y,X) :- edge2(X,Y).

[EXAMPLES]
positive: map(d,1). map(b,3). map(a,5). map(c,4). map(e,6).
negative: map(d,3). map(b,1). map(a,5). map(c,4). map(e,6).
negative: map(d,1). map(b,1). map(a,1). map(c,1). map(e,1).

[SKETCHEDVAR]
?p1/2 : edge1, edge2
?p2/2 : edge1, edge2

[FACTS]
edge1(a,b). edge1(a,e). edge1(b,c). edge1(b,d). edge1(d,c). edge1(d,d). 
edge2(1,1). edge2(1,2). edge2(1,3). edge2(1,4). edge2(2,4). edge2(3,4). edge2(3,5). edge2(5,6).

[DOMAIN]
?= : 1,2,3,4,5,6,a,b,c,d,e
not : 1,2,3,4,5,6,a,b,c,d,e

[PREFERENCES]
?= : = -> max, != -> max, unbound -> max.
```

## Domination Set 

The same problem can be seen in the other classical NP problem of Domination Set, where one need to find k vertices in such a way that each other vertex is adjacent to at least one in the domination set. A canonical ASP encoding (file [domination_set.asp](/ASP_encodings/domination_set.asp)) looks like this

```
#const k=2.

edge(a,b). edge(a,c).
edge(b,c). edge(b,d).
edge(c,d).
edge(d,h).

vertex(X) :- edge(X,_).
vertex(X) :- edge(_,X).
edge(X,Y) :- edge(Y,X).

k { domination_set(X) : vertex(X) } k. % pick k values in the domination set

covered(X) :- edge(X,Y), domination_set(Y).

:- vertex(X), not covered(X).
```

Then we would sketch the last constraint as (file [domination_set.sasp](/sketches/domination_set.sasp)):
```
[SKETCH]
:- ?p(X) & ?not ?q(X).

covered(X) :- edge(X,Y) & domination_set(Y).
vertex(X)  :- edge(X,_).
vertex(X)  :- edge(_,X).
edge(X,Y)  :- edge(Y,X).

[EXAMPLES]
positive: domination_set(b). domination_set(d).
negative: domination_set(a). domination_set(b).

[SKETCHEDVAR]
?p/1 : vertex, covered
?q/1 : vertex, covered

[DOMAIN]
not : a,b,c,d,e,f

[FACTS]
edge(a,b). edge(a,c).
edge(b,c). edge(b,d).
edge(c,d).
edge(d,f).

```
## Exact Cover

To cover exact cover problem (file [exact_cover.asp](/ASP_encodings/exact_cover.asp)), we need to sketch two ASP constraints (as shown in the encoding below) and state examples over two predicates

```
0 { selected(X) } 1 :- subsets(X).

covered(X) :- selected(S), element(S,X).

:- set(X), not covered(X).
:- selected(S1), selected(S2), element(S1,X), element(S2,Y), X = Y, S1 != S2. 

%Facts
set(1). set(2). set(3). set(4).
subsets(o). subsets(p). subsets(e).
element(o,1). element(o,3).
element(p,2). element(p,3).
element(e,2). element(e,4).
```
The sketch looks (file [exact_cover.sasp](/sketches/exact_cover.sasp)) as follows
```
[SKETCH]
:- ?q1(X) & ?not ?q2(X).
:- ?p1(S1) & ?p2(S2) & element(S1,X) & element(S2,Y) & S1 ?= S2 & X ?= Y.
covered(X) :- selected(S) & element(S,X).

[SKETCHEDVAR]
?p1/1 : subsets, selected
?p2/1 : subsets, selected
?q1/1 : set, covered
?q2/1 : set, covered

[DOMAIN]
?=  : 1,2,3,4,o,p,e,w
not : 1,2,3,4,o,p,e,w

[FACTS]
set(1). set(2). set(3). set(4).
subsets(o). subsets(p). subsets(e).
element(o,1). element(o,3).
element(p,2). element(p,3).
element(e,2). element(e,4).
element(w,1). element(w,2). element(w,3). element(w,4). 

[EXAMPLES]
positive:  selected(w). 
positive:  selected(o). selected(e). 
negative:  selected(p). selected(e). 
negative:  selected(o). 

[PREFERENCES]
?= : = -> max, != -> max.
```
This again finds a unique right solution (all dominant solution being effectively suppressed by the preferences)

## Latin Square
It is a famous problem of arranging letters on a square in such a way that each row and each column do not repeat the letters. See as an example the figure below.


![Latin Square](/figures/latin_square.png?raw=true)


An ASP encoding and the sketch can be found in the files [latin_square.asp](/ASP_encodings/latin_square.asp)  and [latin_square.sasp](/sketches/latin_square.sasp) correspondingly. Let us demonstrate the sketch here:
```
[SKETCH]
% something should happen to the values in the same rows
 :- cell(X,Y1,N1) & cell(X,Y2,N2) & Y1 ?= Y2 & N1 ?= N2.
% something should happen to the values in the same columns
 :- cell(X1,Y,N1) & cell(X2,Y,N2) & X1 ?= X2 & N1 ?= N2.

[EXAMPLES]
positive: cell(1,1,a). cell(1,2,b). cell(1,3,c). cell(2,1,c). cell(2,2,a). cell(2,3,b). cell(3,1,b). cell(3,2,c). cell(3,3,a).
negative: cell(1,1,b). cell(1,2,a). cell(1,3,c). cell(2,1,c). cell(2,2,a). cell(2,3,b). cell(3,1,b). cell(3,2,c). cell(3,3,a).
negative: cell(1,1,c). cell(1,2,b). cell(1,3,c). cell(2,1,a). cell(2,2,a). cell(2,3,b). cell(3,1,b). cell(3,2,c). cell(3,3,a).

[DOMAIN]
?= : 1,2,3,a,b,c

[FACTS]

[PREFERENCES]
?= : = -> max, != -> max, unbound -> max.
```

# Sudoku

For the Sudoku puzzle, we followed the representation and modeling from the [introductory ASP course](http://ceur-ws.org/Vol-1145/tutorial1.pdf) by prof. Steffen Hölldobler. 


The full sketch for Sudoku and the ASP can be found in the files [sudoku.sasp](/sketches/sudoku.sasp) and [sudoku.asp](/ASP_encodings/sudoku.asp) respectively, here let us just indicate how we need to modify the previous sketch of Latin Square to model Sudoku:
```
[SKETCH]
% something should happen to the values in the same rows
 :- cell(X,Y1,N1) & cell(X,Y2,N2) & Y1 ?= Y2 & N1 ?= N2.
% something should happen to the values in the same columns
 :- cell(X1,Y,N1) & cell(X2,Y,N2) & X1 ?= X2 & N1 ?= N2.
% there must be a constraint on the usage of all digits in a square
in_square(S,N) :- cell(X,Y,N) & square(S,X,Y).
:- number(N) & squares(S) & ?not in_square(S, N). 
```
We see that the only difference is in the extra constraint on the squares of Sudoku, which is reasonable since, Sudoku is a particular case of Latin Square.

# Radio Frequency Assignment Problem
Let us demonstrate a more complicated usage of sketching for a known frequency assignment problem (FAP). The problem itself has two parts hard constraints and optimization. Here we consider a simplified version with only hard constraints: we need to model that two radio links are far enough from each other in the frequency spectrum if they interfering or at the right distance if they are parallel, also pre-assigned frequencies must be respected. For details we refer to the [original paper](http://www7.inra.fr/mia/T/schiex/Export/CELAR.ps.gz).

The full ASP encoding and the sketch (as presented below) can be found in the files [fap.asp](/ASP_encodings/fap.asp) and [fap.sasp](/sketches/fap.sasp).
```
[SKETCH]
:- F ?= F1 & pre_assigned(I,F) & assigned(I,F1).
:- [ F1 ?+ F2 ] ?= D & interfering(I) & interfering(J) & I != J & distance_interfering(D) & assigned(I,F1) & assigned(J,F2).
:- [ F1 ?+ F2 ] ?= D & parallel_pairs(P,I,J) & distance_parallel(D) & assigned(I,F1) & assigned(J,F2).

[EXAMPLES]
positive: assigned(1,10). assigned(2,40). assigned(3,100). assigned(4,60). assigned(5,70). 
negative: assigned(1,10). assigned(2,15). assigned(3,20).  assigned(4,60). assigned(5,70).  
negative: assigned(1,5).  assigned(2,40). assigned(3,100). assigned(4,60). assigned(5,70). 
negative: assigned(1,15). assigned(2,40). assigned(3,100). assigned(4,60). assigned(5,70). 
negative: assigned(1,10). assigned(2,40). assigned(3,100). assigned(4,60). assigned(5,65). 
negative: assigned(1,10). assigned(2,40). assigned(3,100). assigned(4,60). assigned(5,85). 

[DOMAIN]
?= : -100..100
?+ : -100..100

[PREFERENCES]
?= : = -> max, != -> max, unbound -> max, > -> max, < -> max.

[FACTS]
interfering(1). interfering(2). interfering(3).
parallel_pairs(1,4,5). 
frequency(10). frequency(15). frequency(20). frequency(25). frequency(30). frequency(35). frequency(40). frequency(45).  frequency(50).
frequency(60). frequency(70). frequency(80). frequency(90). frequency(100). 
pre_assigned(1,10).
pre_assigned(4,60).
distance_interfering(15).
distance_parallel(10).
```

## Clique Cover
A well known combinatorial task Clique Cover requires to partition a graph into *k* cliques. Let us sketch it in the following way, we know that somehow two vertices in indexed cliques are related to an edge, which might be negated or not.
```
[SKETCH]
% maybe negated edge is somehow related to vertices in the cliques, that are somehow connected between each other
:- ?not edge(X,Y) & clique(I,Xi) & clique(I,Xj) & Xi ?= Xj & X ?= Xi & Y ?= Xj.

%auxilary predicates
vertex(X) :- edge(X,Y).
edge(Y,X) :- edge(X,Y).

[EXAMPLES]
positive: clique(1,a). clique(2,d). clique(1,f). clique(1,e). clique(2,b). clique(2,c).
negative: clique(1,a). clique(1,d). clique(1,f). clique(1,e). clique(2,b). clique(2,c).

[FACTS]
edge(a,b). edge(a,c). edge(a,e). edge(a,f).
edge(b,c). edge(b,d).
edge(c,d).
edge(f,e).

[DOMAIN]
?= : 1,2,a,b,c,d,e,f
not : 1,2,a,b,c,d,e,f

[PREFERENCES]
?= : = -> max, != -> max, unbound -> max.
```
The sketch and the ASP encoding can be found in files: [clique_cover.sasp](/sketches/clique_cover.sasp) and [clique_cover.asp](/ASP_encodings/clique_cover.asp)

## Edge Coloring
Similar to graph coloring the problem of edge coloring is defined as follows: not two adjacent edges must get the same color assigned. Let us model this problem using sketching as follows: there are two constraints the first say each edge recieves a unique color and the second that two adjacent edges must have different colors. The sketch and ASP encoding can be found in files [edge_coloring.sasp](sketches/edge_coloring.sasp) and [edge_coloring.asp](ASP_encodings/edge_coloring.asp).
```
[SKETCH]
% if there are two colors for the same edge => not a model
:- colored(X,Y,C1) & colored(X,Y,C2) & C1 ?= C2.
% if adjacent edges have the same color => not a model
:- colored(X1,Y1,C1) & colored(X2,Y2,C2) & X1 ?= X2 & Y1 ?= Y2 & C1 ?= C2. 
% auxiliary predicates
edge(Y,X) :- edge(X,Y).
colored(Y,X,C) :- colored(X,Y,C).

[EXAMPLES]
positive: colored(1,2,b). colored(2,3,r). colored(3,4,b). colored(1,4,g). colored(2,5,g). colored(4,5,r).
negative: colored(1,2,r). colored(2,3,r). colored(3,4,b). colored(1,4,g). colored(2,5,g). colored(4,5,r).

[FACTS]
color(r). color(g). color(b).
edge(1,2). edge(2,3). edge(3,4). edge(4,1). edge(2,5). edge(4,5).

[DOMAIN]
?= : 1,2,3,4,5,r,g,b

[PREFERENCES]
?= : = -> max, != -> max, unbound -> max.
```

## How to Run and Requirements

**Dependencies and Requirements:**
* Linux (tested on 64-bit Ubuntu 14.04)
* python 3.4+  
* pyasp (pip install pyasp)
* clingo, gringo must be visible by pyasp (installed systemwise or copied in the corresponding folder of pyasp)

**How to Run** 
```
$ python3 sketcher_sources/solver.py sketches/set_packing.sasp 
```

**Output:**
```
solution # 0
decision_sketched_p_1 is ['c_selected']
decision_sketched_p_2 is ['c_selected']
decision_eq_1 is ['ne']
decision_eq_2 is ['eq']
```
It reads as follows: there is only one solution (dominant) found (number #0), with the decisions as listed.

## Domains of Predefined Sketching Operators

* Operator **?+** can take the values from the set {+,-,*,/,dist}, where the distance between A and B is defined as | A - B |.

* Operator **?=** can take values from the set {=,!=,<,>,=<,>=,unbound}, where A unbound B always holds, i.e. it is reduced to True.

* Operator **?not**, when applied to an atom A can be replaced with either "not A" or with "A".  

## Full Example of Rewritten Sketch: Black and White Queens

```
%%%%% ORIGINAL SKETCH RULES %%%%%%
%      :- queen(w,Rw,Cw),queen(b,Rb,Cb),Rw ?= Rb.
%      :- queen(w,Rw,Cw),queen(b,Rb,Cb),Cw ?= Cb.
%      :- queen(w,Rw,Cw),queen(b,Rb,Cb),B_VAR_1 ?= B_VAR_2,?+(Rw,Rb,B_VAR_1),?+(Cw,Cb,B_VAR_2).
%%%%% DOMAIN AND GENERATORS %%%%%%
sketched_clauses(1..3).equalities(eq). equalities(eq).  equalities(leq). 
equalities(geq). equalities(le). equalities(ge). equalities(ne). equalities(unbound).
ops(plus). ops(minus). ops(mult). ops(div). ops(dist).

1 { decision_eq_1(X) :  equalities(X) } 1.
1 { decision_eq_2(X) :  equalities(X) } 1.
1 { decision_eq_3(X) :  equalities(X) } 1.
1 { decision_arithmetic_1(X) :  ops(X) } 1.
1 { decision_arithmetic_2(X) :  ops(X) } 1.

%%%%% NON-EXAMPLES FACTS %%%%%%

%%%%%%  MATERIALIZED EQUALITY %%%%%%
          eq(eq , X, Y) :- X == Y, domain0(X), domain0(Y).
          eq(leq, X, Y) :- X <= Y, domain0(X), domain0(Y).
          eq(geq, X, Y) :- X >= Y, domain0(X), domain0(Y).
          eq(le , X, Y) :- X <  Y, domain0(X), domain0(Y).
          eq(ge , X, Y) :- X >  Y, domain0(X), domain0(Y).
          eq(ne , X, Y) :- X != Y, domain0(X), domain0(Y).
          eq(unbound, X, Y) :- domain0(X), domain0(Y).
      
%%%%%% SET DOMAIN VALUES %%%%%%
domain0(1). domain0(2). domain0(3). domain0(4). domain0(5). domain0(6). domain0(7). domain0(8). domain0(9). domain0(10). 

 %%%%%%  MATERIALIZED ARITHMETIC %%%%%%
          arithmetic(plus, X, Y, Z)  :- Z = X + Y,  domain1(X), domain1(Y).
          arithmetic(minus, X, Y, Z) :- Z = X - Y,  domain1(X), domain1(Y).
          arithmetic(mult, X, Y, Z)  :- Z = X * Y,  domain1(X), domain1(Y).
          arithmetic(div, X, Y, Z)   :- Z = X / Y,  domain1(X), domain1(Y).
          arithmetic(dist, X, Y, Z)  :- Z = |X - Y|,domain1(X), domain1(Y). 
      
%%%%%% SET DOMAIN VALUES %%%%%%
domain1(1). domain1(2). domain1(3). domain1(4). domain1(5). domain1(6). domain1(7). domain1(8). domain1(9). domain1(10). 

examples(E) :- negative(E).
examples(E) :- positive(E).
domain_not(E) :- examples(E).
%%%%% NON-SKETCHED INFERENCE RULES %%%%%%
%%%%% FAILING RULES %%%%%%
fail :- not neg_sat(E), negative(E).
:- fail.
%%%%% SKETCHED INFERENCE RULES %%%%%%
%%%%% POSITIVE SKETCHED RULES %%%%%%
fail :- queen(Eaux,w,Rw,Cw),queen(Eaux,b,Rb,Cb),eq(Q_eq_1,Rw,Rb),decision_eq_1(Q_eq_1),positive(Eaux).
fail :- queen(Eaux,w,Rw,Cw),queen(Eaux,b,Rb,Cb),eq(Q_eq_2,Cw,Cb),decision_eq_2(Q_eq_2),positive(Eaux).
fail :- queen(Eaux,w,Rw,Cw),queen(Eaux,b,Rb,Cb),eq(Q_eq_3,B_VAR_1,B_VAR_2),arithmetic(Q_arithmetic_1,Rw,Rb,B_VAR_1),arithmetic(Q_arithmetic_2,Cw,Cb,B_VAR_2),decision_eq_3(Q_eq_3),decision_arithmetic_1(Q_arithmetic_1),decision_arithmetic_2(Q_arithmetic_2),positive(Eaux).
%%%%% NEGATIVE SKETCHED RULES %%%%%%
neg_sat(Eaux) :- queen(Eaux,w,Rw,Cw),queen(Eaux,b,Rb,Cb),eq(Q_eq_1,Rw,Rb),decision_eq_1(Q_eq_1),negative(Eaux).
neg_sat(Eaux) :- queen(Eaux,w,Rw,Cw),queen(Eaux,b,Rb,Cb),eq(Q_eq_2,Cw,Cb),decision_eq_2(Q_eq_2),negative(Eaux).
neg_sat(Eaux) :- queen(Eaux,w,Rw,Cw),queen(Eaux,b,Rb,Cb),eq(Q_eq_3,B_VAR_1,B_VAR_2),arithmetic(Q_arithmetic_1,Rw,Rb,B_VAR_1),arithmetic(Q_arithmetic_2,Cw,Cb,B_VAR_2),decision_eq_3(Q_eq_3),decision_arithmetic_1(Q_arithmetic_1),decision_arithmetic_2(Q_arithmetic_2),negative(Eaux).
%%%%% EXAMPLES %%%%%%
positive(0). queen(0,w,1,1). queen(0,w,2,2). queen(0,b,3,4). queen(0,b,4,3). 
positive(1). queen(1,b,1,1). queen(1,b,2,2). queen(1,w,3,4). queen(1,w,4,3). 
negative(2). queen(2,w,1,1). queen(2,w,2,2). queen(2,b,3,4). queen(2,b,4,4). 
negative(3). queen(3,b,2,2). queen(3,w,3,1). 
#show neg_sat/1.
#show decision_eq_1/1.
#show decision_eq_2/1.
#show decision_eq_3/1.
#show decision_arithmetic_1/1.
#show decision_arithmetic_2/1.
```

The rest of the rewritten programs can be found in the folder [rewritten_sketches](/rewritten_sketches) or in the table below.

## Full Table of Sketched Problems

| Problem | Sketch | Rewritten | ASP Encoding | Description |
| --- | --- | --- | --- | --- |
| Graph Clique   |  [clique.sasp](/sketches/clique.sasp) | [clique](/rewritten_sketches/clique_rewritten.asp) | [clique.asp](/ASP_encodings/clique.asp)   |  [Wiki](https://en.wikipedia.org/wiki/Clique_(graph_theory)) | 
| 3D Matching    |  [3d_matching.sasp](/sketches/3d_matching.sasp) | [3d_matching](/rewritten_sketches/3d_matching_rewritten.asp)      |   [3d_matching.asp](/ASP_encodings/3d_matching.asp) |  [Wiki](https://en.wikipedia.org/wiki/3-dimensional_matching) | 
| Graph Coloring |  [graph_coloring.sasp](/sketches/graph_coloring.sasp) | [graph_coloring](/rewritten_sketches/graph_coloring_rewritten.asp)|  [graph_coloring.asp](/ASP_encodings/graph_coloring.asp)   |  [Wiki](https://en.wikipedia.org/wiki/Graph_coloring) | 
| Domination Set |  [domination_set.sasp](/sketches/domination_set.sasp)  | [domination_set](/rewritten_sketches/domination_set_rewritten.asp) |  [domination_set.asp](/ASP_encodings/domination_set.asp)   |  [Wiki](https://en.wikipedia.org/wiki/Dominating_set) | 
| Exact Cover |  [exact_cover.sasp](/sketches/exact_cover.sasp)   | [exact_cover](/rewritten_sketches/exact_cover_rewritten.asp) | [exact_cover.asp](/ASP_encodings/exact_cover.asp)   |  [Wiki](https://en.wikipedia.org/wiki/Exact_cover) | 
| Sudoku |  [sudoku.sasp](/sketches/sudoku.sasp)  | [sudoku](/rewritten_sketches/sudoku_rewritten.asp) |  [sudoku.asp](/ASP_encodings/sudoku.asp)   |  [Wiki](https://en.wikipedia.org/wiki/Sudoku) | 
| B&W Queens |  [queens.sasp](/sketches/queens.sasp) | [queens](/rewritten_sketches/black_and_white_queens_rewritten.asp)  |  [queens.asp](/ASP_encodings/black_white_queens.asp) |  [CSP Lib](http://www.csplib.org/Problems/prob110/) | 
| Hitting Set |  [hitting_set.sasp](/sketches/hitting_set.sasp)  | [hitting_set](/rewritten_sketches/hitting_set_rewritten.asp) |  [hitting_set.asp](/ASP_encodings/hitting_set.asp)   |  [Wiki](https://en.wikipedia.org/wiki/Hitting_set) | 
| Hamiltonian Cycle |  [ham.sasp](/sketches/ham.sasp)  | [ham](/rewritten_sketches/ham_rewritten.asp) |  [ham.asp](/ASP_encodings/ham.asp)   |  [Wiki](https://en.wikipedia.org/wiki/Hamiltonian_path) | 
| Feedback Arc Set|  [feedback_arc_set.sasp](/sketches/feedback_arc_set.sasp)  | [feedback_arc_set](/rewritten_sketches/feedback_arc_set_rewritten.asp) |  [feedback_arc_set.asp](/ASP_encodings/feedback_arc_set.asp)   |  [Wiki](https://en.wikipedia.org/wiki/Feedback_arc_set) | 
| Latin Square |  [latin_square.sasp](/sketches/latin_square.sasp) | [latin_square](/rewritten_sketches/latin_square_rewritten.asp)  |  [latin_square.asp](/ASP_encodings/latin_square.asp)   |  [Wiki](https://en.wikipedia.org/wiki/Latin_square) | 
| Edge Domination |  [edge_domination_set.sasp](/sketches/edge_domination_set.sasp)  | [edge_domination](/rewritten_sketches/edge_domination_rewritten.asp)  |  [edge_domination_set.asp](/ASP_encodings/edge_domination_set.asp)   |  [Wiki](https://en.wikipedia.org/wiki/Edge_dominating_set) | 
| Frequency Assignment |  [fap.sasp](/sketches/fap.sasp) | [fap](/rewritten_sketches/fap_rewritten.asp)    |  [fap.asp](/ASP_encodings/fap.asp)   |  [Paper](http://www7.inra.fr/mia/T/schiex/Export/CELAR.ps.gz) | 
| Set Packing |  [set_packing.sasp](/sketches/set_packing.sasp) | [set_packing](/rewritten_sketches/set_packing_rewritten.asp)   |  [set_packing.asp](/ASP_encodings/set_packing.asp)   |  [Wiki](https://en.wikipedia.org/wiki/Set_packing) | 
| Clique Cover |  [clique_cover.sasp](/sketches/clique_cover.sasp) | [clique_cover](/rewritten_sketches/clique_cover_rewritten.asp)   |  [clique_cover.asp](/ASP_encodings/clique_cover.asp)   |  [Wiki](https://en.wikipedia.org/wiki/Clique_cover) | 
| Feedback Vertex Set |  [feedback_vertex_set.sasp](/sketches/feedback_vertex_set.sasp) | [feedback_vertex_set](/rewritten_sketches/feedback_vertex_set_rewritten.asp)    |  [feedback_vertex_set.asp](/ASP_encodings/feedback_vertex_cover.asp)   |  [Wiki](https://en.wikipedia.org/wiki/Feedback_vertex_set) | 
| Edge Coloring |  [edge_coloring.sasp](/sketches/edge_coloring.sasp) | [edge_coloring](/rewritten_sketches/edge_coloring_rewritten.asp)  |  [edge_coloring.asp](/ASP_encodings/edge_coloring.asp)   |  [Wiki](https://en.wikipedia.org/wiki/Edge_coloring) | 
| Set Splitting |  [set_splitting.sasp](/sketches/set_splitting.sasp) | [set_splitting](/rewritten_sketches/set_splitting_rewritten.asp)  |  [set_splitting.asp](/ASP_encodings/set_splitting.asp)   |  [Wiki](https://en.wikipedia.org/wiki/Set_splitting_problem) | 
| N Queens |  [n_queens.sasp](/sketches/regular_queens.sasp)  | [n_queens](/rewritten_sketches/n_queens_rewritten.asp) |  [n_queens.asp](/ASP_encodings/regular_queens.asp)   |  [Wiki](https://en.wikipedia.org/wiki/Eight_queens_puzzle) | 
| Vertex Cover |  [vertex_cover.sasp](/sketches/vertex_cover.sasp) | [vertex_cover](/rewritten_sketches/vertex_cover_rewritten.asp)  |  [vertex_cover.asp](/ASP_encodings/vertex_cover.asp)   |  [Wiki](https://en.wikipedia.org/wiki/Vertex_cover) | 
| Subgraph Isomorphism |  [subgraph_isomorphism.sasp](/sketches/subgraph_isomorphism.sasp) | [subgraph_isomorphism](/rewritten_sketches/subgraph_isomorphism_rewritten.asp)  |  [subgraph_isomorphism.asp](/ASP_encodings/subgraph_isomorphism.asp)   |  [Wiki](https://en.wikipedia.org/wiki/Subgraph_isomorphism_problem) | 

