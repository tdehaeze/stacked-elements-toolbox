function [connected_system] = connectForceActuator(system, actuator)
% connectForceActuator - 
%
% Syntax: connectForceActuator(system, actuator)
%
% Inputs:
%    system   - 
%    actuator - 
%
% Outputs:
%    - connected_system - 
%
% Example:
%    

connected_system = lft(system, actuator, 'name');

end

