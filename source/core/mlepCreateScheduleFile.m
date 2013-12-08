function mlepCreateScheduleFile(schedule)
%MLEPCREATESCHEDULEFILE - Creates input text files for MLE+ to run in the 
% cloud
%
% Syntax:  mlepCreateScheduleFile(schedule)
%
% Inputs:
%    schedule - 3D matrix that contains the schedules for the input files. 
%               1st dimension - number of files to write
%               2nd dimension - variables in each file, e.g. CoolSP, HeatSP
%               3rd dimension - values for each variable.   
%
% Outputs:
%       
% Example: 
%    Line 1 of example
%    Line 2 of example
%    Line 3 of example
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: OTHER_FUNCTION_NAME1,  OTHER_FUNCTION_NAME2

% Author: Willy Bernal, Ph.D., 
% University of Pennsylvania
% email address: willyg@seas.upenn.edu
% Website: 
% December 2013; Last revision: 2-Dec-2013

%------------- BEGIN CODE --------------

% Create Schedule Folder 
if exist('schedule', 'dir')
    rmdir('schedule', 's');
end
mkdir('schedule');

% Patch Schedule
[a, b]  = size(schedule);
newSchedule = 22*ones(a,24);

newSchedule(:,9:18) = schedule;
% Size schedule
[numSch, numStep]  = size(newSchedule);

% For each schedule file
for i = 1:numSch
    % Get # of variables 
    filename = strcat(num2str(i),'.txt');
    dlmwrite(strcat('schedule/',filename),[1, numStep]);
    
    % Add scheduled values
%     for j = 1:numStep
    dlmwrite(strcat('schedule/',filename), newSchedule(i,:),'-append');
%     end
end

end

%------------- BEGIN CODE --------------