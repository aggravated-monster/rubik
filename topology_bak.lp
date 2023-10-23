vertex(1..54).
circle(top_outer;top_middle;top_inner;left_outer;left_middle;left_inner;right_outer;right_middle;right_inner).
face(top;bottom;left;right;front;back).


% define the topology.
% the vertices can be numbered arbitrarily, but for readability we will group them in logical groups,
% each representing a face, to stick with the domain semantics of a Rubik's Cube
% (we do not really care about the orientation though, but this makes it easier to talk about it and interpret results).
lies_on((1..9),top).
lies_on((10..18),right).
lies_on((19..27),bottom).
lies_on((28..36),left).
lies_on((37..45),front).
lies_on((46..54),back).

lies_outside(left, right_outer).
lies_outside(back, left_outer).
lies_outside(bottom, top_outer).
% a Rubik's Cube is very Closed World...
-lies_outside(F,X) :- face(F),
                    circle(X),
                    not lies_outside(F,X).

lies_inside(top, top_inner).
lies_inside(right, right_inner).
lies_inside(front, left_inner).
% a Rubik's Cube is very Closed World...
-lies_inside(F,X) :- face(F),
                    circle(X),
                    not lies_inside(F,X).


% To make life easy, we do not define a full graph structure: we only care about the circles, and the number
% and order of each vertex on these circles. The topology below sets the structure in stone.
% (Instead of meddling with edges, we will simply rotate the colors once we start manipulating the "cube"
successor(left_outer,1,2).
successor(left_outer,2,3).
successor(left_outer,3,10).
successor(left_outer,10,11).
successor(left_outer,11,12).
successor(left_outer,12,19).
successor(left_outer,19,20).
successor(left_outer,20,21).
successor(left_outer,21,28).
successor(left_outer,28,29).
successor(left_outer,29,30).
successor(left_outer,30,1).

successor(left_middle,8,9).
successor(left_middle,9,4).
successor(left_middle,4,17).
successor(left_middle,17,18).
successor(left_middle,18,13).
successor(left_middle,13,26).
successor(left_middle,26,27).
successor(left_middle,27,22).
successor(left_middle,22,35).
successor(left_middle,35,36).
successor(left_middle,36,31).
successor(left_middle,31,8).

successor(left_inner,7,6).
successor(left_inner,6,5).
successor(left_inner,5,16).
successor(left_inner,16,15).
successor(left_inner,15,14).
successor(left_inner,14,25).
successor(left_inner,25,24).
successor(left_inner,24,23).
successor(left_inner,23,34).
successor(left_inner,34,33).
successor(left_inner,33,32).
successor(left_inner,32,7).

successor(right_outer,52,53).
successor(right_outer,53,46).
successor(right_outer,46,21).
successor(right_outer,21,22).
successor(right_outer,22,23).
successor(right_outer,23,37).
successor(right_outer,37,38).
successor(right_outer,38,39).
successor(right_outer,39,7).
successor(right_outer,7,8).
successor(right_outer,8,1).
successor(right_outer,1,52).

successor(right_middle,51,54).
successor(right_middle,54,47).
successor(right_middle,47,20).
successor(right_middle,20,27).
successor(right_middle,27,24).
successor(right_middle,24,44).
successor(right_middle,44,45).
successor(right_middle,45,40).
successor(right_middle,40,6).
successor(right_middle,6,9).
successor(right_middle,9,2).
successor(right_middle,2,51).

successor(right_inner,50,49).
successor(right_inner,49,48).
successor(right_inner,48,19).
successor(right_inner,19,26).
successor(right_inner,26,25).
successor(right_inner,25,43).
successor(right_inner,43,42).
successor(right_inner,42,41).
successor(right_inner,41,5).
successor(right_inner,5,4).
successor(right_inner,4,3).
successor(right_inner,3,50).

successor(top_outer,34,35).
successor(top_outer,35,28).
successor(top_outer,28,46).
successor(top_outer,46,47).
successor(top_outer,47,48).
successor(top_outer,48,12).
successor(top_outer,12,13).
successor(top_outer,13,14).
successor(top_outer,14,43).
successor(top_outer,43,44).
successor(top_outer,44,37).
successor(top_outer,37,34).

successor(top_middle,33,36).
successor(top_middle,36,29).
successor(top_middle,29,53).
successor(top_middle,53,54).
successor(top_middle,54,49).
successor(top_middle,49,11).
successor(top_middle,11,18).
successor(top_middle,18,15).
successor(top_middle,15,42).
successor(top_middle,42,45).
successor(top_middle,45,38).
successor(top_middle,38,33).

successor(top_inner,32,31).
successor(top_inner,31,30).
successor(top_inner,30,52).
successor(top_inner,52,51).
successor(top_inner,51,50).
successor(top_inner,50,10).
successor(top_inner,10,17).
successor(top_inner,17,16).
successor(top_inner,16,41).
successor(top_inner,41,40).
successor(top_inner,40,39).
successor(top_inner,39,32).

% swap places to define predecessors. I have a gut feeling this comes in handy when rotating
predecessor(X,S,V) :- successor(X,V,S).

% the faces also need to rotate, so they need an order as well
face_successor(top,1,2).
face_successor(top,2,3).
face_successor(top,3,4).
face_successor(top,4,5).
face_successor(top,5,6).
face_successor(top,6,7).
face_successor(top,7,8).
face_successor(top,8,1).

face_successor(right,10,11).
face_successor(right,11,12).
face_successor(right,12,13).
face_successor(right,13,14).
face_successor(right,14,15).
face_successor(right,15,16).
face_successor(right,16,17).
face_successor(right,17,10).

face_successor(bottom,19,20).
face_successor(bottom,20,21).
face_successor(bottom,21,22).
face_successor(bottom,22,23).
face_successor(bottom,23,24).
face_successor(bottom,24,25).
face_successor(bottom,25,26).
face_successor(bottom,26,19).

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