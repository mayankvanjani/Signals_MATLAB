%% Mayank Vanjani
% Lab 4: Complex Poles
% 11/16/18
clear;
clc;
step = @(n, t) n >= t;
delta = @(n,t) n == t;
ramp = @(n,t) (n-t).*(n >= t);
%% 1: Difference Equation
%{
%n = 0:10;
%Diffeq(delta(n,0));
%H = ( 1 - 2.5*z^(-1) ) / ( 1 - z^(-1) + 0.7*z^(-2) );
b = [1 -2.5];
a = [1 -1 0.7];
%x = rand(2,15);
%x = delta(n,0);
x = [1:0.1:2];
disp(x);
y = filter(b,a,x);
stem(0:length(x)-1,x(1,:));
hold on;
stem(0:length(x)-1,y(1,:));
hold off;
%}

%% 2: Partial Franction Expansion

%% 3: Expression

%% 4: Z-Plane
% Z-Plane/Transform shows stability
% Poles inside unit circle = Stable

%% 5: New Equation
% Complex Conjugates and Stable = Decaying Sinusoid