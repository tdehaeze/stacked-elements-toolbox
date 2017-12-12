function [sub_tf] = getSubTf(mimo_tf, input_name, output_name)
% getSubTf - Get a SISO transfer function from the MIMO transfer function mimo_tf.
%            The SISO transfer function corresponds is the one between 'input_name' and 'output_name'
%
% Syntax: getSubTf(mimo_tf, input_name, output_name)
%
% Inputs:
%    - mimo_tf     - A MIMO transfer function with named inputs and outputs
%    - input_name  - The name of the input
%    - output_name - The name of the output
%
% Outputs:
%    - sub_tf - Á transfer function corresponding to the transfer function between the input_name of the mimo_tf to the output_name
%
% Example:
%    granite = createElement(1, 1500, 5e9, 1);
%    sample = createElement(2, 50, 1e9, 1);
%    system = connectElements({granite, sample});
%    bode(getSubTf(system, 'x0', 'd2'), getSubTf(granite, 'x0', 'd1'));

sub_tf = mimo_tf(find(contains(mimo_tf.OutputName, output_name)), ...
                 find(contains(mimo_tf.InputName,  input_name)));

end
