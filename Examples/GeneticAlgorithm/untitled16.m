gen = 100;
pop = 24;
numVar = 1;
numStep = 10;
rangeBit = 5;
offset = 22;
chromoLen = rangeBit * numVar;
oneGen = genInitScheduleTXT(pop,numVar,numStep,rangeBit,offset);
amazonEC2Client = com.amazonaws.services.ec2.AmazonEC2Client();
amazonEC2Client = initClient(amazonEC2Client, handles.data.awsFullCredPath);
[ amazonEC2Client, EC2_info] = getAWSInstanceInfo ( amazonEC2Client );
% Create security group if necessary
if (EC2_info.instCount < handles.data.numInst)
    SGName = strcat('temp',num2str(rand));
    SGDescription = 'temp';
    [ amazonEC2Client, SGName ] = createSecurityGroup( SGName, SGDescription,amazonEC2Client );
end
% Create instances if necessary
for i = (EC2_info.instCount+1):handles.data.numInst
    initAWSInstance(amazonEC2Client, handles.data.awsFullKeyPath, SGName,handles.data.instType);
end

[amazonEC2Client, EC2_info] = getAWSInstanceInfo ( amazonEC2Client );

for i = 1:gen
    i
    removeFolderOnAWS(amazonEC2Client, EC2_info,handles.data.awsFullKeyPath);
    pushToAWS(handles.data.idfPath, amazonEC2Client, EC2_info, handles.data.awsFullKeyPath);
    pause(3);
    runSimulationOnAWS(amazonEC2Client, EC2_info, handles.data.awsFullKeyPath,handles.data.idfPath );
    moveFileOnAWS(amazonEC2Client, EC2_info, handles.data.awsFullKeyPath);
    fetchDataOnAWS(amazonEC2Client, EC2_info, handles.data.awsFullKeyPath);

    while(~(size(dir('OutputCSV'),1) == (pop + 2)))
    end
    csvData = loadCSVs('OutputCSV');
    data = cell2mat(csvData.data);
    allSchedule{i} = oneGen;
    allData{i} = data;
    fitness = getFitness(data(33:72,7:8:end), data(33:68,8:8:end));
    sel = selection(fitness,pop);
    recombinedChromosome = recombinationaAll(oneGen(sel,:), chromoLen,rangeBit);
    oneGen = mutation(recombinedChromosome, chromoLen);
    genTXTSchedule(oneGen, chromoLen, rangeBit, offset);
    mean(fitness);
    save schedule allSchedule;
    save data allData;

end
