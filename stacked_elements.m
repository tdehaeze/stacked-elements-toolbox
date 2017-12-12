%% Init
clear all;
close all;
clc;

%% Create Mass Damper Sub-Systems and Force Actuator
granite = createElement(1, 1500, 5e9, 1);
spindle = createElement(2, 612, 1.7e8, 1);
upositionning = createElement(3, 193, 7e8, 1);
npositionning_lorentz = createElement(4, 15, 1e4, 1);
npositionning_piezo = createElement(4, 15, 5e7, 1);
sample = createElement(5, 50, 1e9, 1);

F = createForceActuator(3, 4);

%% Connect all the Sub-Systems
sys_lorentz = connectElements({granite, ...
                                spindle, ...
                                upositionning, ...
                                npositionning_lorentz, ...
                                sample});
sys_lorentz = connectForceActuator(sys_lorentz, F);

sys_piezo = connectElements({granite, ...
                              spindle, ...
                              upositionning, ...
                              npositionning_piezo, ...
                              sample});
sys_piezo = connectForceActuator(sys_piezo, F);


%% Analyse
figure; hold on;
bode(getSubTf(sys_lorentz, 'x0', 'd5'));
bode(getSubTf(sys_piezo, 'x0', 'd5'));
legend({'Lorentz', 'Piezo'})
hold off;
%export_fig './figures/bode_diag_connected_elem' -png -pdf -transparent;

figure; hold on;
bode(getSubTf(sys_lorentz, 'F', 'd5'));
bode(getSubTf(sys_piezo, 'F', 'd5'));
legend({'Lorentz', 'Piezo'})
hold off;


