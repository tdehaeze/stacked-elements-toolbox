function [Si] = create_element(i, m, k, c)
%CREATE_ELEMENT Summary of this function goes here
%   i = integer
%   m = mass (Kg)
%   k = Stiffness (N/m)
%   c = Damping (N/(m.s-1))

%%
s = tf('s');

Txtof = (-m*s^2*(c*s+k))/(m*s^2 + c*s + k);
Tftof = (c*s+k)/(m*s^2 + c*s + k);
Txtox = (c*s+k)/(m*s^2 + c*s + k);
Tftox = 1/(m*s^2 + c*s + k);

%%
Si = [Txtox Tftox Tftox;...
      Txtox Tftox Tftox;...
      Txtof Tftof Tftof];
  
Si.InputName = {['x' num2str(i-1)], ['f' num2str(i+1)], ['g' num2str(i)]};
Si.OutputName = {['x' num2str(i)], ['d' num2str(i)], ['f' num2str(i)]};

end

