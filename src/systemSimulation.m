function system_response = systemSimulation(system, t, commands, opts_param)
% systemSimulation - Simulate the system with custom input for all inputs. Returns the outputs that are specified in output_names parameter
%
% Syntax: systemSimulation(system, t, commands, opts_param)
%
% Inputs:
%    - system       - MIMO transfer function
%    - t            - time vector
%    - commands     - structure that contains the input vector for all the inputs of the system (if not specified, input is null):
%        - 'input_name' - input vector (must be the same size as time vector)
%    - opts_param   - Optionals parameters: structure with the following fields:
%        - output_names (default: all) - Cell array containing the names of the outputs that we want to get
%
% Outputs:
%    - system_response - Structure that contains all the outputs
%
% Example:
%    s1 = createElement(1, 150, 1e7, 100);
%    s2 = createElement(2, 20,  2e6, 100);
%    system = connectElements({s1, s2});
%
%    t  = 0:1e-5:2;
%    commands = struct();
%    commands.x0 = 1e-6*(t > 0.2);
%    options = struct();
%    options.output_names = {'d1', 'd2'};
%
%    system_output = systemSimulation(system, t, commands, options);
%
%    figure; hold on;
%    plot(system_output.time, system_output.d1)
%    plot(system_output.time, system_output.d2)
%    legend({'d1', 'd2'})
%    hold off;


%% Default value for opts
opts = struct('output_names', {system.OutputName'}); % Take all the output

if exist('opts_param','var')
    for opt = fieldnames(opts_param)'
        opts.(opt{1}) = opts_param.(opt{1});
    end
end

%% Initialize and populate the command Vector
system_command = zeros(length(fieldnames(commands)), length(t));
inputs_index = zeros(size(fieldnames(commands)));
i = 1;
for input_name = fieldnames(commands)'
    assert(all(size(t) == size(commands.(input_name{1}))), ...
           'Size of time vector and %s command vector should be the same', input_name{1});
    assert(sum(ismember(system.InputName, input_name{1})) == 1, ...
           '%s is not an input of the system', input_name{1});
    system_command(i, :) = commands.(input_name{1});
    inputs_index(i) = find(ismember(system.InputName, input_name{1}));
    i = i + 1;
end

%% Initialize system_response
system_response = struct();

%% Create the vectors of inputs index and outputs index
outputs_index = zeros(size(opts.output_names));
for output_name = opts.output_names
    assert(sum(ismember(system.OutputName, output_name{1})) == 1, ...
           '%s is not an output of the system', output_name{1});
    outputs_index(find(ismember(opts.output_names, output_name{1}))) = find(ismember(system.OutputName, output_name{1}));
end

%% Create a subsystem with just the inputs and outputs that we want. This should reduce the computation time.
sub_system = system(outputs_index, inputs_index);

%% Compute the system response
system_res = lsim(sub_system, system_command, t);

%% Format the output
system_response = struct();
system_response.time = t;
for output_name = sub_system.OutputName'
    system_response.(output_name{1}) = system_res(:, find(ismember(sub_system.OutputName, output_name{1})));
end

end

