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

%% Set GA parameters
popsize = 4;
dimension = 1;
bitPerVar = 4;
chromoLen = dimension * bitPerVar;
limits = [1.5E-02;2.5E-02];
numGen = 10;
fields  = {'thickWD01'};

%% Generate Initial Generation
% Generate initial population
pop = genInitPop(popsize,bitPerVar,dimension);
popDec = decodePop(pop,bitPerVar,dimension,limits);
fileName = '5ZoneAirCooledTemp.idf';
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
    pause(5);
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
    save schedule allSchedule;
    save data allData;
    % Evaluate fitness
    fitness = calcFitness(data);
    clear data;
    clear csvData;
    % Select crossover candidates according to fitness
    sel = selection(fitness,popsize);   
    % Cross Over
    recombinedChromosomes = recombinationaAll(pop(sel,:), chromoLen,bitPerVar);
    % Mutation
 	pop = mutation(recombinedChromosomes, chromoLen);
    
    % Decode
    popDec = decodePop(pop,bitPerVar,dimension,limits);

    % Generate new schedule txt files
    mlepGenFiles(folderName, fileName, newFileName, popDec, fields);

end

% Plot Progress
toc

