% This script retrieves EC2 information from your AWS account. Copies the 
% basic files in the "files" folder to the instances, copies the input text 
% files and then runs the simulations, retrieves the results back to the 
% local computer. Finally, it loads the results and plots the data. 
%
% This script illustrates the usage of class mlepAwsProcess in the MLE+
% toolbox. 
%
% This script is free software.
%
% (C) 2013 by Willy Bernal(willyg@seas.upenn.edu)
%
% CHANGES:
%   2013-09-11  Created. 

clc;
tic 
%% Create an mlepAwsProcess instance and configure it
ep = mlepAwsProcess();
% Create EC2 Client
ep.createEC2Client();
% Init EC2 Client
ep.initEC2Client();
% Get Current instances Info
ep.getAwsInstanceInfo(); 
%Remove old file on AWS
rFolder = '/home/ubuntu/simulation/';
ep.removeFolderOnAws(rFolder, false);

%% Push Configuration files to EC2
% Push Configuration files to AWS 
lFolder = 'files'; 
ep.pushAllToAWS(lFolder, rFolder, false); 
% Needs time to copy
pause(10);

%% Set GA parameters
popsize = 10;
dimension = 10;
stringlength = 10;
x_bound = repmat([20 25], dimension, 1);
pm = 0.05;
numGen = 20;
elitsize = floor(0.5*popsize);
% Store progress
best = zeros(1, numGen);
ave = zeros(1, numGen);
worst = zeros(1, numGen);
popAll = zeros(numGen, popsize, stringlength*dimension+1);

%% Generate Initial Generation
% Generate initial population
pop = genInitPop(popsize,stringlength,dimension);
% Decode 
popDec = decodePop(pop,stringlength,dimension,x_bound);
% Create Schedules
mlepCreateScheduleFile(popDec);
% Push Schedule files to AWS 
lFolder = 'schedule'; 
ep.pushToAWS(lFolder, rFolder, false); 
% Needs time to copy
pause(10);

%% Run Initial Batch
% Run simulation on AWS
ep.runSimulationOnAWSmlep(lFolder, rFolder, false);
% Move simulation result to proper folders
ep.moveFileOnAWS(rFolder, true);
pause(5);
% Fetch simulation result on AWS
ep.fetchDataOnAWS(rFolder);
pause(10);
% Load Data
csvData = loadCSVs('OutputCSV');
save('csvData.mat', 'csvData');
% Evaluate fitness
pop = evalFitMlep(pop,popDec,stringlength,dimension);
% Pick the fittest individual
[choice_number,choice_k] = max(pop(:,stringlength*dimension+1));
choice = pop(choice_k,:);

%% GENERATIONS
for i=1:numGen
    % Cross Over
    new_pop = crossOver(pop,popsize,stringlength,dimension);
    % Mutation
    pop = gaMutate(new_pop,stringlength,dimension,pm);
    % Decoding
    popDec = decodePop(pop,stringlength,dimension,x_bound);

    %% CREATE NEW SCHEDULES
    % Create Schedules
    mlepCreateScheduleFile(popDec);
    % Push Schedule files to AWS
    lFolder = 'schedule';
    ep.pushToAWS(lFolder, rFolder, false);
    % Needs time to copy
    pause(10);

    %% RUN NEW SIMULATION
    % Run simulation on AWS
    ep.runSimulationOnAWSmlep(lFolder, rFolder, true);
    % Move simulation result to proper folders
    ep.moveFileOnAWS(rFolder, true);
    pause(5);
    % Fetch simulation result on AWS
    ep.fetchDataOnAWS(rFolder);
    pause(10);
    % Load Data
    csvData = loadCSVs('OutputCSV');
    save('csvData.mat', 'csvData');
    
    %% EVALUE FITNESS
    % Evaluate fitness
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
    popAll(i,:,:) = pop;
end

% Plot Progress
x = 1:numGen;
figure;plot(x, best, 'r', x, ave, 'b', x, worst, 'c');
legend('best', 'ave', 'worst');
 
toc

