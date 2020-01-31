%PA 4 - Laplace Equation by Iteration
%ELEC 4700
%Philippe Masson


xSize = 20; %size of the matrix
ySize = 20; %size of the matrix
xDel = 1; %delta X
yDel = xDel; %delta Y
maxIterations = 400; %maximum number of iterations
vMatrix = zeros(xSize,ySize); %create our matrix of values
oldMatrix = zeros(xSize,ySize); %another matrix to be used to clone the new one
vecMatrix = zeros(xSize,ySize); %matrix of the vectors
[xMesh, yMesh] = meshgrid(1:xDel:xSize, 1:yDel:ySize);

TBC_Left = 1;
TBC_Right = 1;
TBC_Top = 0;
TBC_Bottom = 0;

tiledlayout(3,1);
set(gcf, 'Position', get(0, 'Screensize'));

for i = 1:maxIterations %keep running until reached max iterations
    for m = 1:xSize %loop through columns
        for n = 1:ySize %loop through rows
            
            if(m == 1) %left boundary
                vMatrix(n,m) = TBC_Left;
            elseif(m == xSize) %right boundary
                vMatrix(n,m) = TBC_Right;
            elseif(n == 1) %top boundary
                %vMatrix(n,m) = oldMatrix(n+1,m);
                vMatrix(n,m) = TBC_Top;
            elseif(n == ySize) %bottom boundary
               %vMatrix(n,m) = oldMatrix(n-1,m);
                vMatrix(n,m) = TBC_Bottom;
            else
                vMatrix(n,m) = (oldMatrix(n,m-1) + oldMatrix(n,m+1) + oldMatrix(n-1,m) + oldMatrix(n+1,m))/4 * xDel^2;
            end            
        end
    end    
    
    [xVectors, yVectors] = gradient(oldMatrix(:,:));
    
    nexttile(1);
    quiver(xMesh, yMesh, -xVectors, -yVectors);
    title(['Iteration: ' num2str(i)]);
    
    nexttile(2);
    surf(xMesh, yMesh, vMatrix);
    
    nexttile(3);
    hold on;
    plot([i-1, i],[mean(mean(oldMatrix)),mean(mean(vMatrix))], 'b');
    ylim([0,1]);
    hold off;
    pause(0.001);
    
    
    
    oldMatrix = vMatrix;
end

