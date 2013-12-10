function mlepRunSimulation2(instanceInfo, keyName, lFolder, rFolder, feed)
%MLEPRUNSIMULATIONON1 Runs Simulation of E+ 
%   This functions launches all the E+ simulations in the specified folder
%   (rFolder)
%   Inputs: 
%       instanceInfo - cell with all the instances information
%       keyName - Path to the key file 
%       rFolder - Folder in the EC2 instances where the E+ files reside.
% 
% This script is free software.
%
% (C) 2013 by Willy Bernal(willyg@seas.upenn.edu)

% start matlabpool for parallel execution
if matlabpool('size') == 0
    matlabpool(instanceInfo.instCount);
end

% Remote Folder
[a, b, ~] = fileparts(rFolder);
rFolder = [a filesep b];

% for each EC2 instance
parfor i = 1:instanceInfo.instCount
    allFiles= dir([lFolder num2str(i) filesep '*.txt']);
    files = {allFiles.name};
    fileNo = size(files,2);
    for j = 1:fileNo
        
        filename = char(files(j));
        [a name c] =fileparts(filename);
        idfName = [name '.idf'];
        mov_cmd = ['mv ' rFolder '*.idf ' rFolder idfName];
        mlepSendCommand(instanceInfo.pubDNSName(i,:), mov_cmd, keyName, feed);        
        
        ssh_cmd = ['ssh -o StrictHostKeyChecking=no -i ' keyName ' ubuntu@' instanceInfo.pubDNSName(i,:)];
        env_cmd = [' ''cd ' rFolder ';export BCVTB_HOME=/home/ubuntu/mlep/bcvtb;'];
        jar_cmd = ['java -jar mlepProcess.jar ' idfName ' ' char(files(j)) ' '' '];
        cmd = [ssh_cmd env_cmd jar_cmd];
        msg = ['Running simulation ',num2str(j), ' on machine #',num2str(i)];
        disp(msg);
        [status, msg] = system(cmd); % ,'-echo'
    end 
end