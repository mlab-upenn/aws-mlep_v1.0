function [ strChromos, chromoLen ] = encodeChromosomes( data,rangeBit )
%GENCHROMOSOME Summary of this function goes here
%   This function encodes decimal data into binary strings
%   INPUT
%   data        decimal data to be converted into binary strings
%               M by N matrix, M knobs, N timesteps
%   rangeBit    number of bits used to represent a variable in data
%   OUTPUT
%   strChromos  chromosome represented by binary strings
%   chromoLen   length of each binary string
%   Created by Tao Lei(leitao@seas.upenn.edu) Oct 2013

strChromos = cell(1,size(data,2));
for i = 1:size(data,2)
    for j = 1:size(data,1)
        strChromos{i} = strcat(strChromos{i}, dec2bin(data(j,i),rangeBit));
    end
end
strChromos = strChromos';
chromoLen = size(data,1) * rangeBit;

end

