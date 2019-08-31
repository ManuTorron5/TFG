function [t,u] = dif_cent(f, t, x0)

    N = length(t);
    h = (t(N) - t(1))/N;
    
    u = zeros(length(x0), N);

    u(:, 1) = x0;
    
    % Iniciar con Euler (hallar x1)
    u(:, 2) = u(:, 1) + h*feval(f, t(1), u(:, 1));

    n = 2;
    while n < N
        u(:, n+1) = u(:, n-1) + 2*h*feval(f, t(n), u(:, n));
        n = n+1;
    end
    
    u = u.';
end