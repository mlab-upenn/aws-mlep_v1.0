function mlepGenTemplate(fileName, param, newFile, fields)
% Generate multiple scenarios 

% Read File
dataIDF = readIDFAWS(fileName, {'Parametric:SetValueForRun'});

% Generate Control Knobs
% [dataReplace, controls] = generateLines(param);
[dataReplace] = generateLines1(param);

% Read Original file
fid = fopen(fileName,'r');
i = 1;
tline = fgets(fid);
A = {};
A{i} = tline;
while ischar(tline)
    i = i+1;
    tline = fgets(fid);
    A{i} = tline;
end

% Change cell A
fileOriginal = A;

% Get Initial and Finish Lines
start = cell2mat(dataIDF.start);
finish = cell2mat(dataIDF.finish);

% Open/Write File
fid = fopen(newFile, 'w');
fileStart = fileOriginal(1:start(1)-1);
fprintf(fid,'%s', cell2mat(fileStart));
for i = 1:size(fieldnames(param),1)
    fprintf(fid,'%s', cell2mat({dataReplace(i).lines}));
end
lastPart = fileOriginal(finish(size(fieldnames(param),1))+1:end-1);

fprintf(fid,'%s', cell2mat(lastPart));
fclose(fid);
end