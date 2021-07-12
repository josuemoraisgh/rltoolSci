function rltool(varargin)
    global axes sys gnum gden cnum cden cCk hnum hden Mp T5 ganhoEvans ti dt tf
    s = %s;
    ti = '0'; 
    dt = '0.1';
    tf = '100';
    cCk = '1';
    cnum='1';
    cden='1';
    gnum='1';
    gden='s';
    hnum='1';
    hden='1';
    Mp = 5.0;
    T5 = 0.1;
    ganhoEvans = 1000;   
    comp = syslin('c',1,1);
    sys = syslin('c',1,s);
    select argn(2)
        case 1 then
            gnum = rtlFuncFactorForm(varargin(1));        
        case 2 then
            gnum = rtlFuncFactorForm(varargin(1));
            gden = rtlFuncFactorForm(varargin(2));
        case 3 then
            gnum = rtlFuncFactorForm(varargin(1));            
            gden = rtlFuncFactorForm(varargin(2));
            Mp  = varargin(3);
        case 4 then
            gnum = rtlFuncFactorForm(varargin(1));            
            gden = rtlFuncFactorForm(varargin(2));
            Mp  = varargin(3);
            T5  = varargin(4);
        case 5 then
            gnum = rtlFuncFactorForm(varargin(1));            
            gden = rtlFuncFactorForm(varargin(2));
            Mp  = varargin(3);
            T5  = varargin(4);
            ganhoEvans  = varargin(5);            
    end
    if isempty(gnum) then
        gnum='1';
        gden='s';
    else
        if isempty(gden) then
           gden='1';
        end
    end
    [zetamf, wnmf, wdmf, sigmamf] = pontoDesejado(Mp, T5)
    // Construção Gráfica
    rltGuiEvans();
    rltGuiConfig();
endfunction
