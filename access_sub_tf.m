function [subTf] = access_sub_tf(mimoTf,inputName, outputName)
%ACCESS_SUB_TF Summary of this function goes here
%   Detailed explanation goes here
subTf = mimoTf(find(contains(mimoTf.OutputName, outputName)), ...
               find(contains(mimoTf.InputName, inputName)));
end
