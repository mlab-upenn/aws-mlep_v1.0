function [ data ] = decodeChromos( strChromos,rangeBit )
%DECODECHROMOS Summary of this function goes here
%   This function decodes binary strings into decimal data;
%   INPUT
%   strChromos      binary string representing a chromosome
%   rangeBit        number of bits used to represent a variable
%   
%   OUTPUT
%   data            decoded decimal data
%   Created by Tao Lei(leitao@seas.upenn.edu) Oct 2013
data = zeros(size(strChromos,2) / rangeBit, size(strChromos,1));
for i = 1:size(strChromos,1)
    for j = 1:size(strChromos,2) / rangeBit
        data(j,i) = bin2dec(strChromos(i,(((j-1)*rangeBit+1):j*rangeBit)));
        
    end

end

end
