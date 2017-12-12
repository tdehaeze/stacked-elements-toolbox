function [connected_system] = connectForceActuator(system, actuator, opts_params)
% connectForceActuator - Connect a force actuator to a system
%
% Syntax: connectForceActuator(system, actuator)
%
% Inputs:
%    - system   - A MIMO transfer function
%    - actuator - An actuator created by createForceActuator function
%    - opts_param   - Optionals parameters: structure with the following fields:
%        - use_minreal (default: true) - Use minreal to delete pole-zero pairs in transfer functions
%
% Outputs:
%    - connected_system - A MIMO transfer function corresponding to the system and the actuator connected
%
% Example:
%    granite = createElement(1, 1500, 5e9, 1);
%    sample = createElement(2, 50, 1e9, 1);
%    system = connectElements({granite, sample});
%    force_actuator = createForceActuator(1, 2, tf(1));
%    system = connectForceActuator(system, force_actuator);
%    bode(getSubTf(system, 'F', 'd2'));

%% Default value for opts
opts = struct('use_minreal', true);

if exist('opts_param','var')
    for opt = fieldnames(opts_param)'
        opts.(opt{1}) = opts_param.(opt{1});
    end
end

%% Connect the system with the actuator
connected_system = lft(system, actuator, 'name');

if opts.use_minreal
    connected_system = minreal(connected_system);
end

end

