clear all;
clc;

%%
T1 = create_element(1, 1000, 1e8, 1e2);
T2 = create_element(2, 80, 1e7, 1e2);
T3 = create_element(3, 20, 1e8, 1e2);

F = create_force_actuator(2, 3);

Ttot = connect_elements({T1, T2, T3});

Tconnected = connect_force_actuator(Ttot, F);

figure; hold on;
bode(access_sub_tf(Tconnected, 'F', 'd1'));
hold off;