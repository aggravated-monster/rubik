#include "topology.lp".

color(red;orange;yellow;white;blue;green).

#const n = 2.
step(0..n).

% vertex V has color C is a property that changes over time
fluent(color(V,C)) :- vertex(V), color(C).

%% each vertex has only one color, at any step
-holds(color(V,C1),I) :- holds(color(V,C),I),
                    color(C1),
                    color(C) != color(C1).

%% CWA: if a vertex is not known to have color C at step 0
%% then assume is has not
-holds(color(V,C), 0) :- vertex(V), color(C),
                         not holds(color(V,C),0).


% circles can be rotated. For now, assume clockwise and counter clockwise are 2 different actions.
% If this works, perhaps generalise to one, with direction as a parameter
action(rotate_cw(X)) :- circle(X).
action(rotate_ccw(X)) :- circle(X).

%% the result of a clockwise rotation is that each color(V,C) on circle X moves to the successor of V.
%% or in other words: a vertex V receives the color of its predecessor
holds(color(V,C),I+1) :- occurs(rotate_cw(X),I),
                        I < n,
                        predecessor(X,V,V1),
                        predecessor(X,V1,V2),
                        predecessor(X,V2,V3),
                        holds(color(V3,C),I).

% and a side effect is a counter-clockwise rotation of an outside face, in case an outer circle clockwise rotation
holds(color(V,C),I+1) :- occurs(rotate_cw(X),I),
                        I < n,
                        face(F),
                        lies_outside(F,X),
                        face_successor(F,V1,V),
                        holds(color(V1,C),I).

% or a clockwise rotation of an inside face, in case an inner circle clockwise rotation
holds(color(V,C),I+1) :- occurs(rotate_cw(X),I),
                        I < n,
                        face(F),
                        lies_inside(F,X),
                        face_successor(F,V,V1),
                        holds(color(V1,C),I).


%% the result of a counter-clockwise rotation is that each color(V,C) on circle X moves to the predecessor of V.
%% or in other words: a vertex V receives the color of its successor
holds(color(V,C),I+1) :- occurs(rotate_ccw(X),I),
                        I < n,
                        successor(X,V,V1),
                        successor(X,V1,V2),
                        successor(X,V2,V3),
                        holds(color(V3,C),I).

% and a side effect is a clockwise rotation of an outside face, in case an outer circle counter-clockwise rotation
holds(color(V,C),I+1) :- occurs(rotate_ccw(X),I),
                        I < n,
                        face(F),
                        lies_outside(F,X),
                        face_successor(F,V,V1),
                        holds(color(V1,C),I).

% or a clockwise rotation of an inside face, in case an inner circle clockwise rotation
holds(color(V,C),I+1) :- occurs(rotate_ccw(X),I),
                        I < n,
                        face(F),
                        lies_inside(F,X),
                        face_successor(F,V1,V),
                        holds(color(V1,C),I).



%% Inertia Axiom
holds(F,I+1) :- holds(F,I),
                not -holds(F,I+1),
                I < n.

-holds(F,I+1) :- -holds(F,I),
                not holds(F,I+1),
                I < n.


% fix initial state
#include "initial_state.lp".

% rotate
occurs(rotate_cw(right_outer),0).