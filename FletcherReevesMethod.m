%% Fletcher-Reeves Method %%
% func: Cost function
% vars: Variables of cost function
% init: Initial values
% inter: Interval for ODSA
% iter: Maximum iterations
% prec: Result precision
% odvar: ODSA symbolic variable
% odsa: ODSA algorithm for step size

function y = FletcherReevesMethod(func, vars, init, inter, iter, prec, odvar, odsa)
    df1 = Differentiate(func, vars);  
    i = 0;
    r = 1;
    x1 = init;
    g1 = CalculateFunctions(df1, vars, x1);
    d = -g1;
    ods = str2func(char(odsa));
    while(i < iter)  
        % Linear search
        opt = x1 + odvar * d;
        r = ods(func, inter(:,1), inter(:,2), prec, 2*prec, 100, opt, odvar);
        x2 = x1 + r * d; 
        g2 = CalculateFunctions(df1, vars, x2);                
        beta = norm(g2)/norm(g1);
        d = -g2 + beta * d;
        x1 = x2;
        g1 = g2;
        i = i + 1;
    end
    y = transpose(x2);
end

%{
Example usage

syms x y e

f = @(x, y) 0.7*x^4 - 8*x^2 + 6*y^2 + cos(x*y) - 8*x;
vars = [x y];

init = [-3.14 3.14];
inter = [-3.14, 3.14];

u = e;
ods = str2func("MultidimFibonacciSearch");
res = NewtonsMethod(f, vars, init, inter, 10, 10^-5, u, ods);
disp(res);
%}