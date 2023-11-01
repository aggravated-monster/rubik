% signature(sorts, statics, fluents, actions)

color(white;green;orange;yellow;blue;red).
direction(left;right).
opposite(left,right;right,left).

vertex(w1;w2;w3;w4;w5;w6;w7;w8;w9).
vertex(g1;g2;g3;g4;g5;g6;g7;g8;g9).
vertex(o1;o2;o3;o4;o5;o6;o7;o8;o9).
vertex(y1;y2;y3;y4;y5;y6;y7;y8;y9).
vertex(b1;b2;b3;b4;b5;b6;b7;b8;b9).
vertex(r1;r2;r3;r4;r5;r6;r7;r8;r9).

edge(w1,w2,right; w2,w3,right; w3,r1,right; r1,r2,right; r2,r3,right; r3,y1,right; y1,y2,right; y2,y3,right; y3,o1,right; o1,o2,right; o2,o3,right; o3,w1,right).
edge(w4,w5,right; w5,w6,right; w6,r4,right; r4,r5,right; r5,r6,right; r6,y4,right; y4,y5,right; y5,y6,right; y6,o4,right; o4,o5,right; o5,o6,right; o6,w4,right).
edge(w7,w8,right; w8,w9,right; w9,r7,right; r7,r8,right; r8,r9,right; r9,y7,right; y7,y8,right; y8,y9,right; y9,o7,right; o7,o8,right; o8,o9,right; o9,w7,right).
edge(w1,b7,right; b7,b4,right; b4,b1,right; b1,y3,right; y3,y6,right; y6,y9,right; y9,g7,right; g7,g4,right; g4,g1,right; g1,w7,right; w7,w4,right; w4,w1,right).
edge(w2,b8,right; b8,b5,right; b5,b2,right; b2,y2,right; y2,y5,right; y5,y8,right; y8,g8,right; g8,g5,right; g5,g2,right; g2,w8,right; w8,w5,right; w5,w2,right).
edge(w3,b9,right; b9,b6,right; b6,b3,right; b3,y1,right; y1,y4,right; y4,y7,right; y7,g9,right; g9,g6,right; g6,g3,right; g3,w9,right; w9,w6,right; w6,w3,right).
edge(b7,b8,right; b8,b9,right; b9,r1,right; r1,r4,right; r4,r7,right; r7,g3,right; g3,g2,right; g2,g1,right; g1,o9,right; o9,o6,right; o6,o3,right; o3,b7,right).
edge(b4,b5,right; b5,b6,right; b6,r2,right; r2,r5,right; r5,r8,right; r8,g6,right; g6,g5,right; g5,g4,right; g4,o8,right; o8,o5,right; o5,o2,right; o2,b4,right).
edge(b1,b2,right; b2,b3,right; b3,r3,right; r3,r6,right; r6,r9,right; r9,g9,right; g9,g8,right; g8,g7,right; g7,o7,right; o7,o4,right; o4,o1,right; o1,b1,right).

edge(Y,X,left) :- vertex(X), vertex(Y), edge(X,Y,right).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
center(front,w5;left_side,o5;right_side,r5;top,b5;bottom,g5;back,y5).
surface(front;left_side;right_side;back;top;bottom).

contains(front,w1;front,w2;front,w3;front,w4;front,w5;front,w6;front,w7;front,w8;front,w9).
contains(bottom,g1;bottom,g2;bottom,g3;bottom,g4;bottom,g5;bottom,g6;bottom,g7;bottom,g8;bottom,g9).
contains(left_side,o1;left_side,o2;left_side,o3;left_side,o4;left_side,o5;left_side,o6;left_side,o7;left_side,o8;left_side,o9).
contains(right_side,r1;right_side,r2;right_side,r3;right_side,r4;right_side,r5;right_side,r6;right_side,r7;right_side,r8;right_side,r9).
contains(top,b1;top,b2;top,b3;top,b4;top,b5;top,b6;top,b7;top,b8;top,b9).
contains(back,y1;back,y2;back,y3;back,y4;back,y5;back,y6;back,y7;back,y8;back,y9).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
circle(hor1;hor2;hor3;vert1;vert2;vert3;rot1;rot2;rot3).
is_part_of(hor1,w1;hor1,w2;hor1,w3;hor1,r1;hor1,r2;hor1,r3;hor1,y1;hor1,y2;hor1,y3;hor1,o1;hor1,o2;hor1,o3).
is_part_of(hor2,w4;hor2,w5;hor2,w6;hor2,r4;hor2,r5;hor2,r6;hor2,y4;hor2,y5;hor2,y6;hor2,o4;hor2,o5;hor2,o6).
is_part_of(hor3,w7;hor3,w8;hor3,w9;hor3,r7;hor3,r8;hor3,r9;hor3,y7;hor3,y8;hor3,y9;hor3,o7;hor3,o8;hor3,o9).
is_part_of(vert1,w1;vert1,w4;vert1,w7;vert1,g1;vert1,g4;vert1,g7;vert1,y9;vert1,y6;vert1,y3;vert1,b1;vert1,b4;vert1,b7).
is_part_of(vert2,w2;vert2,w5;vert2,w8;vert2,g2;vert2,g5;vert2,g8;vert2,y8;vert2,y5;vert2,y2;vert2,b2;vert2,b5;vert2,b8).
is_part_of(vert3,w3;vert3,w6;vert3,w9;vert3,g3;vert3,g6;vert3,g9;vert3,y7;vert3,y4;vert3,y1;vert3,b3;vert3,b6;vert3,b9).
is_part_of(rot1,b7;rot1,b8;rot1,b9;rot1,r1;rot1,r4;rot1,r7;rot1,g1;rot1,g2;rot1,g3;rot1,o3;rot1,o6;rot1,o9).
is_part_of(rot2,b4;rot2,b5;rot2,b6;rot2,r2;rot2,r5;rot2,r8;rot2,g4;rot2,g5;rot2,g6;rot2,o8;rot2,o5;rot2,o2).
is_part_of(rot3,b1;rot3,b2;rot3,b3;rot3,r3;rot3,r6;rot3,r9;rot3,g9;rot3,g8;rot3,g7;rot3,o1;rot3,o4;rot3,o7).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
edge2(w1,w2,right;w2,w3,right;w3,w6,right;w6,w9,right;w9,w8,right;w8,w7,right;w7,w4,right;w4,w1,right).
edge2(r1,r2,right;r2,r3,right;r3,r6,right;r6,r9,right;r9,r8,right;r8,r7,right;r7,r4,right;r4,r1,right).
edge2(b1,b2,right;b2,b3,right;b3,b6,right;b6,b9,right;b9,b8,right;b8,b7,right;b7,b4,right;b4,b1,right).
edge2(g1,g2,right;g2,g3,right;g3,g6,right;g6,g9,right;g9,g8,right;g8,g7,right;g7,g4,right;g4,g1,right).
edge2(o1,o2,right;o2,o3,right;o3,o6,right;o6,o9,right;o9,o8,right;o8,o7,right;o7,o4,right;o4,o1,right).
edge2(y1,y2,right;y2,y3,right;y3,y6,right;y6,y9,right;y9,y8,right;y8,y7,right;y7,y4,right;y4,y1,right).
edge2(Y,X,left) :- vertex(X), vertex(Y), edge2(X,Y,right).

