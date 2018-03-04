%% Fibonnaci Search with precomputed generator to be used in another opt. method as ODSA %%
% func: Symbolic function
% a: Lowerbound
% b: Upperbound
% p: Max precision interval
% e: Precision
% r: Number of iterations
% t: Equation of symbolic input
% u: Symbolic input

function res = MultidimFibonacciSearch(func, a, b, p, e, r , t, u)
    
    %% Generates Fibonacci series %%
    function f = fibo_gen(r)
        n(1) = 1;
        n(2) = 1;
        k = 3; 
        while k <= r
            n(k) = n(k-1) + n(k-2);
            k = k+1;
        end
        f = n;
    end

    m = mat2cell(t,1,ones(1,numel(t)));
    rr = func(m{:});
    z = matlabFunction(rr,'vars', u); 
    
    n = fibo_gen(r);
    i = 1;
    a1 = a; b1 = b;
    
    a2=0; b2=0; x2=0; y2=0;
    
    x = (n(r-2)*1.0/n(r))*(b1 - a1);
    y = (n(r-1)*1.0/n(r))*(b1 - a1);
    
    while abs(b1-a1) > p && i < r
       a2=a1; b2=b1; 
       x2=x; y2=y; 
        
       if(z(x) > z(y))
          a1 = x;
          x = y;
          if i == (r-2)
              break
          end
          y = (a1 + (n(r-i-1)*1.0/n(r-i)))*abs(b1-a1);
       else
            b1 = y;
            y = x;
            if i == r -2
                break
            end
            x = (a1 + (n(r-i-2)*1.0/n(r-i)))*abs(b1-a1);
       end
       i = i + 1;
    end
    x = x2;
    y = x2 + e;
    
    if z(x)>z(y)
        a1 = x;
        b1 = b2;
    else
        a1 = a2;
        b1 = y;
    end

    res = (a1 + b1)/2;
end

%{
Example usage

syms x y e
f = @(x, y) 0.7*x^4 - 8*x^2 + 6*y^2 + cos(x*y) - 8*x;

u = [e];
o = [1 2] + e*[4 5];

y = fibonacci(f, -0.5, 0.5, 2e-5, 1e-5, 120, o, u);
disp(y);
%}