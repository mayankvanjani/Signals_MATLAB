% TIME SHIFTING PROPERTY OF FOURIER COEFFICIENTS
% Sinusoidal wave and Line spectrum of coefficients
% As proven in class, shifting a function results in coefficients of all
%   same magnitude but shifted phases. know f(t) => Cn 
%   f(t-t0) = exp( -(j)(n)(w0)(t0) ) * Cn so same plot as before but shift
%   so time shift property is confirmed

T = 2;                          % PERIOD
wo = pi;

M = 200;                        % DISCRETIZATION OF THE TIME AXIS
delT = T/M;
t = [0:delT:T-delT];            % TIME AXIS

% Modified x(t) to x(t-t0) so signal delayed by t0 seconds as seen
x = abs(cos(pi*(t-0.2)));       % COMPUTE SAMPLES OF x(t-0.2) ON GRID

N = 20;                         % COMPUTE FS COEFFICIENTS C(0)...C(N)
J = sqrt(-1);
c = zeros(1,N+1);               % COMPUTE C(k) WITH A SUM
c(1) = 1/T * delT * sum(x);

for k = 1:N
    c(k+1) = 1/T * delT * sum(x .* exp(-J*k*wo*[0:M-1]*delT));
    % note: because Matlab indexing begins with 1 instead of 0,
    % it is necessary to add 1 to the index. c(k+1) means 'c(k)'!
end

% NOTE: C(-k) = conj(C(k)) because x(t) is a REAL signal.
% Therefore only compute c(k) for k >= 0.

figure(1)                 % PLOT THE LINE SPECTRUM
stem([0:N]/T,abs(c),'.')  % (THE LINE SPECTRUM IS A PLOT OF C(K))
xlabel('Hertz')
ylabel('|C(k)|')
title('LINE SPECTRUM')

t = [0:500]/500*T;         % PLOT TWO PERIODS OF THE SIGNAL
y = c(1) * ones(size(t));  % SYNTHESIZED FROM THE NUMERICALLY
for k = 1:N                % OBTAINED FS COEFFICIENTS
    y = y + c(k+1)*exp(J*k*wo*t) + conj(c(k+1))*exp(-J*k*wo*t);
end
figure(2)
plot(t,real(y));

figure(3);
clf;
subplot(2,2,[1 2]);
%Time Shifted graph
plot(t, real(y));
title("Time Shifted");
subplot(2,2,[3 4]);

% Old Unshifted Graph
T = 1;                    
wo = 2*pi/T;
M = 200;                  
delT = T/M;
t = [0:delT:T-delT];      
x = abs(cos(pi*t));       
N = 20;                   
J = sqrt(-1);
c = zeros(1,N+1);         
c(1) = 1/T * delT * sum(x);
for k = 1:N
    c(k+1) = 1/T * delT * sum(x .* exp(-J*k*wo*[0:M-1]*delT));
end
t = [0:500]/500*2*T;       
y = c(1) * ones(size(t));  
for k = 1:N                
    y = y + c(k+1)*exp(J*k*wo*t) + conj(c(k+1))*exp(-J*k*wo*t);
end

plot(t,real(y));
title("Unishfted");