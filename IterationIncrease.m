function y = IterationIncrease()
    prompt = {'Number of more iterations: (If not desired, leave as 0)'};
    dlg_title = 'Iterations over';
    num_lines = 1;
    defaultans = {'0'};
    ans = inputdlg(prompt,dlg_title,num_lines,defaultans);
    y = str2num(char(cellstr(ans)));
end