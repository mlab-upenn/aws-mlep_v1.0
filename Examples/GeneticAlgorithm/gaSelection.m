function selected = gaSelection(pop,popsize,stringlength,dimension,elitsize)

% Population size
popsize_new=size(pop,1);

% random 
r=rand(1,popsize);

% Normalize the fitness
fitness = pop(:,dimension*stringlength+1);
fitness = fitness/sum(fitness);
fitness = cumsum(fitness);

% Pick randomly according to fitness
selected = zeros(popsize, dimension*stringlength+1);
for i = 1:popsize-elitsize
    for j = 1:popsize_new
        if r(i) <= fitness(j)
            selected(i,:) = pop(j,:);
            break;
        end
    end
end

% Elitism
[~,ind] = sort(pop(:,dimension*stringlength+1));
selected(popsize-elitsize+1:end,:) = pop(ind(end-elitsize+1:end),:);



