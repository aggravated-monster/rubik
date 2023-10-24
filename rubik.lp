#include "topology.lp".

color(red;orange;yellow;white;blue;green).
% alternative color scheme for initial states based on the video
%color(red;yellow;blue;cyan;magenta;green).

step(0..n).

% vertex V has color C is a property that changes over time
fluent(inertial,color(V,C)) :- vertex(V), color(C).

%% each vertex has only one color, at any step
-holds(color(V,C1),I) :- holds(color(V,C),I),
                    color(C1),
                    color(C) != color(C1).

%% CWA: if a vertex is not known to have color C at step 0
%% then assume is has not.
%% This is probably good practice in general (for querying for instance), but in the Rubik's Cube case
%% it feels a bit superfluous, as the initial state has to be valid in order to find a solution in the first place.
%% This means the initial state has to be complete, and then the rule above applies.
-holds(color(V,C), 0) :- vertex(V), color(C),
                         not holds(color(V,C),0).


% Circles can be rotated. To keep the level of black magic down,
% assume clockwise and counter clockwise to be 2 different actions.
action(rotate_cw(P,O)) :- circle(P,O).
action(rotate_ccw(P,O)) :- circle(P,O).

%% Faces can also rotate. In the 2d graph representation, this works like cogs:
%% Insider faces co-rotate with inner circles; outsider faces counter-co-rotate with outer circles
action(co_rotate_cw(F)) :- face(F).
action(co_rotate_ccw(F)) :- face(F).


%% the result of a clockwise rotation is that each color(V,C) on circle (P,O) moves to the 3rd successor of V.
%% or in other words: a vertex V receives the color of its 3rd predecessor
holds(color(V,C),I+1) :- occurs(rotate_cw(P,O),I),
                        I < n,
                        predecessor(P,O,V,V1),
                        predecessor(P,O,V1,V2),
                        predecessor(P,O,V2,V3),
                        holds(color(V3,C),I).

% and a side effect is a 2-position counter-clockwise rotation of an outsider face, in case of an outer circle clockwise rotation
holds(color(V,C),I+1) :- occurs(rotate_cw(P,O),I),
                        I < n,
                        face(F),
                        lies_outside(F,P,O),
                        successor(F,V,V1),
                        successor(F,V1,V2),
                        holds(color(V2,C),I).

% or a 2-position clockwise rotation of an inside face, in case an inner circle clockwise rotation,
% meaning V receives the color of its 2nd predecessor
holds(color(V,C),I+1) :- occurs(rotate_cw(P,O),I),
                        I < n,
                        face(F),
                        lies_inside(F,P,O),
                        predecessor(F,V,V1),
                        predecessor(F,V1,V2),
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
                        predecessor(F,V,V1),
                        predecessor(F,V1,V2),
                        holds(color(V2,C),I).

% or a 2-position counter-clockwise rotation of an inside face, in case an inner circle counter-clockwise rotation
holds(color(V,C),I+1) :- occurs(rotate_ccw(P,O),I),
                        I < n,
                        face(F),
                        lies_inside(F,P,O),
                        successor(F,V,V1),
                        successor(F,V1,V2),
                        holds(color(V2,C),I).

%% in case we want to explicitly prevent rotation of the middle orbits. This is closer to the real-world solution
%% algorithms, where a middle orbit rotation is actually comprised of a outer and inner rotation, sequentially.
%-occurs(rotate_cw(P,O),I) :- circle(P,middle).

%% CWA for Defined Fluents
-holds(F,I) :- fluent(defined,F),
                step(I),
                not holds(F,I).

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

%% Goal
% the goal has been reached when all faces are unicolored
% One way to detect this is to count the number of vertices on each circle that have 2 successors with the same color.
% This number shall be 4. This translates to each circle having 4 triplets of # unicolored vertices.
% Count the number of vertices with 2 successors having the same color
fluent(defined,number_of_triplets(P,O,N)) :- circle(P,O), N = 0..4.

% keep the total as a fluent for debugging purposes
fluent(defined,number_of_solved_circles(N)) :- N = 0..9.

holds(number_of_triplets(P,O,N),I) :- circle(P,O), step(I),
                                        N = #count{V1,V2,V3 : vertex(V1), vertex(V2), vertex(V3),
                                            successor(P,O,V1,V2),
                                            successor(P,O,V2,V3),
                                            holds(color(V1,C),I),
                                            holds(color(V2,C),I),
                                            holds(color(V3,C),I)}.

holds(number_of_solved_circles(N),I) :- step(I),
                                         N = #count{P,O : circle(P,O),
                                         holds(number_of_triplets(P,O,4),I)}.

goal(I) :- circle(P,O),
            holds(number_of_solved_circles(9),I).

#const n = 5.
#include "initial_state_solved.lp".
% rotate
%occurs(rotate_ccw(xy,inner),0).
%occurs(rotate_ccw(yz,middle),1).

occurs(rotate_cw(xy,inner),0).
occurs(rotate_cw(yz,outer),1).
occurs(rotate_ccw(xz,outer),2).
occurs(rotate_ccw(yz,inner),3).
occurs(rotate_cw(xz,inner),4).
