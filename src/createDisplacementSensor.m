function [sensor_element] = createDisplacementSensor(above_i, bellow_i, sensor_tf, opts_param)
% createDisplacementSensor - Create a sensor element.
%
% Syntax: createDisplacementSensor(above_i, bellow_i, sensor_tf, opts_param)
%
% Inputs:
%    - above_i     - Index of the bottom element where the actuator is fixed
%    - bellow_i    - Index of the top element where the actuator is fixed
%    - sensor_tf   - Transfer function of the sensor. From the displacement (m) to the output signal
%    - opts_param  - Optionals parameters: structure with the following fields:
%        - sensor_output_name (default: ['D', num2str(above_i), num2str(bellow_i)]) - Name of the output of the sensor
%
% Outputs:
%    - sensor_element - MIMO transfer function of the element
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
opts = struct('sensor_output_name', ['D', num2str(above_i), num2str(bellow_i)]);

if exist('opts_param','var')
    for opt = fieldnames(opts_param)'
        opts.(opt{1}) = opts_param.(opt{1});
    end
end

%% Create the sensor element
sensor_element = [sensor_tf, -sensor_tf;...
                  tf(1),     tf(0);...
                  tf(0),     tf(1)];

sensor_element.InputName = {['d' num2str(bellow_i)], ['d' num2str(above_i)]};
sensor_element.OutputName = {opts.sensor_output_name, ['d' num2str(bellow_i)], ['d' num2str(above_i)]};

end

