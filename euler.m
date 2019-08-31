 function [t,u] = euler(f, t, x0)

    N = length(t);
    h = (t(N) - t(1))/N;
    
    u = zeros(length(x0), N);

    u(:, 1) = x0;

    n = 1;
    while n < N
        u(:, n+1) = u(:, n) + h*feval(f, t(n), u(:, n));
        n = n+1;
    end
    
    u = u.';
end