adjacent_surface(vert3,right_side;vert1,left_side;hor1,top;hor3,bottom;rot1,front;rot3,back).
center_circle(hor2;vert2;rot2).
outer_circle(hor1;hor3;vert1;vert3;rot1;rot3).
counter_clock(front;right_side;bottom).
clockwise(top;left_side;back).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fluent(inertial, color_vertex(V,C)) :- color(C), vertex(V).
fluent(defined, completed(S)) :- surface(S).

action(turn(C,D)) :- circle(C), direction(D).

% signature description

%#const n = 6.
step(0..n).

% causal laws
holds(completed(S),I) :- surface(S), center(S,Ce), holds(color_vertex(Ce,C),I),
                         N = #count{V: contains(S,V), holds(color_vertex(V,C1),I), C1 != C},
                         N = 0.

holds(color_vertex(V,C2), I+1) :- occurs(turn(C,D),I), opposite(D,Op),
                                  step(I), is_part_of(C,V), is_part_of(C,X),
                                  is_part_of(C,Y), is_part_of(C,Z),
                                  edge(V,X,Op), edge(X,Y,Op), edge(Y,Z,Op),
                                  holds(color_vertex(Z,C2),I),I < n.

happens(rotate_right(S),I):- occurs(turn(C,right),I),outer_circle(C),
                             adjacent_surface(C,S), clockwise(S).
happens(rotate_left(S),I):- occurs(turn(C,left),I),outer_circle(C),
                            adjacent_surface(C,S), clockwise(S).
happens(rotate_left(S),I):- occurs(turn(C,right),I),outer_circle(C),
                            adjacent_surface(C,S), counter_clock(S).
happens(rotate_right(S),I):- occurs(turn(C,left),I),outer_circle(C),
                             adjacent_surface(C,S), counter_clock(S).

holds(color_vertex(V,C), I+1) :-  happens(rotate_right(S),I), contains(S,V),
                                  contains(S,X), contains(S,Y),
                                  edge2(V,X,right), edge2(X,Y,right),
                                  holds(color_vertex(Y,C),I), I < n.

holds(color_vertex(V,C), I+1) :-  happens(rotate_left(S),I), contains(S,V),
                                  contains(S,X), contains(S,Y),edge2(V,X,left),
                                  edge2(X,Y,left), holds(color_vertex(Y,C),I),
                                  I < n.


% state constraint
-holds(color_vertex(V,C2), I) :- color(C2), holds(color_vertex(V,C1),I),
                                 color(C1), C1 != C2.

% CWA for defined fluents
-holds(F,I) :- step(I), fluent(defined,F), not holds(F,I).

% inertia axiom:
holds(F, I + 1) :- fluent(inertial, F), holds(F,I), not -holds(F, I+1), I<n.
-holds(F,I+1) :- fluent(inertial, F), -holds(F,I), not holds(F, I+1), I<n.

% CWA for actions:
-occurs(A,I) :- action(A), step(I), not occurs(A,I).

%initial state
%use config files

%executability condition
-occurs(turn(C,Op),I) :- occurs(turn(C, D),I), opposite(D,Op).

%simple planning module:
success :- goal(I), I<=n.
:- not success.

1{occurs(A,I): action(A)}1 :- step(I), not goal(I), I < n.

%goal state:
goal(I):- holds(completed(front),I), holds(completed(top),I),
          holds(completed(back),I), holds(completed(bottom),I),
          holds(completed(left_side),I), holds(completed(right_side),I).

#show occurs/2.

