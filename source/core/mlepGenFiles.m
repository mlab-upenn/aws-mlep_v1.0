function mlepGenFiles(folderName, fileName, newFileName, commands, fields)
%MLEPGENFILES Generates a template idf file that contain parametric
% objects. Using the 'parametricpreprocessor' executable from E+ it will 
% generate multiple idfs.  

% Put in cell format
param = struct();
for i = 1:length(fields)
    param.(char(fields(i))) = commands(:,i);
end
 
% generateTemplate
mlepGenTemplate(fileName, param, newFileName, fields);
save('commands.mat', 'commands');
 
% Generate Multiple E+ Files
[status, msg] = system(['parametricpreprocessor ' newFileName '&'],'-echo');

% Go ahead and copy all files into 'files' folder
[status,message,messageid] = rmdir(['.' filesep folderName],'s');
[status,message,messageid] = mkdir(['.' filesep folderName]);

[~, b, ~] = fileparts(newFileName);
% Copy All generated files
pause(5);
[status,message,messageid] = movefile(['.' filesep b '-*'], ['.' filesep folderName],'f');


