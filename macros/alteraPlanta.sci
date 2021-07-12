function alteraPlanta
    global axes1 sys comp gnum gden
    gnum = get('eGNum','String');
    gden = get('eGDen','String');
    if isempty(gnum) || gnum == ' ' then
        gnum='1';
        gden='s';
    else
        if isempty(gden) || gden == ' ' then
           gden='1';
        end
    end
    plotEvans();   
endfunction
