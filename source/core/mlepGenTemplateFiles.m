function [commands] = mlepGenFiles(fileName, newFileName, commands)

%% SET MULTIPLE SCENARIOS
param = struct();

mlepGenTemplate(fileName, newFileName, commands);

% generateTemplate
controls = mlepGenTemplate(fileName, param, newFileName);
save('controls.mat', 'controls');
 
% Generate Multiple E+ Files
[status, msg] = system(['parametricpreprocessor ' newFile '&'],'-echo');

% Go ahead and copy all files into 'files' folder
fileName = 'files';
[status,message,messageid] = rmdir(['.' filesep fileName],'s');
[status,message,messageid] = mkdir(['.' filesep fileName]);

