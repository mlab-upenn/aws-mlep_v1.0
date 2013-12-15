function fitness = calcFitness(data)
%   Function to get the fitness of each individual within an population in one generation
%   INPUT    delayRecPerGen     The delay of each individual in the population
%            expect             The expected result? or the expected total delay                  
%   OUTPUT   fitness            Each individual's fitness
%   Created by Tao Lei (leitao@seas.upenn.edu) Sep 2013

% Mean
numData = 2;
energyEle = sum(data(:,1:numData:end),1); 
energyGas = sum(data(:,2:numData:end),1); 
energyTot = energyEle + energyGas;

% Fitness
minV = min(energyTot);
maxV = max(energyTot);
fitness = energyTot - (maxV-minV)*0.98;

% Re-scale
fitness  = fitness/sum(fitness);



