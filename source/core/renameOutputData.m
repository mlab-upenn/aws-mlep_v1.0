function [] = renameOutputData(filePath)
% Function to rename Output Data

allFiles = dir([filePath filesep '*.csv']);
files = {allFiles.name};

for i = 1:length(files)
    ind = regexp(files{i},{'0*', '.csv'});
    init = ind{1}(1);
    final = ind{2}-1;
    newName = str2num(files{i}(init:final));
    [status,message,messageid] = movefile([filePath filesep char(files(i))], [filePath filesep num2str(newName) '.csv'],'f');
end 





