function [connected_system] = connectDisplacementSensor(system, sensor, opts_param)
% connectDisplacementSensor - Connect a displacement sensor to a system
%
% Syntax: connectDisplacementSensor(system, sensor, opts_param)
%
% Inputs:
%    - system     - A MIMO transfer function
%    - sensor     - An sensor created by createDisplacementSensor function
%    - opts_param - Optionals parameters: structure with the following fields:
%        - use_minreal (default: true) - Use minreal to delete pole-zero pairs in transfer functions
%
% Outputs:
%    - connected_system - A MIMO transfer function corresponding to the system and the sensor connected
%
% Example:
%    granite = createelement(1, 1500, 5e9, 1);
%    sample = createelement(2, 50, 1e9, 1);
%    system = connectelements({granite, sample});
%    displacement_sensor = createdisplacementsensor(1, 2, tf(1));
%    system = connectdisplacementsensor(system, displacement_sensor);
%    figure; hold on;
%    bode(getsubtf(system, 'x0', 'd12'));
%    bode(getsubtf(system, 'x0', 'd1'));
%    bode(getsubtf(system, 'x0', 'd2'));
%    legend({'x0 to d12', 'x0 to d1', 'x0 to d2'});
%    hold off;

%% Default value for opts
opts = struct('use_minreal', true);

if exist('opts_param','var')
    for opt = fieldnames(opts_param)'
        opts.(opt{1}) = opts_param.(opt{1});
    end
end

%% Connect the system with the sensor
connected_system = lft(system, sensor, 'name');

if opts.use_minreal
    connected_system = minreal(connected_system);
end

end

