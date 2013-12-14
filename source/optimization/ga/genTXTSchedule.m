function genTXTSchedule(newSchedule_chromosomes, chromoLen, rangeBit, offset)
%GENITXTSCHEDULE Summary of this function goes here
%   This function generates a random schedules for the first generation and
%   writes them into text files
%   INPUT
%   newSchedule_chromosomes      schedules to be written into text files    
%   chromoLen                    length of each chromosome
%   rangeBit        number of bits used to represent a variable
%   offset          offset given to each numVar, used to control the range
%                   of the value of each knob

%   Created by Tao Lei(leitao@seas.upenn.edu) Oct 2013
if exist('schedule', 'dir')
    rmdir('schedule', 's');
end
mkdir('schedule');

for i = 1:size(newSchedule_chromosomes,1)
    
    data = decodeChromos(dec2bin(newSchedule_chromosomes(i,:),chromoLen), rangeBit);
    numVar = size(data,1);
    numStep = size(data,2);
    filename = strcat(num2str(i),'.txt');
    dlmwrite(strcat('schedule/',filename),[numVar, 24]);
    for j = 1:numVar
        dlmwrite(strcat('schedule/',filename), [offset * ones(1,7) roundn(data(j,:)./4,-1) + offset(j) offset * ones(1,7) ],'-append');
    end
end




end