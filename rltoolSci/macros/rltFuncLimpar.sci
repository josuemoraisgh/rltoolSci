function rltFuncLimpar
    global axes1 sys comp cnum cden cCk    
    cCk='1';
    cnum='1';
    cden='1';
    set('eCNum','String',cCk);
    set('eCDen','String',cnum);
    set('eCk','String',cden);
    plotEvans(); 
endfunction
