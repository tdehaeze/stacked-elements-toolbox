function [connected_system] = connectElements(systems, opts_param)
% connectElements - Connect all the elements of the systems cell array
%
% Syntax: connectElements(systems)
%
% Inputs:
%    - systems - Cell Array containing all the elements of the system. The elements should be in the right order (i from 1 to n)
%    - opts_param   - Optionals parameters: structure with the following fields:
%        - use_minreal (default: true) - Use minreal to delete pole-zero pairs in transfer functions
%
% Outputs:
%    - connected_system - Return one MIMO transfer function corresponding to the total connected system
%
% Example:
%    granite = createElement(1, 1500, 5e9, 1);
%    sample = createElement(2, 50, 1e9, 1);
%    system = connectElements({granite, sample});
%    bode(getSubTf(system, 'x0', 'd2'), getSubTf(granite, 'x0', 'd1'));

%% Default value for opts
opts = struct('use_minreal', true);

if exist('opts_param','var')
    for opt = fieldnames(opts_param)'
        opts.(opt{1}) = opts_param.(opt{1});
    end
end

%% Connect the elements
connected_system = systems{1};

for i=1:length(systems)-1
    connected_system = lft(connected_system, systems{i+1}, ['f'+num2str(i+1), 'x'+num2str(i)]);
    if opts.use_minreal
        connected_system = minreal(connected_system);
    end
end

end

