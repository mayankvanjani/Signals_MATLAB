%% Mayank Vanjani
% Lab 5: Frequency Responses
% 11/30/18
clear;
clc;

step = @(n, t) n >= t;
delta = @(n,t) n == t;
ramp = @(n,t) (n-t).*(n >= t);


%% 1



%% 2
% H(w) = H(z) at z = e^(jw) is discrete Fourier Transform
% [H,w] = freqz(b,z) => H is frequency response and w is indices
% w from [0,pi] becasue real so repetitive from pi to 2pi
% plot w / pi as freq response because easy to visualize


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


%% 4
% evaluate exactly, put mark at 0.1pi point of freq response
% evaluate H(z) polynomial exactly at given frequency using polyval


%% 5 Questions
% Same as 3 but pure sinusoid, no step function => mag and phase shift
% used filter function implementing diff eq and generate another analytical
%   output and compare (same)
% after time transient, identical 
% analytical has no transient because continuous sinusoid, filter has
%   transient so plot difference but dies out with time
% assume step function implicitley with filter bc initial condition


%% 6
% magnitude is 0 at popint 0.3pi
% but theres step function so not exact zero because transient response
% after dies out, steady state is 0


%% 7 Questions
% Zeros and poles from transfer function using partial fractions
% Close to zero = dip; close to pole = spike
% ^^^ Close means w is close in terms of w*pi radians
% if poles at 0; dont affect magnitude when w moves around unit circle bc
%   distance always 1 (this only affects phase)
% 


%% 8
% Plot z-plane for all systems and predict freq response
% last one is close to unit circle so large peak


%% 9
% logscale u acis
% semilog x for loggscale in x axis, us plot if not want log scale
% smaller second peak between 0.6 and 1 (pic) because farther from all
%   poles at 0.8pi than at 0 (also this means 0.8pi or 0pi at UNIT CIRCLE)
% first peak is larger because at 0pi = w, close to all 3 poles so big
%   spike

