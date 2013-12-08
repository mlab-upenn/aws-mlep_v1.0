function new_pop=crossOver(pop,popsize,stringlength,dimension)
%CROSSOVER

% Randomly pair up parents
match = round(rand(1,popsize)*(popsize-1))+1;
new_pop = zeros(2*popsize,stringlength*dimension+1);

% order = 1:popsize;
% match = [popsize/2+1:popsize];%order(randperm(length(order)));
% new_pop = zeros(popsize,stringlength*dimension+1);

% For each individual
for i=1:popsize 
    % Generate children
    [child1,child2] = crossRunning(pop(i,:),pop(match(i),:),stringlength,dimension);
    % Create new population
    new_pop(2*i-1:2*i,1:end-1)=[child1;child2];
end

