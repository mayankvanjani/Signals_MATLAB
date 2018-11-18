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
        
    case 4
        y(1) = x(1);
        y(2) = x(2) - 2.5*x(1) + y(1);
        for n = 3:N-1
            y(n) = x(n) - 2.5*x(n-1) + y(n-1) - 0.7*y(n-2);
        end
        
    case 5
        y(1) = x(1);
        y(2) = x(2) - 0.6*x(1) + 2.1*y(1);
        y(3) = x(3) - 0.6*x(2) + 2.1*y(2) - 1.6*y(1);
        for n = 4:N-1
            y(n) = x(n) - 0.6*x(n-1) + 2.1*y(n-1) - 1.6*y(n-2) + 0.4*y(n-3);
        end
        
end