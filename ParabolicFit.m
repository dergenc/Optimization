%% Quadratic Interpolation in 1-dim %%

syms x
f = @(x) -5*x^5 + 4*x^4 - 12*x^3 + 11*x^2 - 2*x + 1;

u = [x];

y = qi(f, -0.5, 0.5, 10^-5, 30, u);
disp(y);

function t = qi(func, a, b, p, iter, vars)
    i = 1;
    x1 = a;
    x2 = b;
    dff = df(func, vars);
    x3 = 0;
    while (abs(x1-x2) > p) && (i < iter)
       df1 = calc_df(dff, vars, x1);
       df2 = calc_df(dff, vars, x2);

       x3 = x1 - (x1-x2)*df1/(df1-df2);
  
       if(func(x1) < func(x2))
          x1 = x3;
       else
          x2 = x3;
       end
       i = i + 1;
       
       
    end
    t = x3;
end

function y = df(func, v)
    dif = [];
    res = [];
    if isvector(v)
        for i=1:length(v)
            temp = func;
            t = diff(temp, v(i));
            dif = [dif t];
        end
    end
    y = dif;
end

function y = calc_df(arr, v, x)
    [row, col] = size(arr);
    res = zeros(row,col);
    for i = 1:row
        for j = 1:col
            z = matlabFunction(arr(i,j),'vars',v);   
            l = mat2cell(x,1,ones(1,numel(x)));
            res(i,j) = z(l{:});
        end
    end
    y = res;
end

