function [force_actuator] = createForceActuator(above_i, bellow_i)
% createForceActuator - 
%
% Syntax: createForceActuator(above_i, bellow_i)
%
% Inputs:
%    above_i  - 
%    bellow_i - 
%
% Outputs:
%    - force_actuator - 
%
% Example:
%    


force_actuator = [tf(-1); tf(1)];
force_actuator.InputName = {['F', num2str(above_i), num2str(bellow_i)]};
force_actuator.OutputName = {['g', num2str(above_i) ],...
                             ['g', num2str(bellow_i)]};

end

