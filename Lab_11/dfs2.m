% NUMERICAL COMPUTATION OF FOURIER SERIES COEFFICIENTS
% Triangular wave and Line spectrum of coefficients
% approximate the integral as a summation

T = 2;                    % PERIOD
wo = 2*pi/T;

M = 200;                  % DISCRETIZATION OF THE TIME AXIS
delT = T/M;
t = [0:delT:T-delT];      % TIME AXIS


% TWO VERSIONS OF TRIANGLE SIGNALS

% Triangle Wave using Sawtooth function with 50% symmetry
% x = abs( sawtooth ((pi * (t) / 2), 0.5) );  

% Triangular Wave Samples using mod (remainder of t / 2)
% Since t is increasing from 0 to T*1.99, remainder follows triangle wave
%   pattern since wrap around after t passes multiples of 2
x = abs(mod(t,2)-1);    


N = 100;                   % COMPUTE FS COEFFICIENTS C(0)...C(N)
J = sqrt(-1);
c = zeros(1,N+1);         % COMPUTE C(k) WITH A SUM in the for loop
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

t = [0:500]/500*2*T;       % PLOT TWO PERIODS OF THE SIGNAL
y = c(1) * ones(size(t));  % SYNTHESIZED NUMERICALLY

for k = 1:N                % OBTAINED FS COEFFICIENTS
    y = y + c(k+1)*exp(J*k*wo*t) + conj(c(k+1))*exp(-J*k*wo*t);
end
figure(2)
plot(t,real(y));
