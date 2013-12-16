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
clear allSchedule allFitness allData;

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

%% Set GA parameters
popsize = 12;
dimension = 4;
elitsize = 0.1;
bitPerVar = 5;
chromoLen = dimension * bitPerVar;
% limits = [0.1E-02;20E-02]; % 1.99E-09
limits = [6E-02 5E-02 0.3 0.5;12E-02 11E-02 0.7 0.85]; % 1.99E-09
numGen = 20;
% fields  = {'thickWD01'};
fields  = {'thickIN02','thickIN46','solTxGREY3MM','solTxCLEAR3MM'};
pm = 0.05;

%% Generate Initial Generation
% Generate initial population
pop = genInitPop(popsize,bitPerVar,dimension);
popDec = decodePop(pop,bitPerVar,dimension,limits);
% fileName = '5ZoneAirCooledTemp.idf';
fileName = '5ZoneAirCooledTemp1.idf';
newFileName = 'test1.idf';
% Generate Files
folderName = 'schedule';
mlepGenFiles(folderName, fileName, newFileName, popDec, fields);
% pop = genInitScheduleTXT(popsize,numVar,dimension,bitPerVar,offset);
  
%% GENERATIONS
for i=1:numGen
    i
    % Push Schedule files to AWS 
    lFolder = 'schedule'; 
    ep.pushToAWS(lFolder, rFolder, false); 
    % Needs time to copy
    pause(4);
    % Run simulation on AWS
    ep.runSimulationOnAWSep(lFolder, rFolder);
    % Move simulation result to proper folders
    ep.moveFileOnAWS(rFolder, true);
    pause(4);
    % Fetch simulation result on AWS
    ep.fetchDataOnAWS(rFolder);
    while(~(size(dir('OutputCSV'),1) == (popsize + 2)))
    %    disp('waiting for results');
    end
    
    % Rename Output Data
    renameOutputData('OutputCSV');
    
    % Load Data
    csvData = loadCSVs1('OutputCSV');
    data = cell2mat(csvData.data);
    % Save progress
    allSchedule{i} = pop;
    allData{i} = data;
    % Evaluate fitness
    [fitness, ~] = calcFitness(data);
    allFitness{i} = fitness;
%     clear data;
%     clear csvData;
    % Select crossover candidates according to fitness
    newPop = gaSelection(pop,fitness,chromoLen,elitsize); 
    size(pop)
    size(newPop)
    % Cross Over
%     recombinedChromosomes = recombinationaAll(newPop, chromoLen,bitPerVar);
    newPop = gaCrossOver(newPop,popsize,bitPerVar,dimension);
    size(newPop)
    % Mutation 
%  	pop = mutation(newPop, chromoLen);
    pop = gaMutate(newPop,bitPerVar,dimension,pm);
    size(pop)
    % Decode
    popDec = decodePop(pop,bitPerVar,dimension,limits);
    size(popDec)
    % Generate new schedule txt files
    mlepGenFiles(folderName, fileName, newFileName, popDec, fields);
end

% Save Results
save('allSchedule','allSchedule');
save('allData','allData');
save('allFitness','allFitness');

% Plot Progress
toc

