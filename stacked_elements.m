%% Init
clear all;
close all;
clc;

%% Create Mass Damper Sub-Systems and Force Actuator
granite = create_element(1, 1500, 5e9, 1);
spindle = create_element(2, 612, 1.7e8, 1);
upositionning = create_element(3, 193, 7e8, 1);
npositionning_lorentz = create_element(4, 15, 1e4, 1);
npositionning_piezo = create_element(4, 15, 5e7, 1);
sample = create_element(5, 50, 1e9, 1);

F = create_force_actuator(3, 4);

%% Connect all the Sub-Systems
sys_lorentz = connect_elements({granite, ...
                                spindle, ...
                                upositionning, ...
                                npositionning_lorentz, ...
                                sample});
sys_lorentz = connect_force_actuator(sys_lorentz, F);

sys_piezo = connect_elements({granite, ...
                              spindle, ...
                              upositionning, ...
                              npositionning_piezo, ...
                              sample});
sys_piezo = connect_force_actuator(sys_piezo, F);


%% Analyse
figure; hold on;
bode(access_sub_tf(sys_lorentz, 'x0', 'd5'));
bode(access_sub_tf(sys_piezo, 'x0', 'd5'));
legend({'Lorentz', 'Piezo'})
hold off;
%export_fig './figures/bode_diag_connected_elem' -png -pdf -transparent;

figure; hold on;
bode(access_sub_tf(sys_lorentz, 'F', 'd5'));
bode(access_sub_tf(sys_piezo, 'F', 'd5'));
legend({'Lorentz', 'Piezo'})
hold off;
