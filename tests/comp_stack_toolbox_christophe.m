%% Script Description
% Comparison of the methods developped by Christophe and the
% Stacked-Elements-Toolbox developped by Thomas. Should have the same
% result.

%%
clear;
close all;
clc;

%%
s = tf('s');

%% Flexible Structure
mi = 1500;
ci = 10;
ki = 1e9;

struct_f_to_x =  1/(mi*s^2 + ci*s + ki);

%% Top element
ma = 20;
ca = 1;
ka = 1e9;

T_DVA = 1/(ma*s^2);
H_DVA = ca*s + ka;

%% Concatenation of transfert functions
sysAp = append(struct_f_to_x, T_DVA, H_DVA);

%%
Nout = size(struct_f_to_x, 1);
Nin  = size(struct_f_to_x, 2);
dof  = 1;

Q = [dof   -(Nout+2) 0;
     Nin+1 (Nout+2)  0;
     Nin+2 dof       -(Nout+1)];

%% Connection of the system
Inputs = 1:Nin;
Outputs = 1:Nout;

sys_withDVA = connect(sysAp, Q, Inputs, Outputs);

%% Using the Stacked-Elements-Toolbox
support = createElement(1, mi, ki, ci);
element = createElement(2, ma, ka, ca);

system = connectElements({support, element});
sys_from_g_to_d = getSubTf(system, 'g1', 'd1');

%%
w = logspace(2, 4, 1000);

figure;
bode(sys_from_g_to_d, 'r-', sys_withDVA, 'b--', w);

%%
w = logspace(2, 4, 1000);

figure;
bode(sys_from_g_to_d\sys_withDVA, w);

