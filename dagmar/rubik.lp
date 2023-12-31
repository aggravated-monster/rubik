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

% Circles can be rotated. To keep the level of black magic down,
% assume clockwise and counter clockwise to be 2 different actions.
action(rotate_cw(P,O)) :- circle(P,O).
action(rotate_ccw(P,O)) :- circle(P,O).

% A rotation of an outer circle causes a co-rotation in the opposite direction
side_effect(co_rotate_ccw(F),I) :- occurs(rotate_cw(P,outer),I),
                              face(F),
                              lies_outside(F,P,outer).

side_effect(co_rotate_cw(F),I) :- occurs(rotate_ccw(P,outer),I),
                              face(F),
                              lies_outside(F,P,outer).

% A rotation of an inner circle causes a co-rotation in the same direction
side_effect(co_rotate_cw(F),I) :- occurs(rotate_cw(P,inner),I),
                              face(F),
                              lies_inside(F,P,inner).

side_effect(co_rotate_ccw(F),I) :- occurs(rotate_ccw(P,inner),I),
                              face(F),
                              lies_inside(F,P,inner).



%% Chain of events
%% -----------------------------------------------------------------------
%% the result of a clockwise rotation is that each color(V,C) on circle (P,O) moves to the 3rd successor of V.
%% or in other words: a vertex V receives the color of its 3rd predecessor
holds(color(V,C),I+1) :- occurs(rotate_cw(P,O),I),
                        I < n,
                        predecessor(P,O,V,V1),
                        predecessor(P,O,V1,V2),
                        predecessor(P,O,V2,V3),
                        holds(color(V3,C),I).

%% the result of a counter-clockwise rotation is that each color(V,C) on circle(P,O) moves to the 3rd predecessor of V.
%% or in other words: a vertex V receives the color of its successor
holds(color(V,C),I+1) :- occurs(rotate_ccw(P,O),I),
                        I < n,
                        successor(P,O,V,V1),
                        successor(P,O,V1,V2),
                        successor(P,O,V2,V3),
                        holds(color(V3,C),I).

% Similarly, co-rotation of the faces moves the colors 2 positions
holds(color(V,C),I+1) :- side_effect(co_rotate_cw(F),I),
                         I < n,
                        predecessor(F,V,V1),
                        predecessor(F,V1,V2),
                        holds(color(V2,C),I).

holds(color(V,C),I+1) :- side_effect(co_rotate_ccw(F),I),
                         I < n,
                        successor(F,V,V1),
                        successor(F,V1,V2),
                        holds(color(V2,C),I).

%% block nonsensical sequences cancelling each other out.
%% This can theoretically go many steps deep, but we do the obvious 2-sequences only here
-occurs(rotate_ccw(P,O),I+1) :- occurs(rotate_cw(P,O),I).
-occurs(rotate_cw(P,O),I+1) :- occurs(rotate_ccw(P,O),I).

%% BOILER PLATE
%% ------------------------------------------------------------------------
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
%% --------------------------------------------------------------------------
% the goal has been reached when all faces are unicolored
% The obvious way to detect this is to evaluate the colors of the vertices on each face, but
% another way to detect this is to count the number of vertices on each circle that have 2 successors with the same color,
% which I find a fascinating property.
% This number shall be 4. This translates to each circle having 4 triplets of # unicolored vertices.

% Keep track of the solved circles
fluent(defined,solved_circle(P,O)) :- circle(P,O).
%
% Count the number of vertices with 2 successors on the same face having the same color
holds(solved_circle(P,O),I) :- step(I), circle(P,O),
                                        4 = #count{V1,V2,V3 : vertex(V1), vertex(V2), vertex(V3),
                                            successor(P,O,V1,V2),
                                            successor(P,O,V2,V3),
                                            lies_on(V1,F),
                                            lies_on(V2,F),
                                            lies_on(V3,F),
                                            holds(color(V1,C),I),
                                            holds(color(V2,C),I),
                                            holds(color(V3,C),I)}.

%% and to reach the goal, each circle shall be solved
goal(I) :- step(I),
           9 = #count{P,O : holds(solved_circle(P,O),I)}.

% alternative enumerated goal. This reduces grounding and halves the time for 7 moves
% It is however slower on the 6-move
% But then again... this is an exponential problem. Things will be bad anyway beyond 7 moves,
% so all of this is merely 'gerommel in de marge'

%goal(I) :- step(I),
%           holds(solved_circle(xy,outer),I),
%           holds(solved_circle(xy,middle),I),
%           holds(solved_circle(xy,inner),I),
%           holds(solved_circle(xz,outer),I),
%           holds(solved_circle(xz,middle),I),
%           holds(solved_circle(xz,inner),I),
%           holds(solved_circle(yz,outer),I),
%           holds(solved_circle(yz,middle),I),
%           holds(solved_circle(yz,inner),I).



%% Standard Goal
%% --------------------------------------------------------------------------
% the goal is also reached when all faces are unicolored
% Count the number of colors on a face. When this is 1, the face is completed
%fluent(defined,completed(F)) :- face(F).

%holds(completed(F),I) :- 1 = #count{C : holds(color(V,C),I), lies_on(V,F)}, face(F), step(I).

%goal(I) :- holds(completed(top),I),
%            holds(completed(bottom),I),
%            holds(completed(left),I),
%            holds(completed(right),I),
%            holds(completed(front),I),
%            holds(completed(back),I).

%goal(I) :- 6 = #count{F : holds(completed(F),I)}, step(I).

