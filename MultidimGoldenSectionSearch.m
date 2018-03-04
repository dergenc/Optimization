%% Golden Section Search to be used in another opt. method as ODSA %%
% func: Symbolic function
% l: Lowerbound
% h: Upperbound
% e: Precision
% e2: Dummy parameter for convention
% max_iter: Number of iterations
% t: Equation of symbolic input
% u: Symbolic input

function t = MultidimGoldenSectionSearch(func, l, h, e, e2, max_iter, t, u)
    m = mat2cell(t,1,ones(1,numel(t)));
    r = func(m{:});
    z = matlabFunction(r,'vars', u); 
    g = ((sqrt(5) - 1)/2);
    x1 = l + (1 - g)*(h - l);
    x2 = l + g*(h - l);
    i = 0;
    while abs(h - l) > e && i < max_iter
        if z(x1) > z(x2)
            l = x1;
            x1 = x2;
            x2 = l + g*(h - l);
        else
            h = x2;
            x2 = x1;
            x1 = l + (1 - g)*(h - l);
        end
        i = i + 1;
    end
    disp(i);
    t = (l + h)/2;
end

%{
Example usage

syms x y e
f = @(x, y) 0.7*x^4 - 8*x^2 + 6*y^2 + cos(x*y) - 8*x;

u = [e];
o = [1 2] + e*[4 5];

res = MultidimGoldenSectionSearch(f, -0.5, 0.5, 10^-5, 50, o, u);
disp(res);
%}