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
%    granite = createElement(1, 1500, 5e9, 1);
%    sample = createElement(2, 50, 1e9, 1);
%    system = connectElements({granite, sample});
%    force_actuator = createForceActuator(1, 2);
%    system = connectForceActuator(system, force_actuator);
%    bode(getSubTf(system, 'F', 'd2'));

connected_system = lft(system, actuator, 'name');

end

