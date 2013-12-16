function [fitness fitnessRaw] = calcFitness(data)
%   Function to get the fitness of each individual within an population in one generation
%   INPUT    delayRecPerGen     The delay of each individual in the population
%            expect             The expected result? or the expected total delay                  
%   OUTPUT   fitness            Each individual's fitness
%   Created by Tao Lei (leitao@seas.upenn.edu) Sep 2013

% Mean
numData = 2;
energyEle = mean(data(:,1:numData:end),1); 
energyGas = mean(data(:,2:numData:end),1); 
energyTot = energyEle + energyGas;

% Fitness
minV = min(energyTot);
maxV = max(energyTot);
fitnessRaw = energyTot;
% fitness = energyTot - minV + (maxV-minV)*0.1;
fitness = (maxV - energyTot) + (maxV-minV)*0.1;

popsize = length(fitness);
if sum(fitness == 0) == popsize
    fitness = 1/popsize*ones(1,popsize);
end

% Rank
[order, ind] = sort(energyTot);
fitnessRank = ind;
fitnessRank = 1./fitnessRank;
fitnessRank = fitness/sum(fitnessRank);




