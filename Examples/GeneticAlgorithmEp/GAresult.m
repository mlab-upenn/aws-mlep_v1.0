
clear
load allData.mat;
for i = 1:size(allData,2)
    data = allData{i};
    [~, energy] = calcFitness(data);
    fitness(i) = mean(energy);
    fitnessMax(i) = max(energy);
    fitnessMin(i) = min(energy);
    
end

figure(1);plot([fitness; fitnessMax; fitnessMin]');
legend('Mean', 'Max', 'Min');