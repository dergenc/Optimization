%% Differentiation for multivariate symbolic functions %%

function y = Differentiate(func, vars)
    len = length(vars);
    dif = sym(zeros(1,len));
    if isvector(vars)
        for i=1:len
            temp = func;
            t = diff(temp, vars(i));
            cast_t = symfun(t, vars);
            dif(i) = cast_t;
        end
    end
    y = dif;
end