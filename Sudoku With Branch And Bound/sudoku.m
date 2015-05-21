function [output] = Sudoku(puzzle)
% Function: [output] = Sudoku(puzzle)
% Author: William Michael Mortl
% Feel free to use this code for educational purposes, any other use
%     requires citations and recompence to William Michael Mortl
% Description: solves 9x9 sudoku puzzles via branch and bound and integer linear programming, requires Matlab Optimization Toolkit and linprog
% Inputs: 
%    puzzle === the soduku puzzle in matrix form, 0 represents unknown
% Outputs:
%    output === the solution in matrix form

    %% initialization
    output = [];
    totalSum = 81;
    P = [];                                         % value, row, col
    q = [];
    r = ones(totalSum * 9, 1);
    
    %% check the size of the puzzle
    [rowsPuzzle, colsPuzzle] = size(puzzle);
    if ((rowsPuzzle ~= 9) || (colsPuzzle ~= 9))
        disp('Error occurred, puzzle must be 9x9.');
        return;
    end
    
    %% check to make sure the puzzle only contains values between 0-9
    for i = 1:9
        for j = 1:9
            cellValue = puzzle(i, j);
            if ((cellValue < 0) || (cellValue > 9))
                disp('Error occurred, value must be between 0 and 9');
                return;
            end
        end
    end
    
    %% rows groupings => values, row, col
    for row = 1:9
        rowOffset = (row - 1) * 9;
        q = [q; ones(9, 1)];
        for val = 1:9
            newRow = zeros(1, totalSum * 9);
            valOffset = (val - 1) * 81;
            for col = 1:9
                newRow(1, valOffset + rowOffset + col) = 1;
            end
            P = [P; newRow];
        end
    end

    %% col groupings => values, row, col
    for col = 1:9
        q = [q; ones(9, 1)];
        for val = 1:9
            newRow = zeros(1, totalSum * 9);
            valOffset = (val - 1) * 81;
            for row = 1:9
                rowOffset = (row - 1) * 9;
                newRow(1, valOffset + rowOffset + col) = 1;
            end
            P = [P; newRow];
        end
    end

    %% quadrants
    % 1 2 3
    % 4 5 6
    % 7 8 9
    [P, q] = SudokuParseQuadrant(totalSum, P, q, 1, 3, 1, 3);
    [P, q] = SudokuParseQuadrant(totalSum, P, q, 1, 3, 4, 6);
    [P, q] = SudokuParseQuadrant(totalSum, P, q, 1, 3, 7, 9);
    [P, q] = SudokuParseQuadrant(totalSum, P, q, 4, 6, 1, 3);
    [P, q] = SudokuParseQuadrant(totalSum, P, q, 4, 6, 4, 6);
    [P, q] = SudokuParseQuadrant(totalSum, P, q, 4, 6, 7, 9);
    [P, q] = SudokuParseQuadrant(totalSum, P, q, 7, 9, 1, 3);
    [P, q] = SudokuParseQuadrant(totalSum, P, q, 7, 9, 4, 6);
    [P, q] = SudokuParseQuadrant(totalSum, P, q, 7, 9, 7, 9);

    %% each cell only 1 value
    for row = 1:9
        rowOffset = (row - 1) * 9;
        q = [q; ones(9, 1)];
        for col = 1:9
            newRow = zeros(1, totalSum * 9);
            for val = 1:9
                valOffset = (val - 1) * 81;
                newRow(1, valOffset + rowOffset + col) = 1;
            end
            P = [P; newRow];
        end
    end

    %% restrict values
    P = [P; ones(1, totalSum * 9)];
    q = [q; totalSum];

    %% add existing values
    for row = 1:9
        rowOffset = (row - 1) * 9;
        for col = 1:9
            if (puzzle(row, col) ~= 0)
                valOffset = (puzzle(row, col) - 1) * 81;
                q = [q; 1];
                newRow = zeros(1, totalSum * 9); 
                newRow(1, valOffset + rowOffset + col) = 1;     
                P = [P; newRow];
                q = [q; -1];
                newRow = zeros(1, totalSum * 9); 
                newRow(1, valOffset + rowOffset + col) = -1;     
                P = [P; newRow];
            end
        end
    end

    %% run branch and bound
    [~, optSolution, cannotSolve, ~] = BranchAndBound(P, q, r, '', 1);

    %% if solvable then build output
    if (cannotSolve == 1)
        
        % display error message
        disp('Error occurred, could not solve the puzzle.');
        
    else
       
        % build output
        output = zeros(9, 9);
        val = 1;
        row = 1;
        col = 1;
        for loopVar = 1:(totalSum * 9)

            % save values in output
            if (optSolution(loopVar) == 1)
                output(row, col) = val;
            end

            % enumerate
            col = col + 1;
            if (col >= 10)
                col = 1;
                row = row + 1;
                if (row >= 10)
                    row = 1;
                    val = val + 1;
                end
            end
        end
    end
end

function [P, q] = SudokuParseQuadrant(totalSum, P, q, rowStart, rowEnd, colStart, colEnd)
%% Function: [P, q] = sudokuParseQuadrant(totalSum, puzzle, P, q, rowStart, rowEnd, colStart, colEnd)
%% Programmed by: William M Mortl
%% Description: sets up the constraints for the quadrants of a 9x9 sudoku puzzle
%% Inputs:
%%    totalSum === the total amount of 1 values
%%    P, q === the P and q values of the ILP
%%    rowStart-End, colStart-End === the square coordinates of the quadrant
%% Outputs:
%%    P, q === the P and q values of the ILP

    %% quadrant
    q = [q; ones(9, 1)];
    for val = 1:9
        newRow = zeros(1, totalSum * 9);
        valOffset = (val - 1) * 81;
        for row = rowStart:rowEnd
            rowOffset = (row - 1) * 9;
            for col = colStart:colEnd
                newRow(1, valOffset + rowOffset + col) = 1;
            end
        end
        P = [P; newRow];
    end

end
