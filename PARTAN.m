%% Parallel Tangent Method %%
% func: Cost function
% vars: Variables of cost function
% init: Initial values
% inter: Interval for ODSA
% iter: Maximum iterations
% prec: Result precision
% odvar: ODSA symbolic variable

function y = PARTAN(func, vars, init, inter, iter, prec, e, e2)
    df1 = transpose(Differentiate(func, vars));   
    x1 = init;
    x2 = transpose(transpose(x1) - e * CalculateFunctions(df1, vars, x1));
    i = 0;
    while(i < iter)  
        x3 = transpose(x2) - e * CalculateFunctions(df1, vars, x2) + e2 * transpose(x2 - x1);  
        x1 = x2;
        x2 = transpose(x3);
        i = i + 1;
    end
    y = x3;
end

%{
Example usage

syms x y

f = @(x, y) 0.7*x^4 - 8*x^2 + 6*y^2 + cos(x*y) - 8*x;
vars = [x y];

init = [-3.14 3.14];
interval = [-3.14, 3.14];

res = PARTAN(f, vars, init, inter, 20, 10^-5, 0.01, 0.02);
disp(res);
%}