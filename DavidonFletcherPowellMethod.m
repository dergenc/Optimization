%% Davidon-Fletcher-Powell Method %%
% func: Cost function
% vars: Variables of cost function
% init: Initial values
% inter: Interval for ODSA
% iter: Maximum iterations
% prec: Result precision
% odvar: ODSA symbolic variable
% odsa: ODSA algorithm for step size

function y = DavidonFletcherPowellMethod(func, vars, init, inter, iter, prec, odvar, odsa)
    df1 = Differentiate(func, vars);
    df2 = Hessian(func, vars);
    x1 = init;
    i = 0;
    diff(df2);
    r = 1;
    rdf2 = CalculateFunctions(inv(df2), vars, x1);
    ods = str2func(char(odsa));
    while(i < iter)
        % Linear search
        mm = CalculateFunctions(df1, vars, x1); 
        opt = x1 - odvar * mm;
        r = ods(func, inter(:,1), inter(:,2), prec, 2*prec, 10, opt, odvar);
        x2 = transpose(x1) - r * rdf2 * transpose(mm) ;
        mm2 = CalculateFunctions(df1, vars, transpose(x2)); 
        diff(x1);
        diff(x2);
        p = transpose(transpose(x2) -x1);
        q = transpose(mm2 - mm);
        rdf2 = rdf2 + (p * transpose(p))/(transpose(p) * q) - (rdf2 * q* transpose(q) * rdf2)/(transpose(q) * rdf2 * q);
        x1 = transpose(x2);
        i = i + 1; 
    end
    y = x2;
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
res = DavidonFletcherPowell(f, vars, init, inter, 10, 10^-5, u, ods);
disp(res);
%}