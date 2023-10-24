% fix the initial state
holds(color(V,yellow), 0) :- lies_on(V, top).
holds(color(V,green), 0) :- lies_on(V, right).
holds(color(V,white), 0) :- lies_on(V, bottom).
holds(color(V,blue), 0) :- lies_on(V, left).
holds(color(V,red), 0) :- lies_on(V, front).
holds(color(V,orange), 0) :- lies_on(V, back).