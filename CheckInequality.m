% Checks if an inequality satisfied
% g: Inequality in form g <= 0
% x: Variable value(s)
% v: Variable(s)

function y = CheckInequality(g, x, v)
    res = 1;
    if isvector(g)
        for i=1:length(g)
            z = matlabFunction(g(i) ,'vars',v);   
            l = mat2cell(x,1,ones(1,numel(x)));
            r = z(l{:});
            res = res && (r <= 0);
        end
    end 
    y = res;
end