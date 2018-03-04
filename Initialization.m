%% Menu functionalities for input interface %%

function [iter, init, inter, od_iter, prec, cons, min, ods] = Initialization()

    function y = getalgo(algos)

        [s,v] = listdlg('PromptString','Select optimization algorithm:',...
            'SelectionMode','single',...
            'ListString',algos,...
            'Name', 'Algorithms',...
            'ListSize', [200, 160]);
        y = algos(s);
    end

    function y = getfunc()
        prompt = {'Enter function:'};
        dlg_title = 'Function';
        num_lines = 1;
        defaultans = {'x+y'};
        ans = inputdlg(prompt,dlg_title,num_lines,defaultans);
        y = str2sym(ans(1));
    end

    function [x, y, z, t, p] = getparams()
        prompt = {'Number of iterations:','Initial point:', 'Interval for ODSA:', 'Number of iterations for ODSA:', 'Precision:'};
        dlg_title = 'Parameters';
        num_lines = 1;
        %defaultans = {'20','100000 210000 100800 189800 80800 150000 210000 180800 189800 280800 1 0 1 1 0 1 0 1 1 0','-10^6 10^6', '40', '10^-2'};
        DEFAULT_PARAMS = {'10','100000 210000 100800 189800 80800 150000 210000 180800 189800 280800 1 0 1 1 0 1 0 1 1 0','-10^5 10^5', '40', '10^-1'};
        ans = inputdlg(prompt,dlg_title,num_lines,DEFAULT_PARAMS);
        x = input2num(ans(1));
        y = input2num(ans(2));
        z = input2num(ans(3));
        t = input2num(ans(4));
        p = input2num(ans(5));
    end

    function y = input2num(inp)
        y = str2num(char(cellstr(inp)));
    end

    cons = {'Penalty Method', 'Barrier Method'};
    main = {'Steepest Descent Method', 'Newtons Method', 'Fletcher-Reeves Method', 'Davidon-Fletcher-Powell Method'};
    odsa = {'Dichotomous Search', 'Parabolic Fit', 'Fibonacci Search', 'Newtons ODSA'};

    [iter, init, inter, od_iter, prec] = getparams();
    
    %iter = 10;
    %init = [1 1 1 1 1 1];
    %inter = [-0.1 0.1];
    %od_iter = 50;
    %prec = 10^-5;
    cons = getalgo(cons);
    %cons = 'Barrier Method';
    %min = "Steepest Descent Method";
    %ods = 'Golden Section Search';
    min = getalgo(main);
    ods = getalgo(odsa);
    
end


