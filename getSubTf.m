function [sub_tf] = getSubTf(mimo_tf, input_name, output_name)
% getSubTf - 
%
% Syntax: getSubTf(mimo_tf, input_name, output_name)
%
% Inputs:
%    mimo_tf     - 
%    input_name  - 
%    output_name - 
%
% Outputs:
%    - sub_tf - 
%
% Example:
%    granite = createElement(1, 1500, 5e9, 1);
%    sample = createElement(2, 50, 1e9, 1);
%    system = connectElements({granite, sample});
%    bode(getSubTf(system, 'x0', 'd2'), getSubTf(granite, 'x0', 'd1'));

sub_tf = mimo_tf(find(contains(mimo_tf.OutputName, output_name)), ...
                 find(contains(mimo_tf.InputName,  input_name)));

end
