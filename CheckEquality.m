% Checks if an equality satisfied
% g: Equality in form g = 0
% x: Variable value(s)
% v: Variable(s)

function y = CheckEquality(h, x, v)
    res = 1;
    if isvector(h)
        for i=1:length(h)
            z = matlabFunction(h(i) ,'vars',v);   
            l = mat2cell(x,1,ones(1,numel(x)));
            r = z(l{:});
            res = res && (r < 10^-5 && r > -10^-5);
        end
    end 
    y = res;
end