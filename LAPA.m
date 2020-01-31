%PA 4 - Laplace Equation by Iteration
%ELEC 4700
%Philippe Masson


xSize = 10; %size of the matrix
ySize = 10; %size of the matrix
xDel = 1; %delta X
yDel = xDel; %delta Y
maxIterations = 1000; %maximum number of iterations
vMatrix = zeros(xSize,ySize); %create our matrix of values
oldMatrix = zeros(xSize,ySize); %another matrix to be used to clone the new one

TBC_Left = 1;
TBC_Right = 0;

for i = 1:maxIterations %keep running until reached max iterations
    for m = 1:xSize %loop through columns
        for n = 1:ySize %loop through rows
            
            if(m == 1) %left boundary
                vMatrix(n,m) = TBC_Left;
            elseif(m == xSize) %right boundary
                vMatrix(n,m) = TBC_Right;
            elseif(n == 1) %top boundary
                vMatrix(n,m) = oldMatrix(n+1,m);
            elseif(n == ySize) %bottom boundary
                vMatrix(n,m) = oldMatrix(n-1,m);
            else
                vMatrix(n,m) = (oldMatrix(n,m-1) + oldMatrix(n,m+1) + oldMatrix(n-1,m) + oldMatrix(n+1,m))/4 * xDel^2;
            end            
        end
    end    
    oldMatrix = vMatrix;
end

