%% Multivariate Steepest Descent Method %%
% func: Cost function
% vars: Variables of cost function
% init: Initial values
% inter: Interval for ODSA
% iter: Maximum iterations
% prec: Result precision
% odvar: ODSA symbolic variable
% odsa: ODSA algorithm for step size

function y = SteepestDescentMethod(func, vars, init, inter, iter, prec, odvar, odsa)
    df1 = Differentiate(func, vars);   
    x1 = init;
    disp(vars);
    i = 0;
    r = 1;
    ods = str2func(char(odsa));
    f1 = 0;
    f2 = 1;
    while(i < iter && f1 ~= f2)  
        % Linear search
        mm = -CalculateFunctions(df1, vars, x1); 
        opt = x1 + odvar * mm;
        r = ods(func, inter(:,1), inter(:,2), prec, 2*prec, 150, opt, odvar);
        x2 = x1 + (r * mm);  
                disp("----------");
        disp(r);
        disp(x1);
        disp(x2);
        f1 = CalculateFunctions(func, vars, x1);
        f2 = CalculateFunctions(func, vars, x2);      
        x1 = x2;
        i = i + 1;
    end
    y = transpose(x2);
end

%{
Example usage

syms x y e

f = @(x, y) 0.7*x^4 - 8*x^2 + 6*y^2 + cos(x*y) - 8*x;
v = [x y];
s = [-3.14 3.14];
interval = [-3.14, 3.14];
u = e;
ods = str2func("MultidimFibonacciSearch");
u = GradientDescent(f, s, interval, v, 10, 10^-5, e, ods);
disp(u);
%}
