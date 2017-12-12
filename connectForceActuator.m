function [connected_system] = connectForceActuator(system, actuator)
% connectForceActuator - Connect a force actuator to a system
%
% Syntax: connectForceActuator(system, actuator)
%
% Inputs:
%    system   - A MIMO transfer function
%    actuator - An actuator created by createForceActuator function
%
% Outputs:
%    - connected_system - A MIMO transfer function corresponding to the system and the actuator connected
%
% Example:
%    

connected_system = lft(system, actuator, 'name');

end

