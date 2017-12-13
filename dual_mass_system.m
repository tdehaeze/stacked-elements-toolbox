%% Init
clear;
close all;
clc;

%%
s1 = createElement(1, 20, 1e5, 1000);
s2 = createElement(2, 20,  2e8, 1000);

system = connectElements({s1, s2});

%%
S = createDisplacementSensor(1, 2, tf(1));
system = connectDisplacementSensor(system, S);

%%
F = createForceActuator(1, 2, tf(1));
system = connectForceActuator(system, F);

%%
%bode(getSubTf(system, 'x0', 'D12'))
%bode(getSubTf(system, 'F12', 'D12'))

%%
t  = 0:1e-5:2;
commands = struct();
commands.F12 = 1*(t > 0.1);
%commands.x0 = 1e-6*(t > 0.2);
options = struct();
%options.output_names = {'d1', 'd2', 'D12'};

system_output = systemSimulation(system, t, commands, options);

figure; hold on;
plot(system_output.time, system_output.d1)
plot(system_output.time, system_output.d2)
plot(system_output.time, system_output.D12)
legend({'d1', 'd2', 'D12'})
hold off;

%%
% t  = 0:1e-5:20;
% x0 = 1e-6*(t > 1);
% 
% D12 = lsim(getSubTf(system, 'x0', 'D12'), x0, t);
% d2 = lsim(getSubTf(system, 'x0', 'd2'), x0, t);
% d1 = lsim(getSubTf(system, 'x0', 'd1'), x0, t);
% 
% plot(t, D12, t, d1, t, d2)

