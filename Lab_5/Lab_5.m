%% Mayank Vanjani
% Lab 5: Frequency Responses
% 11/30/18
clear;
clc;

step = @(n, t) n >= t;
delta = @(n,t) n == t;
ramp = @(n,t) (n-t).*(n >= t);


%% 1
% y(n) = 0.1x(n) - 0.1176x(n-1) + 0.1x(n-2) + 1.7119y(n-1) - 0.81y(n-2)
% y(n) - 1.7119y(n-1) + 0.81y(n-2) = 0.1x(n) - 0.1176x(n-1) + 0.1x(n-2) 
% H(z) = Y(s)/X(s) = (0.1 - 0.1176s + 0.1s^2) / (1 - 1.7119s + 0.81s^2)

%% 2
% H(w) = H(z) at z = e^(jw) is discrete Fourier Transform
% [H,w] = freqz(b,z) => H is frequency response and w is indices
% w from [0,pi] becasue real so repetitive from pi to 2pi
% plot w / pi as freq response because easy to visualize

numerator = [0.1, -0.1176, 0.1];
denominator = [1, -1.7119, 0.81];
[H, w] = freqz(numerator,denominator);

figure(1); clf;
subplot(2,1,1);
plot(w, abs(H));
xlim( [0,pi] );
xlabel("\omega");
title("System Frequency Response");
subplot(2,1,2);
plot(w./pi, abs(H),"LineWidth",2);
xlim( [0,1] );
xlabel("\omega / \pi");
title("Magnitude Frequency Response | H^f(\omega) | (with better axis units)");


%% 3 Question
% magnitude at 0.1pi is greater than 1 from previous
% results in scaled sinusoid wave (picture) becasue LTI system
% output is same freq with mag and phase shift at that frequency
% if at 0.3pi then attenuated so output is 0 line
% slight problem in beginning of input and output sinusoid signal because
%   function we have is from 0 to infinity (not start at neg inf) because
%   we show transient response of system since it takes time to input full
%   signal (steady state response is latter part and transient is beginning
%   where scaling is a little off because initially takes time to be
%   filtered but once whole signal is inside then its correct)
% Same analysis but we are taking IIR so dies out at higher values (almost
% 0) but not quite. Still behaves like steady state response

n = 0:100;
x = cos( (0.1*pi) * n ) .* step(n,0);
y = filter(numerator,denominator,x);

figure(2); clf;
subplot(5,2,[1,3]);
plot(0:length(x)-1,x);
ylim( [-1.5,1.5] );
title("Input Signal x(n)");

subplot(5,2,[2,4]);
plot(0:length(y)-1,y,'r');
ylim( [-1.5,1.5] );
title("Output Signal y(n)");

subplot(5,2,[7,8,9,10]);
plot(0:length(x)-1,x);
hold on;
plot(0:length(y)-1,y);
hold off;
ylim( [-1.5,1.5] );
legend( {"Input Signal", "Output Signal"} );
title("Overlayed Signals");


%% 4
% evaluate exactly, put mark at 0.1pi point of freq response
% evaluate H(z) polynomial exactly at given frequency using polyval

expt = exp(j*0.1*pi);
Hpoint = polyval(numerator,expt) / polyval(denominator,expt);

figure(3); clf;
plot(w./pi, abs(H));
hold on;
plot(0.1, abs(Hpoint), 'rx');
hold off;
title( "Magnitude Frequency Response | H^f(\omega) | with Marker at \omega = 0.1\pi" );


%% 5 Questions
% Same as 3 but pure sinusoid, no step function => mag and phase shift
% used filter function implementing diff eq and generate another analytical
%   output and compare (same)
% after time transient, identical 
% analytical has no transient because continuous sinusoid, filter has
%   transient so plot difference but dies out with time
% assume step function implicitley with filter bc initial condition

n = 0:100;
x = cos(0.1*pi*n);
y = filter(numerator,denominator,x);
y2 = abs(Hpoint) .* cos( 0.1*pi*n + angle(Hpoint) );

