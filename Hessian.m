%% Calculates Hessian matrix of given symbolic function %%
% func: symbolic function
% vars: variables

function y = Hessian(func, vars)
    df2 = Differentiate(func,vars);
    len = length(vars);
    res = sym(zeros(len,len));
    for i=1:len
         for j=1:len
             res(i,j) = diff(df2(i), vars(j));
         end
    end
    y = res;
end