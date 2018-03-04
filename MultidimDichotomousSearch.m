%% Dichotomous Search to be used in another opt. method as ODSA %%
% func: Symbolic function
% a: Lowerbound
% b: Upperbound
% p: Max precision interval
% e: Precision
% r: Number of iterations
% t: Equation of symbolic input
% u: Symbolic input

function t = MultidimDichotomousSearch(func, a, b, p, e, iter, t, u)

    m = mat2cell(t,1,ones(1,numel(t)));
    r = func(m{:});
    z = matlabFunction(r,'vars', u); 
    
    i = 1;
    a1 = a;
    b1 = b;
    while abs(b1-a1) > p && i < iter
       x = ((a1+b1)/2) - e;
       y = ((a1+b1)/2) + e ;
       
       if(z(x) < z(y))
          b1 = y;
       else
          a1 = x;
       end
       i = i + 1;
       p = (b-a)/(2^i) + 2*e*(1 - (1/2^i));
    end

    t = (a1+b1)/2;
    
end


%{
Example usage

syms x y e
f = @(x, y) 0.7*x^4 - 8*x^2 + 6*y^2 + cos(x*y) - 8*x;

u = [e];
o = [1 2] + e*[4 5];


y = MultidimDichotomousSearch(f,-0.5, 0.5, 2*10^-5, 10^-5, 50, o, u);
disp(y);
%}
