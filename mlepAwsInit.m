% This script sets up the environment for MLE+AWS.
% It should be modified to include the path to your AWS credentials and the
% path to your private key. Eventually, the code will generate private
% keys to dispatch instances. 
% Run this script once before using any MLE+AWS functions.
%
% (C) 2013 by Willy Bernal (willyg@seas.upenn.edu)

% History: 
% Created: 2013-09-11 by Willy Bernal

% Credentials Path (Full Path to your Credentials)
%credPath = '/YOUR/CREDENTIALS/PATH';
credPath = '/home/tao/Documents/aws-mlep_v1.0/Credentials/AwsCredentials.properties';
%credPath = '/home/tao/Documents/AWS-MLEP/TaoAwsCredentials.properties'

% Private Key Path (Full Path to your key)
%keyPath = '/YOUR/PRIVATE/KEY/PATH';
keyPath = '/home/tao/Documents/aws-mlep_v1.0/Credentials/mlabKey.pem';
%keyPath = '/home/tao/Documents/AWS-MLEP/initial.pem'

% Security Group Name
%secGroup = 'YOUR SECURITY GROUP NAME';
secGroup = 'mlab-mlep-sg';
%secGroup = 'temp0.50021';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% DO NOT MODIFY %%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% MLEP-AWS HOME 
fullname = mfilename('fullpath');
[direc, ~, ~ ]= fileparts(fullname);
cd(direc);

addpath([direc filesep 'source' filesep 'install']);

% JAVA CLASSPATH
addJavaPath([direc filesep 'source' filesep 'lib']);

% JAVA IMPORT
importJava();

global MLEPAWSSETTINGS

% MLEPAWSSAETTINGS
MLEPAWSSETTINGS = struct(...
    'homePath', direc,...   % Home Path
    'credPath', credPath,...   % Path to your AWS credentials
    'keyPath', keyPath,...   % Path to the key pair file
    'secGroup', secGroup...   % Path to the key pair file
    );

addpath(MLEPAWSSETTINGS.homePath);
addpath([MLEPAWSSETTINGS.homePath filesep 'source']);
addpath([MLEPAWSSETTINGS.homePath filesep 'source' filesep 'lib']);
addpath([MLEPAWSSETTINGS.homePath filesep 'source' filesep 'core']);
addpath([MLEPAWSSETTINGS.homePath filesep 'source' filesep 'optimization']);
addpath([MLEPAWSSETTINGS.homePath filesep 'source' filesep 'optimization' filesep 'ga']);
savepath;


