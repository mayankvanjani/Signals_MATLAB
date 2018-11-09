function y = myDiffeq(x, case_val)

N = length(x);
y = zeros(1,N);

switch case_val
    
    case 1
        y(1) = x(1);
        for n = 2:N-1
            y(n) = x(n)+2*x(n-1)-0.95*y(n-1);
        end
        
    case 2
        y(1) = x(1);
        for n = 2:N-1
            y(n) = x(n)+2*x(n-1);
        end
        
    case 3
        y(1) = x(1);
        for n = 2:N-1
            y(n) = x(n)+2*x(n-1)-1.1*y(n-1);
        end
        
end