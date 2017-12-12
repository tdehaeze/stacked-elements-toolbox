function [custom_element] = createCustomElement(i, Txtox, Tftox, Txtof, Tftof)
% createCustomElement - 
%
% Syntax: createCustomElement(i, Txtox, Tftox, Txtof, Tftof)
%
% Inputs:
%    i - 
%    Txtox - 
%    Tftox - 
%    Txtof - 
%    Tftof - 
%
% Outputs:
%    - custom_element - 
%
% Example:
%    

%%
if ~exist('Txtof','var')
    Txtof = tf(0);
    warning('Txtof is not specified.');
end
if ~exist('Tftof','var')
    Tftof = tf(0);
    warning('Tftof is not specified.');
end

%%
custom_element = [Txtox Tftox Tftox;...
                  Txtox Tftox Tftox;...
                  Txtof Tftof Tftof];

custom_element.InputName = {['x' num2str(i-1)], ['f' num2str(i+1)], ['g' num2str(i)]};
custom_element.OutputName = {['x' num2str(i)], ['d' num2str(i)], ['f' num2str(i)]};

end

