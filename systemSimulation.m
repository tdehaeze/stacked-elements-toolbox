function system_response = systemSimulation(system, t, commands, output_names, opts_param)
% systemSimulation - Simulate the system with custom input for all inputs. Returns the outputs that are specified in output_names parameter
%
% Syntax: systemSimulation(system, t, commands, output_names, opts_param)
%
% Inputs:
%    - system       - MIMO transfer function
%    - t            - time vector
%    - commands     - structure that contains the input vector for all the inputs of the system (if not specified, input is null):
%        - 'input_name' - input vector (must be the same size as time vector)
%    - output_names - Cell array containing the names of the outputs that we want to get TODO - default all (maybe put as opts_param)
%    - opts_param   - Optionals parameters: structure with the following fields:
%
% Outputs:
%    - system_response - Structure that contains all the outputs specified in output_names parameter
%
% Example:

%% Default value for opts
opts = struct();

if exist('opts_param','var')
    for opt = fieldnames(opts_param)'
        opts.(opt{1}) = opts_param.(opt{1});
    end
end

%% %% Initialize and populate the command Vector
%% system_command = zeros(length(system.InputName), length(t));
%% for input_name = fieldnames(commands)'
%%     assert(size(t) == size(commands.(input_name)), ...
%%            'Size of time vector and %s command vector should be the same', input_name);
%%     assert(sum(ismember(system.InputName, input_name)) == 1, ...
%%            '%s is not an input of the system', input_name);
%%     system_command(find(ismember(system.InputName, input_name)), :) = commands.(input_name);
%% end

%% Initialize and populate the command Vector
system_command = zeros(length(fieldnames(commands)), length(t));
inputs_index = zeros(length(fieldnames(commands)));
i = 1;
for input_name = fieldnames(commands)'
    assert(all(size(t) == size(commands.(input_name{1}))), ...
           'Size of time vector and %s command vector should be the same', input_name{1});
    assert(isfield(system.InputName, input_name{1}), ...
           '%s is not an input of the system', input_name{1});
    system_command(i, :) = commands.(input_name{1});
    inputs_index(i) = find(ismember(system.InputName, input_name{1}));
    i = i + 1;
end

%% Initialize system_response
system_response = struct();

%% Create the vectors of inputs index and outputs index
outputs_index = zeros(length(output_names));
for output_name = output_names
    assert(sum(ismember(system.OutputName, output_name{1})) == 1, ...
           '%s is not an output of the system', output_name{1});
    outputs_index(find(ismember(output_names, output_name{1}))) = find(ismember(system.OutputName, output_name{1}));
end

%% TODO - Create a subsystem with just the inputs and outputs that we want. This should reduce the computation time.
sub_system = system(outputs_index, inputs_index);

%% Compute the system response
system_response = lsim(sub_system, system_command, t);

end

