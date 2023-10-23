#include "topology.lp".

%color(red;orange;yellow;white;blue;green).
color(red;yellow;blue;cyan;magenta;green).

#const n = 2.
step(0..n).

% vertex V has color C is a property that changes over time
fluent(inertial,color(V,C)) :- vertex(V), color(C).

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
action(rotate_cw(P,O)) :- circle(P,O).
action(rotate_ccw(P,O)) :- circle(P,O).

%% the result of a clockwise rotation is that each color(V,C) on circle X moves to the successor of V.
%% or in other words: a vertex V receives the color of its predecessor
holds(color(V,C),I+1) :- occurs(rotate_cw(P,O),I),
                        I < n,
                        predecessor(P,O,V,V1),
                        predecessor(P,O,V1,V2),
                        predecessor(P,O,V2,V3),
                        holds(color(V3,C),I).

% and a side effect is a 2-position counter-clockwise rotation of an outside face, in case an outer circle clockwise rotation
holds(color(V,C),I+1) :- occurs(rotate_cw(P,O),I),
                        I < n,
                        face(F),
                        lies_outside(F,P,O),
                        face_successor(F,V1,V),
                        face_successor(F,V2,V1),
                        holds(color(V2,C),I).

% or a 2-position clockwise rotation of an inside face, in case an inner circle clockwise rotation
holds(color(V,C),I+1) :- occurs(rotate_cw(P,O),I),
                        I < n,
                        face(F),
                        lies_inside(F,P,O),
                        face_successor(F,V,V1),
                        face_successor(F,V1,V2),
                        holds(color(V2,C),I).


%% the result of a counter-clockwise rotation is that each color(V,C) on circle(P,O) moves to the 3rd predecessor of V.
%% or in other words: a vertex V receives the color of its successor
holds(color(V,C),I+1) :- occurs(rotate_ccw(P,O),I),
                        I < n,
                        successor(P,O,V,V1),
                        successor(P,O,V1,V2),
                        successor(P,O,V2,V3),
                        holds(color(V3,C),I).

% and a side effect is a 2-position clockwise rotation of an outside face, in case an outer circle counter-clockwise rotation
holds(color(V,C),I+1) :- occurs(rotate_ccw(P,O),I),
                        I < n,
                        face(F),
                        lies_outside(F,P,O),
                        face_successor(F,V,V1),
                        face_successor(F,V1,V2),
                        holds(color(V2,C),I).

% or a 2-position clockwise rotation of an inside face, in case an inner circle clockwise rotation
holds(color(V,C),I+1) :- occurs(rotate_ccw(P,O),I),
                        I < n,
                        face(F),
                        lies_inside(F,P,O),
                        face_successor(F,V1,V),
                        face_successor(F,V2,V1),
                        holds(color(V2,C),I).

%% in case we want to explicitly prevent rotation of the middle orbits. This is closer to the real-world solution
%% algorithms, where a middle orbit rotation is actually comprised of a outer and inner rotation, sequentially.
%-occurs(rotate_cw(P,O),I) :- circle(P,middle).

%% Inertia Axiom
holds(F,I+1) :- holds(F,I),
                not -holds(F,I+1),
                fluent(inertial,F),
                I < n.

-holds(F,I+1) :- -holds(F,I),
                not holds(F,I+1),
                fluent(inertial,F),
                I < n.

%% CWA for actions
-occurs(A,I) :- action(A), step(I),
                not occurs(A,I).

%% Planning
% the goal has been reached when all faces are unicolored
% One way to detect this is to count the number of vertices on each circle that have 2 successors with the same color.
% This number shall be 4. This translates to each circle having 4 groups of # unicolored vertices.
% Count the number of vertices with 2 successors having the same color


% fix initial state
#include "initial_state_almost_solved_alt_colors.lp".

% rotate
occurs(rotate_ccw(xy,inner),0).
occurs(rotate_ccw(yz,middle),1).