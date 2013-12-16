function selected = gaSelection(pop,fitness,chromoLen,elitsize)

% Population size
popsize=size(pop,1);

% random 
r=rand(1,popsize);

% Normalize the fitness
fitness = fitness/sum(fitness);
fitnessSum = cumsum(fitness);

% Elit Size
elitsize  = ceil(popsize*elitsize);

% Pick randomly according to fitness
selected = zeros(popsize, chromoLen);
for i = 1:popsize-elitsize
    for j = 1:popsize % new
        if r(i) <= fitnessSum(j)
            selected(i,:) = pop(j,:);
            break;
        end
    end
end

% Elitism
[~,ind] = sort(fitness);
selected(popsize-elitsize+1:end,:) = pop(ind(end-elitsize+1:end),:);



