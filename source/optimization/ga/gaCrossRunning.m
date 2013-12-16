function [child1,child2]=crossRunning(parent1,parent2,stringlength,dimension)

% CrossOver point for each parameter
cpoint=round((stringlength-1)*rand(1,dimension))+1;

% For each dimention
for j=1:dimension
    % Child 1
    child1((j-1)*stringlength+1:j*stringlength)=[parent1((j-1)*stringlength+1:(j-1)*stringlength+cpoint(j))...
        parent2((j-1)*stringlength+cpoint(j)+1:j*stringlength)];
    % Child 2
    child2((j-1)*stringlength+1:j*stringlength)=[parent2((j-1)*stringlength+1:(j-1)*stringlength+cpoint(j))...
        parent1((j-1)*stringlength+cpoint(j)+1:j*stringlength)];
end