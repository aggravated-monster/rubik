vertex(1..6).
circle(top;left;right).

% define the topology. We will set this in stone, and instead of meddling with edges, simply rotate the colors
% successors are defined clockwise; predecessors are defined counterclockwise
successor(top,1,2).
successor(top,2,5).
successor(top,5,3).
successor(top,3,1).
successor(left,1,4).
successor(left,4,5).
successor(left,5,6).
successor(left,6,1).
successor(right,3,4).
successor(right,4,2).
successor(right,2,6).
successor(right,6,3).

% swap places to define predecessors. I have a gut feeling this comes in handy when rotating
predecessor(X,S,V) :- successor(X,V,S).

% lies_on may be useful though, but in a fixed configuration, the rule becomes really easy
lies_on(V,X) :- successor(X,V,_).

% vertices have a color. There are 6 colors, so each node also trivially has a unique color.
% In larger representations, this changes of course.
color(red;orange;yellow;white;blue;green).


%%
#const n = 2.
step(0..n).

% vertex V has color C is a property that changes over time
fluent(color(V,C)) :- vertex(V), color(C).

%% each vertex has only one color
-holds(color(V,C1),I) :- holds(color(V,C),I),
                    color(C1),
                    color(C) != color(C1).


% circles can be rotated. For now, assume clockwise and counter clockwise are 2 different actions.
% If this works, perhaps generalise to one, with direction as a parameter
action(rotate_cw(X)) :- circle(X).
action(rotate_ccw(X)) :- circle(X).

%% CWA: if a vertex is not known to have color C at step 0
%% then assume is has not
-holds(color(V,C), 0) :- vertex(V), color(C),
                         not holds(color(V,C),0).

%% the result of a clockwise rotation is that each color(V,C) on circle X moves to the successor of V.
%% or in other words: a vertex V receives the color of its predecessor
holds(color(V,C),I+1) :- occurs(rotate_cw(X),I),
                        I < n,
                        predecessor(X,V,V1),
                        holds(color(V1,C),I).

%% the result of a clockwise rotation is that each color(V,C) on circle X moves to the predecessor of V.
%% or in other words: a vertex V receives the color of its successor
holds(color(V,C),I+1) :- occurs(rotate_ccw(X),I),
                        I < n,
                        successor(X,V,V1),
                        holds(color(V1,C),I).

%% Inertia Axiom
holds(F,I+1) :- holds(F,I),
                not -holds(F,I+1),
                I < n.

-holds(F,I+1) :- -holds(F,I),
                not holds(F,I+1),
                I < n.


% fix the initial state
holds(color(1,red), 0).
holds(color(2,orange), 0).
holds(color(3,yellow), 0).
holds(color(4,white), 0).
holds(color(5,blue), 0).
holds(color(6,green), 0).

occurs(rotate_cw(top),0).
