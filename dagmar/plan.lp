#include "rubik.lp".

%% Planning

success :- goal(I),
            I <= n.
:- not success.

{occurs(A,I) : action(A)} = 1 :- step(I),
                                 not goal(I),
                                 I < n.

% fix initial state
% -------------------------------------------------------------------------------
% initial states based on the video clip
%#include "initial_state_video_2_moves.lp".

% initial states based on the video clip with the actual video colors
% note: this requires a modification of rubik.lp as well
%#include "initial_state_video_2_moves_alt_colors.lp".
% initial state of the video. This requires 35 steps to solve, so don't even think about it.
%#include "initial_state_video_35_moves_alt_colors.lp".

%% note: solving for 5 moves can take up to 5 minutes on a single thread
%% Using multithreading (command line -t option) speeds things up, but can still take around 90 seconds
% clingo -n 1 plan.lp can take up to 5 minutes to find a 7 step solution
%#include "initial_state_7_moves.lp".
% clingo -n 1 plan.lp can take up to 75 seconds to find a 6 step solution
%#include "initial_state_6_moves.lp".
%#include "initial_state_5_moves.lp".
%#include "initial_state_4_moves.lp".
#include "initial_state_3_moves.lp".
%#include "initial_state_2_moves.lp".
%#include "initial_state_1_move.lp".
%#include "initial_state_maxim_6_moves.lp".
#const n = 3.

#show occurs/2.
%#show holds/2.