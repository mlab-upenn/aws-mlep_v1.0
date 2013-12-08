clc;
tic
% Init Parameters
popsize = 20;
dimension = 10;
stringlength = 10;
x_bound = repmat([0 dimension], dimension, 1);
pm = 0.05;
numGen = 30;
elitsize = floor(0.5*popsize);

% Generate initial population
pop = genInitPop(popsize,stringlength,dimension);
% Decode 
popDec = decodePop(pop,stringlength,dimension,x_bound);
% Evaluate fitness
pop = evalFitMlep(pop,popDec,stringlength,dimension);

% Pick the fittest individual
[choice_number,choice_k] = max(pop(:,stringlength*dimension+1));
choice = pop(choice_k,:);

% Store progress
best = zeros(1, numGen);
ave = zeros(1, numGen);
worst = zeros(1, numGen);

for i=1:numGen
    % Cross Over
    new_pop = crossOver(pop,popsize,stringlength,dimension);
    % Mutation
    pop = gaMutate(new_pop,stringlength,dimension,pm);
    % Decoding
    popDec = decodePop(pop,stringlength,dimension,x_bound);
    % Evaluate
    pop = evalFitMlep(pop, popDec,stringlength,dimension);
    [number,k]=max(pop(:,stringlength*dimension+1));
    
    % Find Best Choice
    if choice_number<number
        choice_number=number;
        choice_k=k;
        choice=pop(choice_k,:);
    end
    
    % Discard worst one
    pop = gaSelection(pop,popsize,stringlength,dimension,elitsize); % ,elitsize
    [number,m] = min(pop(:,stringlength*dimension+1));
    pop(m,:) = choice;
     
    % Save progress
    best(i) = max(pop(:,stringlength*dimension+1));
    ave(i) = mean(pop(:,stringlength*dimension+1));
    worst(i) = min(pop(:,stringlength*dimension+1));
end

% Plot Progress
x = 1:numGen;
figure;plot(x, best, 'r', x, ave, 'b', x, worst, 'c');
legend('best', 'ave', 'worst');
hline(6, 'k');

% Final Results
[value,x] = result_guo(pop,stringlength,dimension,x_bound)
time = toc