figure(4); clf;
subplot(2,1,1);
plot(0:length(x)-1,x,"LineWidth",2);
hold on;
plot(0:length(y)-1,y,'y',"LineWidth",2);
plot(0:length(y)-1,y2,'k');
hold off;
ylim( [-1.5, 1.5] );
legend( {"Input", "Output Filter", "Output Analytic"} );
title("Magnitude Frequency Response | H^f(\omega) |");

subplot(2,1,2);
plot(0:length(y)-1,y-y2);
ylim( [-1, 0.5] );
title("Analytical and Filter Difference");


%% 6
% magnitude is 0 at popint 0.3pi
% but theres step function so not exact zero because transient response
% after dies out, steady state is 0

n = 0:100;
x = cos( (0.3*pi) * n ) .* step(n,0);
y = filter(numerator,denominator,x);

figure(5); clf;
subplot(5,2,[1,3]);
plot(0:length(x)-1,x);
ylim( [-1.5,1.5] );
title("Input Signal x(n)");

subplot(5,2,[2,4]);
plot(0:length(y)-1,y,'r',"LineWidth",2);
ylim( [-1.5,1.5] );
title("Output Signal y(n)");

subplot(5,2,[7,8,9,10]);
plot(0:length(x)-1,x);
hold on;
plot(0:length(y)-1,y,"LineWidth",2);
hold off;
ylim( [-1.5,1.5] );
legend( {"Input Signal", "Output Signal"} );
title("Overlayed Signals");


%% 7 Questions
% Zeros and poles from transfer function using partial fractions
% Close to zero = dip; close to pole = spike
% ^^^ Close means w is close in terms of w*pi radians
% if poles at 0; dont affect magnitude when w moves around unit circle bc
%   distance always 1 (this only affects phase)

figure(6); clf;
zplane(numerator,denominator);
title("PoleZero Diagram for System");


%% 8
% Plot z-plane for all systems and predict freq response
% last one is close to unit circle so large peak

[H1, w1] = freqz(1,[1 1.8 -0.9]);
[H2, w2] = freqz(1,[1 1.6 -0.72]);
[H3, w3] = freqz(1,[1 1.53 -0.9]);
[H4, w4] = freqz(1,[1 1.4 -0.72]);
[H5, w5] = freqz(1,[1 -0.85]);
[H6, w6] = freqz(1,[1 -0.95]);

figure(7); clf;
subplot(6,2,1);
plot(w1./pi, abs(H1), "LineWidth", 2);
xlim( [0,1] );
subplot(6,2,2);
zplane(1,[1 1.8 -0.9]);

subplot(6,2,3);
plot(w1./pi, abs(H1), "LineWidth", 2);
xlim( [0,1] );
subplot(6,2,4);
zplane(1,[1 1.8 -0.9]);

subplot(6,2,5);
plot(w1./pi, abs(H1), "LineWidth", 2);
xlim( [0,1] );
subplot(6,2,6);
zplane(1,[1 1.8 -0.9]);

subplot(6,2,7);
plot(w1./pi, abs(H1), "LineWidth", 2);
xlim( [0,1] );
subplot(6,2,8);
zplane(1,[1 1.8 -0.9]);

subplot(6,2,9);
plot(w1./pi, abs(H1), "LineWidth", 2);
xlim( [0,1] );
subplot(6,2,10);
zplane(1,[1 1.8 -0.9]);

subplot(6,2,11);
plot(w1./pi, abs(H1), "LineWidth", 2);
xlim( [0,1] );
subplot(6,2,12);
zplane(1,[1 1.8 -0.9]);


%% 9
% logscale u acis
% semilog x for loggscale in x axis, us plot if not want log scale
% smaller second peak between 0.6 and 1 (pic) because farther from all
%   poles at 0.8pi than at 0 (also this means 0.8pi or 0pi at UNIT CIRCLE)
% first peak is larger because at 0pi = w, close to all 3 poles so big
%   spike

