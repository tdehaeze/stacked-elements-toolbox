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
%    

sub_tf = mimo_tf(find(contains(mimo_tf.OutputName, output_name)), ...
                 find(contains(mimo_tf.InputName,  input_name)));

end
