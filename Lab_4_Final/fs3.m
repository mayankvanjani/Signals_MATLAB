% fs3.m : FOURIER SERIES - PERIODIC TRIANGULAR PULSE SIGNAL
% Triangular Wave (20)
% Relatively good approximation of a triangle wave with 20 iterations
%   This function is periodic and smooth so we know that a Fourier
%   tarnsform will represent this signal well, but this isn't a sinusoidal
%   signal so it will be represented slightly worse

T  = 2;                % T = period
t = -2*T:0.005:2*T;    % t = time axis

wo = 2*pi/T;           % fundamental frequency
c0 = 1/2;              % from the formula for c(k)
x = c0*ones(size(t));  % DC component of x(t)

Kv = 20;               % Number of sinusoids

figure(2)
clf
for k = 1:Kv
   
   ck = 1/T*(sinc(k/T))^2;    % the formula for c(k)
   xk = 2*ck*cos(k*wo*t);     % The kw0 sinusoids 
   
   subplot(2,1,1)
   plot(t,xk);
   title(['$\omega$= ',num2str(k*wo),' Sinusoids'],...
       'FontSize',20,'Interpreter','latex')
   %hold on
   %hold off
   
   x = x + xk;                % Next iteration
   
   subplot(2,1,2)
   
   plot(t,x)
   xlabel('t')
   title(['N = ',num2str(k)],...
       'FontSize',20,'Interpreter','latex')
   pause(0.3)
end

