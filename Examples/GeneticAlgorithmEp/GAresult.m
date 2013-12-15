
clear
load data.mat;
for i = 1:size(allData,2)
   data = allData{i};
   
   
   fitness(i) = mean(calcFitness(data));
   fitnessMax(i) = max(calcFitness(data));
    fitnessMin(i) = min(calcFitness(data));

end