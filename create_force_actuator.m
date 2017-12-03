function [forceActuator] = create_force_actuator(above_i, bellow_i)
%CREATE_FORCE_ACTUATOR Summary of this function goes here
%   Detailed explanation goes here

forceActuator = [tf(-1); tf(1)];
forceActuator.InputName = {['F', num2str(above_i), num2str(bellow_i)]};
forceActuator.OutputName = {['g', num2str(above_i)],...
                            ['g', num2str(bellow_i)]};
end

