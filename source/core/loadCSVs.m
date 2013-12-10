function [ csvData] = loadCSVs( filepath )
%LOADCSVS Summary of this function goes here
%   Detailed explanation goes here
allFiles = dir([filepath filesep '*.csv']);
files = {allFiles.name};

data = cell(1,size(files,2));
for i = 1:size(files,2)
    filename = strcat(filepath, '/', files(i));
    [vars, data{str2double(files{i}(1:end-4))} ts] = mlepLoadEPResults(filename{1});
end
csvData.vars = vars;
csvData.data = data;
csvData.ts = ts;
end

