%%% Author: William Michael Mortl
%%% Feel free to use this code for educational purposes, any other use
%%%     requires citations to William Michael Mortl

%%% This file simply tests my sudoku solver
%%% PLEASE NOTE: the sudoku solver requires the Matlab optimization toolkit

%% a couple of puzzles to test, please note: place zeroes where we do not know the number
% testPuzzle = ...
%  [0,0,7,8,0,5,2,0,0;8,0,0,6,0,4,0,0,5;0,1,0,0,9,0,0,8,0;4,0,0,2,8,9,0,0,7;0,0,0,0,0,0,0,0,0;5,0,0,7,6,1,0,0,2;0,7,0,0,3,0,0,6,0;3,0,0,1,0,6,0,0,4;0,0,2,5,0,8,1,0,0];
testPuzzle = ...
 [6,9,0,5,0,0,8,0,0;0,0,0,0,3,8,0,0,0;7,0,3,0,0,0,0,2,0;0,0,0,0,1,0,3,0,0;2,3,0,0,4,0,0,9,8;0,0,4,0,7,0,0,0,0;0,5,0,0,0,0,2,0,1;0,0,0,2,6,0,0,0,0;0,0,2,0,0,1,0,8,9];

%% display the puzzle
disp('The problem:');
testPuzzle

%% solve the puzzle
disp('Solving...');
[solution] = sudoku(testPuzzle);

%% display the solution
disp('The solution:');
solution

%% leave solution, cleanup the rest
clear testPuzzle;

