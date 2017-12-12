function [element] = createElement(i, m, k, c)
% createElement - Create a Spring-Mass-Damper Element
%
% Syntax: createElement(i, m, k, c)
%
% Inputs:
%     - i - Index of the element in the system
%     - m - mass (Kg)
%     - k - Stiffness (N/m)
%     - c - Damping (N/(m.s-1))
%
% Outputs:
%    - element - MIMO transfer function of the created element
%
% Example:
%    granite = createElement(1, 1500, 5e9, 1);
%    sample = createElement(2, 50, 1e9, 1);
%    system = connectElements({granite, sample});
%    bode(getSubTf(system, 'x0', 'd2'), getSubTf(granite, 'x0', 'd1'));

%%
s = tf('s');

Txtof = (-m*s^2 * (c*s + k))/(m*s^2 + c*s + k);
Tftof =            (c*s + k)/(m*s^2 + c*s + k);
Txtox =            (c*s + k)/(m*s^2 + c*s + k);
Tftox =                    1/(m*s^2 + c*s + k);

%%
element = [Txtox Tftox Tftox;...
           Txtox Tftox Tftox;...
           Txtof Tftof Tftof];

element.InputName = {['x' num2str(i-1)], ['f' num2str(i+1)], ['g' num2str(i)]};
element.OutputName = {['x' num2str(i)], ['d' num2str(i)], ['f' num2str(i)]};

end

