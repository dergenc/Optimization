%% Calculate matrix of symbolic functions for multidimensional diff and hessian matrices %%
% mat: Matrix of functions 
% vars: Variables in functions
% x: Value-vector of variables

function y = CalculateFunctions(mat, vars, x)
    [row, col] = size(mat);
    res = zeros(row,col);

    if(row == 1 && col == 1)
        z = matlabFunction(mat,'vars', vars);   
        l = mat2cell(x,1,ones(1,numel(x))); 
        res = z(l{:});
    else
        for i = 1:row
            for j = 1:col
                z = matlabFunction(mat(i,j),'vars', vars);   
                l = mat2cell(x,1,ones(1,numel(x)));
                res(i,j) = z(l{:});
            end
        end
    end
    y = res;
end
