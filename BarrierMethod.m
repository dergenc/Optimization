%% Barrier Method %%
% func: Cost function
% vars: Variables of cost function
% init: Initial values
% inter: Interval for ODSA
% iter: Maximum iterations
% prec: Result precision
% odvar: ODSA symbolic variable

function y = BarrierMethod(func, vars, init, inter, iter, prec, odvar, ineq, eq, algos)

    function y = centralpath(g, x)
    	temp = 0;
        if isvector(g)
            for i=1:length(g)
                temp2 = -1/g(i); % 
                tr = CalculateFunctions(temp2, vars, x);
                if (tr > 10^-5)
                    temp = temp + temp2;
                end    
            end
        end  
        y = sym(temp);
    end

    main = str2func(char(algos(1))); 
    ods = algos(2);
    x1 = init;    
    ext = centralpath(ineq, x1);
 
    ff = func + ext;
    ff = symfun(ff, vars);
   
    x2 = transpose(main(ff, vars, x1, inter, 10, prec, odvar, ods));
    f1 = CalculateFunctions(ff, vars, x1);
    f2 = CalculateFunctions(ff, vars, x2);
    r = 256; 
    i = 0;
    while ((CheckInequality(ineq, x2, vars) == 0) || (abs(f2 - f1) > prec)) && i < iter
        r = r / 2; 
        ff = func - r * ext;
        ff = symfun(ff, vars); 
        x1 = x2;
        x2 = transpose(main(ff, vars, x1, inter, 10, prec, odvar, ods));
        f1 = f2;
        f2 = CalculateFunctions(ff, vars, x2);
        if i == iter - 2
            it = IterationIncrease();
            i = i - it;
        end
        i = i + 1;
    end
    disp(i);
    y = x2;
end



%{
Example usage

syms x y e

f = @(x, y) 0.7*x^4 - 8*x^2 + 6*y^2 + cos(x*y) - 8*x;
v = [x y];
g = [x^2 - 8*y^2, y^2 - 6*x, 3*y^2 -x + y - 3*x*y ];
h = [];

s = [-3.14 3.14];
interval = [-3.14, 3.14];

u = e;

u = BarrierMethod(f, v, s, interval, 20, 10^-5, u, g);
disp(u);
%}
