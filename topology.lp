vertex(1..54).

%% in the  graph representation, each group of concentric circles represent a projection
%% on one of the planes in a 3D xyz coordination system.
projection(xy;yz;xz).

%% each circle corresponds to a 'layer' of the cube.
%% In the 2d representation, we essentially lost the notions of top/bottom, left/right, front/back
%% so instead we will name these Orbits.
orbit(outer;middle;inner).

%% A circle is then a projection of a 'layer' on a plane
circle(P,O) :- projection(P), orbit(O).

%% In the graph representation, there are 6 clusters, which in the 3d world represent the faces.
%% Here, the 3d terms creep back. The naming of the clusters is arbitrary, but it turns out,
%% to keep one's sanity, it is a really good idea to still connect to the 3d world.
face(top;bottom;left;right;front;back).

% define the topology.
% the vertices can be numbered arbitrarily, but to stick with the domain semantics of a Rubik's Cube
% and for readability we will group them in logical groups, each representing a face.
% (we do not really care about the orientation though, but this makes it easier to talk about it and interpret results).
% Note: the original plan was to use this in the goal rule.
% Now it is only used in the initial state of a solved cube, which is used nowhere.
% This relation therefore has no closure (and could be removed altogether)
lies_on((1..9),top).
lies_on((10..18),right).
lies_on((25..27),bottom).
lies_on((28..36),left).
lies_on((37..45),front).
lies_on((46..54),back).

%% outsider faces co-rotate when an outer circle is rotated, so they must be identifiable
lies_outside(left, yz, outer).
lies_outside(back, xz, outer).
lies_outside(bottom, xy, outer).
% a Rubik's Cube is very Closed World...
-lies_outside(F,P,O) :- face(F),
                    circle(P,O),
                    not lies_outside(F,P,O).

%% insider faces co-rotate when an inner circle is rotated, so they must be identifiable
lies_inside(top, xy, inner).
lies_inside(right, yz, inner).
lies_inside(front, xz, inner).
% a Rubik's Cube is very Closed World...
-lies_inside(F,P,O) :- face(F),
                    circle(P,O),
                    not lies_inside(F,P,O).


% To make life easy, we never manipulate the graph structure. The topology below sets the structure in stone.
% Instead of meddling with edges, we will simply rotate the colors once we start manipulating the "cube".
successor(xz,outer,1,2).
successor(xz,outer,2,3).
successor(xz,outer,3,16).
successor(xz,outer,16,17).
successor(xz,outer,17,10).
successor(xz,outer,10,25).
successor(xz,outer,25,26).
successor(xz,outer,26,19).
successor(xz,outer,19,28).
successor(xz,outer,28,29).
successor(xz,outer,29,30).
successor(xz,outer,30,1).

successor(xz,middle,8,9).
successor(xz,middle,9,4).
successor(xz,middle,4,15).
successor(xz,middle,15,18).
successor(xz,middle,18,11).
successor(xz,middle,11,24).
successor(xz,middle,24,27).
successor(xz,middle,27,20).
successor(xz,middle,20,35).
successor(xz,middle,35,36).
successor(xz,middle,36,31).
successor(xz,middle,31,8).

successor(xz,inner,7,6).
successor(xz,inner,6,5).
successor(xz,inner,5,14).
successor(xz,inner,14,13).
successor(xz,inner,13,12).
successor(xz,inner,12,23).
successor(xz,inner,23,22).
successor(xz,inner,22,21).
successor(xz,inner,21,34).
successor(xz,inner,34,33).
successor(xz,inner,33,32).
successor(xz,inner,32,7).

successor(yz,outer,52,53).
successor(yz,outer,53,46).
successor(yz,outer,46,19).
successor(yz,outer,19,20).
successor(yz,outer,20,21).
successor(yz,outer,21,37).
successor(yz,outer,37,38).
successor(yz,outer,38,39).
successor(yz,outer,39,7).
successor(yz,outer,7,8).
successor(yz,outer,8,1).
successor(yz,outer,1,52).

successor(yz,middle,51,54).
successor(yz,middle,54,47).
successor(yz,middle,47,26).
successor(yz,middle,26,27).
successor(yz,middle,27,22).
successor(yz,middle,22,44).
successor(yz,middle,44,45).
successor(yz,middle,45,40).
successor(yz,middle,40,6).
successor(yz,middle,6,9).
successor(yz,middle,9,2).
successor(yz,middle,2,51).

successor(yz,inner,50,49).
successor(yz,inner,49,48).
successor(yz,inner,48,25).
successor(yz,inner,25,24).
successor(yz,inner,24,23).
successor(yz,inner,23,43).
successor(yz,inner,43,42).
successor(yz,inner,42,41).
successor(yz,inner,41,5).
successor(yz,inner,5,4).
successor(yz,inner,4,3).
successor(yz,inner,3,50).

successor(xy,outer,34,35).
successor(xy,outer,35,28).
successor(xy,outer,28,46).
successor(xy,outer,46,47).
successor(xy,outer,47,48).
successor(xy,outer,48,10).
successor(xy,outer,10,11).
successor(xy,outer,11,12).
successor(xy,outer,12,43).
successor(xy,outer,43,44).
successor(xy,outer,44,37).
successor(xy,outer,37,34).

successor(xy,middle,33,36).
successor(xy,middle,36,29).
successor(xy,middle,29,53).
successor(xy,middle,53,54).
successor(xy,middle,54,49).
successor(xy,middle,49,17).
successor(xy,middle,17,18).
successor(xy,middle,18,13).
successor(xy,middle,13,42).
successor(xy,middle,42,45).
successor(xy,middle,45,38).
successor(xy,middle,38,33).

successor(xy,inner,32,31).
successor(xy,inner,31,30).
successor(xy,inner,30,52).
successor(xy,inner,52,51).
successor(xy,inner,51,50).
successor(xy,inner,50,16).
successor(xy,inner,16,15).
successor(xy,inner,15,14).
successor(xy,inner,14,41).
successor(xy,inner,41,40).
successor(xy,inner,40,39).
successor(xy,inner,39,32).

% swap places to define predecessors. I have a gut feeling this comes in handy when rotating
% This is not strictly necessary, but makes the rotating rules more comprehensible
predecessor(P,O,S,V) :- successor(P,O,V,S).

% the faces also need to rotate, so they need an order as well
successor(top,1,2).
successor(top,2,3).
successor(top,3,4).
successor(top,4,5).
successor(top,5,6).
successor(top,6,7).
successor(top,7,8).
successor(top,8,1).

successor(right,16,17).
successor(right,17,10).
successor(right,10,11).
successor(right,11,12).
successor(right,12,13).
successor(right,13,14).
successor(right,14,15).
successor(right,15,16).

successor(bottom,25,26).
successor(bottom,26,19).
successor(bottom,19,20).
successor(bottom,20,21).
successor(bottom,21,22).
successor(bottom,22,23).
successor(bottom,23,24).
successor(bottom,24,25).

successor(left,28,29).
successor(left,29,30).
successor(left,30,31).
successor(left,31,32).
successor(left,32,33).
successor(left,33,34).
successor(left,34,35).
successor(left,35,28).

successor(front,37,38).
successor(front,38,39).
successor(front,39,40).
successor(front,40,41).
successor(front,41,42).
successor(front,42,43).
successor(front,43,44).
successor(front,44,37).

successor(back,46,47).
successor(back,47,48).
successor(back,48,49).
successor(back,49,50).
successor(back,50,51).
successor(back,51,52).
successor(back,52,53).
successor(back,53,46).

predecessor(F,S,V) :- successor(F,V,S).