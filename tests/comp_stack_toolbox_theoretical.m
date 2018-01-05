%% Init
clear;
close all;
clc;

%% Parameters
m1 = 70;
k1 = 1e9;
c1 = sqrt(k1*m1)/10;

m2 = 20;
k2 = 5e8;
c2 = sqrt(k2*m2)/10;

%% Create elements and systen
s1 = createElement(1, m1, k1, c1);
s2 = createElement(2, m2, k2, c2);

system = connectElements({s1, s2});

%% Get sub system
sys1 = getSubTf(system, 'x0', 'd1');
sys2 = getSubTf(system, 'x0', 'd2');

%% Theoretical Formulas
s = tf('s');

theoretical1 = ((c1*s+k1)*(m2*s^2+c2*s+k2))/((m2*s^2*(c2*s+k2)+(m2*s^2+c2*s+k2)*(m1*s^2+c1*s+k1)));
theoretical2 = ((c1*s+k1)*(c2*s+k2))/((m2*s^2*(c2*s+k2)+(m2*s^2+c2*s+k2)*(m1*s^2+c1*s+k1)));

%% Comparison

bode(sys1\theoretical1, sys2\theoretical2)

