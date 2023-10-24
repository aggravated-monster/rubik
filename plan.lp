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
%#include "initial_state_5_moves.lp".
%% note: solving for 4 moves takes about 15 seconds
#include "initial_state_4_moves.lp".
%#include "initial_state_3_moves.lp".
%#include "initial_state_2_moves.lp".
%#include "initial_state_1_move.lp".
% do not exceed 5
#const n = 4.

#show occurs/2.