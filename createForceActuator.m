function [force_actuator] = createForceActuator(above_i, bellow_i)
% createForceActuator - Create a force actuator between the system of index 'bellow_i' and the system of index 'above_i'.
%
% Syntax: createForceActuator(above_i, bellow_i)
%
% Inputs:
%    above_i  - Index of the bottom element where the actuator is fixed
%    bellow_i - Index of the top element where the actuator is fixed
%
% Outputs:
%    - force_actuator - Transfer function of the actuator with the correct input and output names.
%
% Example:
%    granite = createElement(1, 1500, 5e9, 1);
%    sample = createElement(2, 50, 1e9, 1);
%    system = connectElements({granite, sample});
%    force_actuator = createForceActuator(1, 2);
%    system = connectForceActuator(system, force_actuator);
%    bode(getSubTf(system, 'F', 'd2'));


force_actuator = [tf(-1); tf(1)];
force_actuator.InputName = {['F', num2str(above_i), num2str(bellow_i)]};
force_actuator.OutputName = {['g', num2str(above_i) ],...
                             ['g', num2str(bellow_i)]};

end

