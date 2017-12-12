function [connected_system] = connectElements(systems)
% connectElements - Connect all the elements of the systems cell array
%
% Syntax: connectElements(systems)
%
% Inputs:
%    systems - Cell Array containing all the elements of the system. The elements should be in the right order (i from 1 to n)
%
% Outputs:
%    - connected_system - Return one MIMO transfer function corresponding to the total connected system
%
% Example:
%    


connected_system = systems{1};

for i=1:length(systems)-1
    connected_system = lft(connected_system, systems{i+1}, ['x'+num2str(i), 'f'+num2str(i+1)]);
end

end

