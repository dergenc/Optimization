%% Quadratic Interpolation in 1-dim to be used in another opt. method as ODSA%%
% func: Symbolic function
% l: Lowerbound
% h: Upperbound
% p: Precision
% p2: Dummy parameter for convention
% iter: Number of iterations
% t: Equation of symbolic input
% vars: Symbolic input

function t = MultidimParabolicFit(func, a, b, p, p2, iter, t, vars)
    m = mat2cell(t,1,ones(1,numel(t)));
    r = func(m{:});
    z = matlabFunction(r,'vars', vars); 
    i = 1;
    x1 = a;
    x2 = b;
    dff = Differentiate(z, vars);
   
    x3 = 0;
    while (abs(x1-x2) > p) && (i < iter)
       df1 = CalculateFunctions(dff, vars, x1);
       df2 = CalculateFunctions(dff, vars, x2);
       disp("------");
       disp(i);
       disp(x1);
       disp(x2);
       disp(x3);
       x3 = x1 - (x1-x2)*df1/(df1-df2);
  
       if(z(x1) < z(x2))
          x1 = x3;
       else
          x2 = x3;
       end
       i = i + 1;    
    end
    t = x3;
end


%{
Example usage

syms x y e
f = @(x, y) 0.7*x^4 - 8*x^2 + 6*y^2 + cos(x*y) - 8*x;

u = [e];
o = [1 2] + e*[4 5];

y = qi(f, -0.5, 0.5, 10^-5, 5, o, u);
disp(y);
%}
