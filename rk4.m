function [t, u] = rk4(f, t, x0)
    
    N = length(t);
    h = (t(N) - t(1))/N;
    
    u = zeros(length(x0), N);

    u(:, 1) = x0;
    n = 1;
    while n < N

        k1 = feval(f, t(n), u(:, n));
        k2 = feval(f, t(n)+h/2, u(:, n)+(h/2)*k1);
        k3 = feval(f, t(n)+h/2, u(:, n)+(h/2)*k2);
        k4 = feval(f, t(n)+h, u(:, n)+h*k3);

        u(:, n+1) = u(:, n) + (h/6)*(k1 + 2*k2 + 2*k3 + k4);

        n = n+1;
    end
    
    u = u.';

end

