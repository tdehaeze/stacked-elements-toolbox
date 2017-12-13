function [force_actuator] = createForceActuator(above_i, bellow_i, actuator_tf, opts_param)
% createForceActuator - Create a force actuator between the system of index 'bellow_i' and the system of index 'above_i'.
%
% Syntax: createForceActuator(above_i, bellow_i, opts_param)
%
% Inputs:
%    - above_i     - Index of the bottom element where the actuator is fixed
%    - bellow_i    - Index of the top element where the actuator is fixed
%    - actuator_tf - Transfer function of the actuator. From the input signal to the output force (N)
%    - opts_param - Optionals parameters: structure with the following fields:
%        - act_input_name  (default: ['F', num2str(above_i), num2str(bellow_i)])      - Name of the input of the actuator
%        - act_output_name (default: ['F', num2str(above_i), num2str(bellow_i), 'N']) - Name of the output of the actuator
%
% Outputs:
%    - force_actuator - Transfer function of the actuator with the correct input and output names.
%
% Example:
%    granite = createElement(1, 1500, 5e9, 1);
%    sample = createElement(2, 50, 1e9, 1);
%    system = connectElements({granite, sample});
%    force_actuator = createForceActuator(1, 2, tf(1));
%    system = connectForceActuator(system, force_actuator);
%    bode(getSubTf(system, 'F12', 'd2'));

%% Default value for opts
opts = struct('act_input_name',  ['F', num2str(above_i), num2str(bellow_i)], ...
              'act_output_name', ['F', num2str(above_i), num2str(bellow_i), 'N']);

if exist('opts_param','var')
    for opt = fieldnames(opts_param)'
        opts.(opt{1}) = opts_param.(opt{1});
    end
end

%% Create the force actuator
force_actuator = [actuator_tf;...
                  -actuator_tf;...
                  actuator_tf];

force_actuator.InputName = {opts.act_input_name};
force_actuator.OutputName = {['g', num2str(bellow_i) ],...
                             ['g', num2str(above_i)],...
                             opts.act_output_name};

end

