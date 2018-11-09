% fs2.m : FOURIER SERIES - |cos(t)| PULSE SIGNAL
% Sinusoidal Wave (30)
% Most rapid convergence since we are getting coefficients for a periodic
%   smooth signal which is easily represented using a small number of
%   Fourier Coefficients (or a small sum of cos waves)
%   Almost perfect at 5 iterations and indistinguishable after 10

clear all
clc

T   = 2*pi;                 % T = period
wo  = 2*pi/T;               % fundamental frequency
w0s = 1;

Tpr = 1;
t = -Tpr*T:0.005:Tpr*T;     % t = time axis

c0 = 2/pi;
x = c0*ones(size(t));       % DC component of x(t)

Nv = 30;

k = 1:Nv;

% Coefficient formula for pulse wave
ck = 1/2*(sinc(pi/2*(1-k)/pi) + sinc(pi/2*(1+k)/pi));
ck = [0 ck(2:end)];

figure(1)
clf
for k = 1:Nv
    
    % Loop for xk values
    xk = 2*ck(k)*cos(k*wo*t);
    
    subplot(2,1,1)
    plot(t,abs(cos(t))); % Original
    ylim([0,1.2])
    % Formatting graph axis
    xticks([-2*pi -1.5*pi -pi -0.5*pi 0 0.5*pi pi 1.5*pi 2*pi])
    xticklabels({'-2 \pi','-3\pi/2','-\pi','-\pi/2','0','\pi/2','\pi','3\pi/2','2 \pi'})
    
    % Next iteration, add xk with particular coefficient
    x = x + xk;
    
    subplot(2,1,2)
    plot(t,x)
    ylim([0,1.2])
    % Formatting graph axis
    xticks([-2*pi -1.5*pi -pi -0.5*pi 0 0.5*pi pi 1.5*pi 2*pi])
    xticklabels({'-2 \pi','-3\pi/2','-\pi','-\pi/2','0','\pi/2','\pi','3\pi/2','2 \pi'})
    
    xlabel('t')
    title(['N = ',num2str(k)],...
       'FontSize',20,'Interpreter','latex')
    pause(0.5)
end
