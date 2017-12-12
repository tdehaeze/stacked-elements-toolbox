function [custom_element] = createCustomElement(i, Txtox, Tftox, Txtof, Tftof)
% createCustomElement - Create a custom element using transfer functions.
%
% Syntax: createCustomElement(i, Txtox, Tftox, Txtof, Tftof)
%
% Inputs:
%    i     - Index of the element in the system
%    Txtox - Transfer function from displacement of the support to displacement of the element
%    Tftox - Transfer function from force applied to the element to its displacement
%    Txtof - Transfer function from displacement of the support to force applied on the support by the element
%    Tftof - Transfer function from force applied to the element to the force applied on the support by the element
%
% Outputs:
%    - custom_element - MIMO transfer function of the element
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

