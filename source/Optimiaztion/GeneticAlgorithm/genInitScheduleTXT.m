function [ oneGen ] = genInitScheduleTXT( population, numVar, numStep, rangeBit,offset )
%GENINITSCHEDULETXT Summary of this function goes here
%   This function generates a random schedules for the first generation and
%   writes them into text files
%   INPUT
%   population      number of individuals in each generation    
%   numVar          number of knobs in each schedule
%   numStep         number of time steps in each schedule 
%   rangeBit        number of bits used to represent a variable
%   offset          offset given to each numVar, used to control the range
%                   of the value of each knob
%   OUTPUT
%   oneGen          contains the (encoded) schedule info in one generation
%
%   Created by Tao Lei(leitao@seas.upenn.edu) Oct 2013

if exist('schedule', 'dir')
    rmdir('schedule', 's');
end
mkdir('schedule');
for i = 1:population
    data = genParameters(numVar,numStep,rangeBit);
    strChromos = encodeChromosomes(data,rangeBit);
    oneGen(i,:) = bin2dec(strChromos); 
    filename = strcat(num2str(i),'.txt');
    dlmwrite(strcat('schedule/',filename),[numVar, 24]);
    for j = 1:numVar
        dlmwrite(strcat('schedule/',filename), [offset * ones(1,7) roundn(data(j,:)./4,-1) + offset(j) offset * ones(1,7) ],'-append');
    end
end

end

