function [connectedSystem] = connect_force_actuator(system,actuator)
%CONNECT_FORCE_ACTUATOR Summary of this function goes here
%   Detailed explanation goes here
connectedSystem = lft(system, actuator,'name');
end

