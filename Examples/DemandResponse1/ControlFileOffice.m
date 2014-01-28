function [eplus_in_curr,userdata] = controlFile(cmd,eplus_out_prev, eplus_in_prev, time, stepNumber, userdata)
% ---------------FUNCTION INPUTS---------------

% INPUTS TO ENERGYPLUS
% eplus_in_prev - Data Structure with all previous inputs
% 	eplus_in_curr.Troom = ;

% OUTPUTS FROM ENERGYPLUS
% eplus_out_prev - Data Structure with all previous outpus
% 	eplus_out_curr.Tout = ;

% OTHER INPUTS
% cmd  - MLE+ Command to distinguish init or normal step
% userdata  - user defined variable which can be changed and evolved
% time - vector with timesteps
% stepNumber - Number of Time Step in the simulation (Starts at 1)

% ---------------FUNCTION OUTPUTS---------------
% eplus_in_curr - vector with the values of the input parameters.
% This should be a 1xn vector where n is number of eplus_in parameters
% userdata - user defined variable which can be changed and evolved

if strcmp(cmd,'init')
    % ---------------WRITE YOUR CODE---------------
    % Initialization mode. This part sets the
    % input parameters for the first time step.
    % Cool
    % 06:00,26.7
    % 18:00,24.0
    % 24:00,26.7
    % Heat
    % 06:00,15.6
    % 22:00,21.0
    % 24:00,15.6
    
    eplus_in_curr.CoolTemp = 26.7;
    eplus_in_curr.HeatTemp = 15.7;
    eplus_in_curr.SatTemp = 12.8;
    eplus_in_curr.ChWTemp = 6.7;
    
elseif strcmp(cmd,'normal')
    % ---------------WRITE YOUR CODE---------------
    % Normal mode. This part sets the input
    % parameters for the subsequent time steps.
    % Time
    etime = rem(time,24);
    
    % Cool
    if etime < 6
        eplus_in_curr.CoolTemp = 26.7;
    elseif etime < 18
        eplus_in_curr.CoolTemp = 24.0;
    else
        eplus_in_curr.CoolTemp = 26.7;
    end
    
    % Heat
    if etime < 6
        eplus_in_curr.HeatTemp = 15.6;
    elseif etime < 22
        eplus_in_curr.HeatTemp = 21.0;
    else
        eplus_in_curr.HeatTemp = 15.6;
    end
    
    eplus_in_curr.SatTemp = 12.8;
    eplus_in_curr.ChWTemp = 6.7;
end
end
