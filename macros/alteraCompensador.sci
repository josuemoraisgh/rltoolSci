function alteraCompensador
    global axes1 sys comp cnum cden cCk
    cCk = get('eCk','String');
    cnum = get('eCNum','String');
    cden = get('eCDen','String');
    if isempty(cnum) || cnum == ' ' then
        cCk='k';
        cnum='1';
        cden='1';
    else
        if isempty(cden) || cden == ' ' then
           cden='1';
        end
    end
    plotEvans(); 
endfunction
