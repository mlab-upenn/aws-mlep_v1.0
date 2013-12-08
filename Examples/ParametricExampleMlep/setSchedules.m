% Set up schedule matrix to run on the cloud
% Schedule Cooling Temperature Setpoint for all rooms
% Random schedule
numSch = 4;     % Number of schedules/files
numVar = 1;     % Number of Variables (Room Cooling Setpoint)
numSteps = 24;  % Values of the variable at every time step (1-hour)
schedule = 20 + rand(numSch,numVar,numSteps).*(25-20); % Generates matrix with multiple schedules

% Create Schedules
mlepCreateScheduleFile(schedule);






