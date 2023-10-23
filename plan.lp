#include "rubik.lp".

%% Planning

success :- goal(I),
            I <= n.
:- not success.

{occurs(A,I) : action(A)} = 1 :- step(I),
                                 not goal(I),
                                 I < n.

% fix initial state
%#include "initial_state_almost_solved_alt_colors.lp".
%#include "initial_state_scrambled_alt_colors.lp".
%% note: solving for 5 moves can take up to 5 minutes
%#include "initial_state_5_moves.lp".
%% note: solving for 4 moves takes about 15 seconds
#include "initial_state_4_moves.lp".
%#include "initial_state_3_moves.lp".
%#include "initial_state_2_moves.lp".
%#include "initial_state_1_move.lp".
% do not exceed 5
#const n = 4.

#show occurs/2.