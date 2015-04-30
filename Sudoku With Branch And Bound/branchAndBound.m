%%% Author: William Michael Mortl
%%% Feel free to use this code for educational purposes, any other use
%%%     requires citations to William Michael Mortl

function [optVal, optSolution, cannotSolve, pathSol] = branchAndBound(P, q, r, pathString, takeFirst)
%% Function: [optVal, optSolution, stalls, totalPivots] = branchAndBound(P,q,r,useLinprog,pathString,takeFirst)
%% Programmed by: William M Mortl
%% Description: branch and bound integer linear programming solver, requires Matlab Optimization Toolkit and linprog
%% Inputs: 
%%    (P, q, r) === For linear programming, these map to P=>A (need to pad with slack vars), q=>b, r=>c (need to pad with slack vars)
%%    pathString === used for recursion, should be ''
%%    takeFirst === if 1 then use the first acceptable solution, no optimization required
%% Outputs:
%%    objVal === new objective value
%%    optSolution === a vector of values for the original problem variables
%%    cannotSolve === this is 1 if there was no solution

    %% global variables
    global maxObj;
    if (isempty(pathString))
        maxObj = 0;
    end

    %% call linprog
    cannotSolve = 0;
    [n, ~] = size(r);
    [optSolution, optVal, exitFlag] = linprog(-r, P, q, [], [], zeros(n,1), [], [], optimset('Display', 'off'));
    if (exitFlag <= 0)
        cannotSolve = 1;
    end
    
    %% we never really get back integers, even if they are integers, so
    %%  this helps to identify integers
    optSolution = round(optSolution * 1e4) / 1e4;
    optVal = (round(-1 * optVal * 1e4) / 1e4);
    
    %% examine previous call to linprog, make sure the call was solved
    %%  processing forward, also, exit early if there was a solution
    %%  and branch and bound is set to return the first feasible solution
    pathSol = pathString;
    if ((cannotSolve == 1) || ((takeFirst == 1) && (maxObj > 0)))
        optVal = 0;
        optSolution = [];
        cannotSolve = 1;
        pathSol = 'N/A';
        return;
    end

    %% check to see if all solution values are integers
    branchOn = vectorAllInteger(optSolution);

    %% if not all integers, branch on lowest ordinal number
    if (branchOn > 0)

        % short circuit to trim tree
        if (optVal < maxObj)
            optVal = 0;
            optSolution = [];
            cannotSolve = 1;
            pathSol = 'N/A';
            return;
        end

        % initialize
        [~, widthP] = size(P);
        newRow = zeros(1, widthP);
        newRow(1, branchOn) = 1;

        % generate left branch variables
        PL = [P; newRow];
        qL = [q; floor(optSolution(branchOn))];
        pathL = strcat(pathString, ' x', num2str(branchOn), '<floor(', num2str(optSolution(branchOn)), ')');

        % branch left
        [optValL, optSolutionL, cannotSolveL, pathSolL] = branchAndBound(PL, qL, r, pathL, takeFirst);
        optSolutionL = round(optSolutionL * 1e4) / 1e4;

        % generate right branch variables
        PR = [P; (-1 * newRow)];
        qR = [q; (-1 * ceil(optSolution(branchOn)))];
        pathR = strcat(pathString, ' x', num2str(branchOn), '>ceil(', num2str(optSolution(branchOn)), ')');

        % branch right
        [optValR, optSolutionR, cannotSolveR, pathSolR] = branchAndBound(PR, qR, r, pathR, takeFirst);
        optSolutionR = round(optSolutionR * 1e4) / 1e4;

        % check to see if we have a solution
        solToUse = 0; %1 = L, 2 = R
        if (cannotSolveL == 1)
            if (cannotSolveR == 0)
                if (vectorAllInteger(optSolutionR) == 0)
                    solToUse = 2;
                end
            end
        elseif (cannotSolveR == 1)
            if (cannotSolveL == 0)
                if (vectorAllInteger(optSolutionL) == 0)
                    solToUse = 1;
                end
            end
        else
            if (vectorAllInteger(optSolutionL) == 0)
                if (vectorAllInteger(optSolutionR) == 0)
                    if (optValL >= optValR)
                        solToUse = 1;
                    else
                        solToUse = 2;
                    end
                else
                    solToUse = 1;
                end
            elseif (vectorAllInteger(optSolutionR) == 0)
                solToUse = 2;
            end
        end

        % setup output values
        if (solToUse == 0)
            optVal = 0;
            optSolution = [];
            cannotSolve = 1;
            pathSol = 'N/A';
        elseif (solToUse == 1)
            optVal = optValL;
            optSolution = optSolutionL;
            cannotSolve = 0;
            pathSol = pathSolL;
        else
            optVal = optValR;
            optSolution = optSolutionR;
            cannotSolve = 0;
            pathSol = pathSolR;
        end
    end

    %% update maxObj
    if (optVal > maxObj)
        maxObj = optVal;
    end

end

function [index] = vectorAllInteger(v)
%% Function: [index] = vectorAllInteger(v)
%% Programmed by: William M Mortl
%% Description: checks to see if all vector elements are integer values
%% Inputs: 
%%    v === a vector to examine
%% Outputs:
%%    index === the index of the first non-integer element in vector v, 0 if all are integers

    %% check to see if all elements of the vector are integers
    index = 0;
    [sizeV, ~] = size(v);
    for checkVal = 1:sizeV
        if (mod(v(checkVal), 1) ~= 0)
            index = checkVal;
            break;
        end
    end

end