vertex(1..54).
orbit(outer;middle;inner).
projection(xy;yz;xz).
%circle(xy,outer;xy,middle;xy,inner;xz,outer;xz,middle;xz,inner;yz,outer;yz,middle;yz,inner).
face(top;bottom;left;right;front;back).

circle(P,O) :- projection(P), orbit(O).

% define the topology.
% the vertices can be numbered arbitrarily, but for readability we will group them in logical groups,
% each representing a face, to stick with the domain semantics of a Rubik's Cube
% (we do not really care about the orientation though, but this makes it easier to talk about it and interpret results).
lies_on((1..9),top).
lies_on((10..18),right).
lies_on((25..27),bottom).
lies_on((28..36),left).
lies_on((37..45),front).
lies_on((46..54),back).

lies_outside(left, yz, outer).
lies_outside(back, xz, outer).
lies_outside(bottom, xy, outer).
% a Rubik's Cube is very Closed World...
-lies_outside(F,P,O) :- face(F),
                    circle(P,O),
                    not lies_outside(F,P,O).

lies_inside(top, xy, inner).
lies_inside(right, yz, inner).
lies_inside(front, xz, inner).
% a Rubik's Cube is very Closed World...
-lies_inside(F,P,O) :- face(F),
                    circle(P,O),
                    not lies_inside(F,P,O).


% To make life easy, we do not define a full graph structure: we only care about the circles, and the number
% and order of each vertex on these circles. The topology below sets the structure in stone.
% (Instead of meddling with edges, we will simply rotate the colors once we start manipulating the "cube"
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
predecessor(P,O,S,V) :- successor(P,O,V,S).

% the faces also need to rotate, so they need an order as well
face_successor(top,1,2).
face_successor(top,2,3).
face_successor(top,3,4).
face_successor(top,4,5).
face_successor(top,5,6).
face_successor(top,6,7).
face_successor(top,7,8).
face_successor(top,8,1).

face_successor(right,16,17).
face_successor(right,17,10).
face_successor(right,10,11).
face_successor(right,11,12).
face_successor(right,12,13).
face_successor(right,13,14).
face_successor(right,14,15).
face_successor(right,15,16).

face_successor(bottom,25,26).
face_successor(bottom,26,19).
face_successor(bottom,19,20).
face_successor(bottom,20,21).
face_successor(bottom,21,22).
face_successor(bottom,22,23).
face_successor(bottom,23,24).
face_successor(bottom,24,25).

face_successor(left,28,29).
face_successor(left,29,30).
face_successor(left,30,31).
face_successor(left,31,32).
face_successor(left,32,33).
face_successor(left,33,34).
face_successor(left,34,35).
face_successor(left,35,28).

face_successor(front,37,38).
face_successor(front,38,39).
face_successor(front,39,40).
face_successor(front,40,41).
face_successor(front,41,42).
face_successor(front,42,43).
face_successor(front,43,44).
face_successor(front,44,37).

face_successor(back,46,47).
face_successor(back,47,48).
face_successor(back,48,49).
face_successor(back,49,50).
face_successor(back,50,51).
face_successor(back,51,52).
face_successor(back,52,53).
face_successor(back,53,46).