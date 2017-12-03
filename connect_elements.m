function [connected_Si] = connect_elements(Sis)
%CONNECT_ELEMENTS Summary of this function goes here
%   Detailed explanation goes here

connected_Si = Sis{1};
for i=1:length(Sis)-1
    connected_Si = lft(connected_Si, Sis{i+1}, ['x'+num2str(i), 'f'+num2str(i+1)]);
end

end

