function mlepInitInstances(numInst, typeInst)
%INITINSTANCES A function for dispatching EC2 instance. 
%   Inputs:
%       numInst - Number of Instances to dispatch
%       typeInst - Type of instance (e.g. 't.micro')
%
% This script is free software.
%
% (C) 2013 by Willy Bernal(willyg@seas.upenn.edu)

% CHANGES:
%   2013-09-11  Created. 

%% Create an mlepAwsProcess instance and configure it
ep = mlepAwsProcess();
% Create EC2 Client
ep.createEC2Client();
% Init EC2 Client
ep.initEC2Client();
% Create Instance if there is no instance on AWS
ep.initAwsInstance(numInst, typeInst);
% Destroy
clear ep;


