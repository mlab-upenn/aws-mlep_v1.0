function [ data ] = genParameters( numVar, numStep, rangeBit )
%GENPARAMETERS Summary of this function goes here
%   This function generates a matrix of random integer within specified
%   range
%   INPUT
%   numVar      number of knobs to be optimized
%   numStep     number of time steps
%   rangeBit    decides the upper bound of the randomly generated value
%   OUTPUT
%   data        randomly generated schedule(single schedule)
%   Created by Tao Lei(leitao@seas.upenn.edu)   Oct 2013
maxValue = 2^rangeBit - 1;

data = randi([0 maxValue],numVar,numStep);
    

end

