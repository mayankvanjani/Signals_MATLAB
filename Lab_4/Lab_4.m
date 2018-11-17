%% Mayank Vanjani
% Lab 4: Complex Poles
% 11/16/18
clear;
clc;
step = @(n, t) n >= t;
delta = @(n,t) n == t;
ramp = @(n,t) (n-t).*(n >= t);

%% 1: Difference Equation
% H(z) = Y/X
% Result takes the form of a damped sinusoid
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
n = 0:25;
impulse = delta(n,0);

h = myDiffeq(impulse,4);
len_h = length(h);

numerator = [1 -2.5];
denominator = [1 -1 0.7];
h_filter = filter(numerator, denominator, impulse);

figure(1); clf;
subplot(2,1,1);
stem(0:len_h-1,impulse);
title("Impulse Signal \delta(n)");

subplot(2,1,2);
% See the same response when using the filter command and difference equation
stem(0:len_h-1,h,'r',"Linewidth", 1.25);
hold on;
stem(0:len_h-1,h_filter,'k--',"Linewidth", 1.25);
hold off;
legend("Difference Equation", "Filter");
title("Difference Equation Impulse Response");

%% 2: Partial Franction Expansion
% Using MATLAB Residue Command
% h(n) = C1p1^nu(n) + C2p2^nu(n)
numerator = [1 -2.5];
denominator = [1 -1 0.7];
[r,p,k] = residue( numerator, denominator );

% Complex Conjugate pairs that cancel into a real impulse response
% Seen from real plot of reconstructed h(n)
C1 = r(1); C2 = r(2);
p1 = p(1); p2 = p(2);
step_funct = step(n,0);

h_partial = (C1 * p1.^n .* step_funct) + (C2 * p2.^n .* step_funct);

figure(2); clf;
subplot(2,1,1);
stem(0:len_h-1,impulse);
title("Impulse Signal \delta(n)");

subplot(2,1,2);
stem(0:len_h-1,h,'y', "Linewidth", 2);
hold on;
stem(0:len_h-1,h_filter,'r',"Linewidth", 1.25);
stem(0:len_h-1,h_partial,'k--',"Linewidth", 1.25);
hold off;
legend("Difference Equation", "Filter", "Partial Fraction");
title("Partial Fraction Expansion Impulse Response");


%% 3: Expression
% Non-Complex Impulse Response
% h(n) = Ar^ncos(wn+theta)u(n)

%% 4: Z-Plane
% Z-Plane/Transform shows stability
% Poles inside unit circle = Stable

%% 5: New Equation
% Complex Conjugates and Stable = Decaying Sinusoid