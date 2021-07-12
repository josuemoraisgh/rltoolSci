function rltFuncSZP
    global axes1 comp gnum gden cnum cden cCk Mp T5
    s = %s;
    execstr(msprintf('G = clean(syslin(''c'',(%s),(%s)));',gnum,gden));
    [zetamf, wnmf, wdmf, sigmamf] = pontoDesejado(Mp, T5);

    smf = -sigmamf + wdmf*%i;//Raizes de Malha Fechada
    //Determinando os polos do compensador
    ppid = -2*sigmamf;
    c = s*(s-ppid)*G.num;
    cden = rtlFuncFactorForm(clean(c));
    set('eCDen','String',cden);
    //Determinando os zeros do compensador
    cnum = rtlFuncFactorForm(clean(G.den));
    set('eCNum','String',cnum);
    //Determinando Kc
    [_ _ Gs_k] = tf2zp(G);
    cCk=string(-(smf*(smf-ppid))/Gs_k);
    set('eCk','String',cCk);
    plotEvans(); 
endfunction
