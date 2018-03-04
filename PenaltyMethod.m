%% Penalty Method %%
% func: Cost function
% vars: Variables of cost function
% init: Initial values
% inter: Interval for ODSA
% iter: Maximum iterations
% prec: Result precision
% odvar: ODSA symbolic variable

function y = PenaltyMethod(func, vars, init, inter, iter, prec, odvar, ineq, eq, algos)

    % Exterior function for penalty cost
    function y = exterior(g)
        temp = 0;
        if isvector(g)
            for i=1:length(g)
                temp2 = (g(i)^2); % exterior
                temp = temp + temp2;   
            end
        end  
        y = sym(temp);
    end

    function y = exterior_ineq(x)
        temp = 0;
        if isvector(ineq)
            for i=1:length(ineq)
                r = CalculateFunctions(ineq(i), vars, x);
                if r > 0
                   temp2 = (ineq(i)^2); % exterior
                else
                   temp2 = 0;
                end
                temp = temp + temp2;   
            end
        end  
        y = sym(temp);
    end

    main = str2func(char(algos(1))); 
    ods = algos(2);
    x1 = init;
    ext_eq = exterior(eq); % exterior
    ext_ineq = exterior_ineq(x1);
    ext = ext_eq + ext_ineq;
    ff = func + ext;
    ff = symfun(ff, vars);
    
    x2 = transpose(main(ff, vars, x1, inter, iter, prec, odvar, ods));
    f1 = CalculateFunctions(func, vars, x1);
    f2 = CalculateFunctions(func, vars, x2);
    r = 1; % exterior
    i = 0;
    while (((CheckEquality(eq, x2, vars) == 0) && (CheckInequality(ineq, x2, vars) == 0)) || (abs(f2 - f1) > prec)) && i < iter
        r = r * 2; % exterior
        ff = func + r * ext;
        ff = symfun(ff, vars);
        x1 = x2;
        x2 = transpose(main(ff, vars, x1, inter, iter, prec, odvar, ods));
        disp("-----------PENALTY----------");
        disp(i);
        disp(x1);
        disp(x2);
        f1 = f2;
        f2 = CalculateFunctions(func, vars, x2);
        %{
        if i == iter - 2
            it = IterationIncrease();
            i = i - it;
        end
        %}
        
        i = i + 1;
    end
    disp(i);
    y = x2;
end

%{
syms x y e 

f = @(x, y) 0.7*x^4 - 8*x^2 + 6*y^2 + cos(x*y) - 8*x;

v = [x y];
h = [x^2 - 8*y^2, y^2 - 6*x, 3*y^2 -x + y - 3*x*y ];

g = [];

s = [-3.14 3.14];
interval = [-3.14, 3.14];

u = e;

u = PenaltyMethod(f, v, s, interval, 20, 10^-5, u, g, h);
disp(u);
%}