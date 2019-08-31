function [t, u] = nys4(f, t, x0)

    N = length(t);

    h = (t(N) - t(1))/N;

    u = zeros(length(x0), N);

    %Iniciar con RK4 (hallar x1, x2 y x3)

    [~, v] = rk4(f, t(1):h:(t(1)+3*h), x0);
    v = v.';

    u(:, 1:4) = v; 

    n = 4;
    
    while n < N
        
        u(:, n+1) = u(:, n-1) + (h/3)*(...
            7*feval(f, t(n), u(:, n))...
            - 2*feval(f, t(n-1), u(:, n-1))...
            + feval(f, t(n-2), u(:, n-2)));

        n = n+1;
        
    end
    
    u = u.';

end