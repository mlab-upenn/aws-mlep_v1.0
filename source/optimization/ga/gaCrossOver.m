function new_pop=gaCrossOver(pop,popsize,stringlength,dimension)
%CROSSOVER

% Randomly pair up parents
match = 2*[1:popsize/2];
new_pop = zeros(popsize,stringlength*dimension);

% order = 1:popsize;
% match = [popsize/2+1:popsize];%order(randperm(length(order)));
% new_pop = zeros(popsize,stringlength*dimension+1);

% For each individual
for i=1:popsize/2 
    % Generate children
    [child1,child2] = gaCrossRunning(pop(i,:),pop(match(i),:),stringlength,dimension);
    % Create new population
    new_pop(2*i-1:2*i,:)=[child1;child2];
end

