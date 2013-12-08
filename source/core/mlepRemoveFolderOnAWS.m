function mlepRemoveFolderOnAWS(instanceInfo, keyName, rFolder, feed)
%REMOVEFOLDERONAWS Summary of this function goes here
%   Detailed explanation goes here
% remove from aws
% Check Matlab Pool
if matlabpool('size') == 0
    matlabpool(instanceInfo.instCount)
end

% Remove File from cloud
disp('Removing folders on AWS')
parfor i = 1:instanceInfo.instCount
    cmd = ['rm -r ' rFolder];
    mlepSendCommand(instanceInfo.pubDNSName(i,:), cmd, keyName, feed);
end

end

