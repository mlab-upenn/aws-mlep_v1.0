function pop=genInitPop(popsize,stringlength,dimension)
%GENINITPOP Generates a random population according to the input parameters
%
% 

% Generate Initial Population
% Contains extra row for fitness
pop=round(rand(popsize,dimension*stringlength+1));