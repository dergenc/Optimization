%% Multivariate Newton's Method %%
% func: Cost function
% vars: Variables of cost function
% init: Initial values
% inter: Interval for ODSA
% iter: Maximum iterations
% prec: Result precision
% odvar: ODSA symbolic variable
% odsa: ODSA algorithm for step size
%{
syms x y e

f = @(x, y) 0.7*x^4 - 8*x^2 + 6*y^2 + cos(x*y) - 8*x;
vars = [x y];

init = [-3.14 3.14];
inter = [-3.14, 3.14];

h = [x^2 - 8*y^2, x - y];
g = [x - 5*y];
%}
syms x1 x2 x3 x4 x5 x6
vars = [x1 x2 x3 x4 x5 x6];
f = @(x1, x2, x3, x4, x5, x6) -(3*x1*exp(-0.1*x1*x6) + 4*x2 + (x3)^2 + 7*x4 + 10/x5 + x6);
g = [
    2 - (2*x1 + x2 + x3 + 3*x4), -10 - (-8*x1 - 3*x2 - 4*x3 + x4 - x5 + x6), -13 - (-2*x1 - 6*x2 - x3 - 3*x4 - x6), -18 - (-x1 - 4*x2 - 5*x3 - 2*x4), sqrt(x5) + x6 - 6, x1 - 20, x2 - 20,x3 - 20,x4 - 20,x5 - 20,x6 - 20, -20 - x1, -20 - x2,-20 - x3,-20 - x4,-20 - x5,-20 - x6   
    ];
h = [x2*x6 - 5, x1/x2 + (x3^2)*(x4^2) - 1, x1 + x2 + x3 + x4 + x5 + x6 - 10];

u = e;
ma = "SteepestDescentMethod";
ods = "MultidimDichotomousSearch";
init = [1 1 1 1 1 1];
inter = [-0.1, 0.1];

algos = [ma, ods];
res = Zoutendijks(f, vars, init, inter, 5, 10^-5, u, g, h, algos);
disp(res);


function y = Zoutendijks(func, vars, init, inter, iter, prec, odvar, ineq, eq, algos)
    df1 = Differentiate(func, vars);
    i = 0;
    x1 = init;
    x2 = x1;
    while i < iter
        % Create new problem to find feasible direction and solve it using
        % Penalty method
        
        ff = CalculateFunctions(df1, vars, x1);
        pr = symfun(ff * transpose(vars), vars);
        d = PenaltyMethod(pr, vars, x1, inter, iter, prec, odvar, ineq, eq, algos);

        if ff * transpose(d) < prec
            disp("Cikiyorum");
            break;
        end

        % Linear search
        ods = str2func(char(algos(2)));
        mm = -CalculateFunctions(df1, vars, x1); 
        opt = x1 + odvar * mm;
        r = ods(func, inter(:,1), inter(:,2), prec, 2*prec, 100, opt, odvar);

        x2 = x1 + r  * d;
        %disp("-------------");
        %disp(i);
        %disp(x1);
        %disp(x2);
        x1 = x2;
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
vars = [x y];

init = [-3.14 3.14];
inter = [-3.14, 3.14];

u = e;
ods = str2func("MultidimFibonacciSearch");
res = NewtonsMethod(f, vars, init, inter, 10, 10^-5, u, ods);
disp(res);
%}


