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
% Plot w / pi as freq response because easy to visualize

numerator = [0.1, -0.1176, 0.1];
denominator = [1, -1.7119, 0.81];
[H, w] = freqz(numerator,denominator);

figure(1); clf;
subplot(2,1,1);
plot(w, abs(H));
xlim( [0,pi] );
xlabel("\omega");
title("System Frequency Response H^f(\omega)");

subplot(2,1,2);
plot(w./pi, abs(H),"LineWidth",2);
xlim( [0,1] );
xlabel("\omega / \pi");
title("Magnitude Frequency Response | H^f(\omega) | (with better axis units)");


%% 3
% Magnitude at 0.1pi is greater than 1 from previous
% Results in scaled sinusoid wave (picture) becasue LTI system
% Output is same freq with mag and phase shift at that frequency
% If at 0.3pi then attenuated so output is 0 line
% Slight problem in beginning of input and output sinusoid signal because
%   function we have is from 0 to infinity (not start at neg infinity) because
%   we show transient response of system since it takes time to input full
%   signal (steady state response is latter part and transient is beginning
%   where scaling is a little off because initially takes time to be
%   filtered but once whole signal is inside then its correct). From this,
%   we can see how the output signal y(n) will look like (predicted)
% Same analysis but we are taking IIR so dies out at higher values (almost
%   0) but not quite. Still behaves like steady state response

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
% Evaluate exactly, put mark at 0.1pi point of freq response
% Evaluate H(z) polynomial exactly at given frequency using polyval

expt = exp(j*0.1*pi);
Hpoint = polyval(numerator,expt) / polyval(denominator,expt);

figure(3); clf;
plot(w./pi, abs(H), "Linewidth", 1.25);
hold on;
plot(0.1, abs(Hpoint), 'rx', "MarkerSize", 10);
line([0.1 0.1], [0 1.4], "Color", "red", "LineStyle", "--");
hold off;
title( "Magnitude Frequency Response | H^f(\omega) | with Marker at \omega = 0.1\pi" );


%% 5 
% Same as 3 but pure sinusoid, no step function => mag and phase shift
% Used filter function implementing difference equation and generate another
%   analytical output to compare (resulting in same graph)
% After some time transient, filter and analytical are identical 
% Analytical has no transient because continuous sinusoid
% Filter has transient (above Q3) so plot difference in subplot
% Observed that s(n) and y(n) are the same after transient dies out
% Assume step function implicitley with filter because initial condition

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
% Magnitude is 0 at point 0.3pi as seen from the zero on the unit circle
% But theres step function so not exact zero because transient response
% After dies out, steady state is 0 (predicted value of y(n))
% See that the transient response for the filter initially behaves like a
%   cos wave and dies out eventually as you filter more values of the cos
%   wave which averages the integration to 0 => steady state = 0

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
ylim( [-0.5,0.5] );
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
%xlim( [0,1] );
subplot(6,2,2);
zplane(1,[1 1.8 -0.9]);

subplot(6,2,3);
plot(w2./pi, abs(H2), "LineWidth", 2);
%xlim( [0,1] );
subplot(6,2,4);
zplane(1,[1 1.6 -0.72]);

subplot(6,2,5);
plot(w3./pi, abs(H3), "LineWidth", 2);
%xlim( [0,1] );
subplot(6,2,6);
zplane(1,[1 1.53 -0.9]);

subplot(6,2,7);
plot(w4./pi, abs(H4), "LineWidth", 2);
%xlim( [0,1] );
subplot(6,2,8);
zplane(1,[1 1.4 -0.72]);

subplot(6,2,9);
plot(w5./pi, abs(H5), "LineWidth", 2);
%xlim( [0,1] );
subplot(6,2,10);
zplane(1,[1 -0.85]);

subplot(6,2,11);
plot(w6./pi, abs(H6), "LineWidth", 2);
%xlim( [0,1] );
subplot(6,2,12);
zplane(1,[1 -0.95]);


%% 9
% logscale u axis
% semilog x for loggscale in x axis, us plot if not want log scale
% smaller second peak between 0.6 and 1 (pic) because farther from all
%   poles at 0.8pi than at 0 (also this means 0.8pi or 0pi at UNIT CIRCLE)
% first peak is larger because at 0pi = w, close to all 3 poles so big
%   spike

poles = [ 0.8*exp(j*pi*0.2), 0.8*exp(-1j*pi*0.2), 0.7 ];
zeros = [ -1, exp(j*pi*0.6), exp(-j*pi*0.6) ];
num = poly( zeros );
denom = poly( poles );

[H9, w9] = freqz(num,denom);

n = 0:100;
x = delta(n,0);
h = filter(num,denom,x);

figure(8); clf;
subplot(2,2,1);
% semilogy(w9./pi, abs(H9));
plot(w9./pi, abs(H9));

subplot(2,2,2);
zplane(num,denom);

subplot(2,2,[3 4]);
plot(0:length(x)-1,h);

% New Poles
poles = [ 0.98*exp(j*pi*0.2), 0.98*exp(-1j*pi*0.2), 0.7 ];
denom = poly( poles );

[H9, w9] = freqz(num,denom);

h = filter(num,denom,x);

figure(9); clf;
subplot(2,2,1);
% semilogy(w9./pi, abs(H9));
plot(w9./pi, abs(H9));

subplot(2,2,2);
zplane(num,denom);

subplot(2,2,[3 4]);
plot(0:length(x)-1,h);

