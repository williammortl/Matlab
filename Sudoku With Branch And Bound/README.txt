Sudoku solver with Branch and Bound Integer Linear Programming Solver
by William Mortl

/ Introduction

This repository contains a simple branch and bound integer linear programming (ILP) solver as well as a Sudoku solver which uses said ILP solver. The ILP solver has a unique feature in so much as that it can be called to return the first acceptable solution. This is important when solving Sudoku since there is nothing to maximize/minimize. Any solution is acceptable as long as it obeys the rules of Sudoku.

It is important to note that this requires the Matlab "linprog" function which is a part of the Optimization Toolkit in order to function.

/ Usage

Included is a Matlab script named "testSudoku.m" that shows how to call the Sudoku solver. However, it is quite easy to do. Simply create a 9x9 matrix and place the numbers in the correct location as they appear in the puzzle. Where you are asked to fill in the number, simply place a 0. This tells the solver that this is a position which needs a number.

The solver will then return a completed matrix which is the Sudoku solution.

/ Example:

>> testSudoku
The problem:

testPuzzle =

     0     0     7     8     0     5     2     0     0
     8     0     0     6     0     4     0     0     5
     0     1     0     0     9     0     0     8     0
     4     0     0     2     8     9     0     0     7
     0     0     0     0     0     0     0     0     0
     5     0     0     7     6     1     0     0     2
     0     7     0     0     3     0     0     6     0
     3     0     0     1     0     6     0     0     4
     0     0     2     5     0     8     1     0     0

Solving...
The solution:

solution =

     6     4     7     8     1     5     2     3     9
     8     9     3     6     2     4     7     1     5
     2     1     5     3     9     7     4     8     6
     4     3     1     2     8     9     6     5     7
     7     2     6     4     5     3     8     9     1
     5     8     9     7     6     1     3     4     2
     1     7     4     9     3     2     5     6     8
     3     5     8     1     7     6     9     2     4
     9     6     2     5     4     8     1     7     3

/ Errata:

This solver works just fine with an entire matrix of zeroes and will predictably give the same correct solution. This is by design. Also, you can give the solver incomplete Sudoku puzzles, which have multple solutions, and it will in fact solve them just fine. However, if you give the solver a puzzle which has NO solution, it may return a solution with a zero in it occaisionally. This is a known issue and I am working on understanding it.