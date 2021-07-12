function rltFuncLag
    global axes1 comp gnum gden cnum cden hnum hden cCk Mp T5
    s = %s;
    Ess = evstr(x_mdialog(['Entre com Erro de Regime Estacionário desejado'],'ESS','0.001')(1));
    execstr(msprintf('G = clean(syslin(''c'',(%s)*(%s)*(%s),(%s)*(%s)*(%s)));',cnum,gnum,hnum,cden,gden,hden));    
    if messagebox(['Pressione Gráfico para Escolher um ponto no Grafico';...
                   'Ou Manual para digitar um valor de Zero ?'],...
                   'modal', 'info', ['Gráfico' 'Manual']) == 2 then
        sig = x_mdialog(['Entre com o Zero do Compensador'],'Zero do Compensador','');
        if(sig==[])
            return
        else
            Z = -1* evstr(sig(1));
        end
    else
        Z = -1*locate(1)(1);
    end
    cnum = rtlFuncFactorForm(clean(evstr(cnum)*(s+Z)));
    set('eCNum','String',cnum);     
    kv = horner(s*(G/(1+G)),0);
    P = Ess*Z*kv;
    cden = rtlFuncFactorForm((clean(evstr(cden)*(s+P))));
    set('eCDen','String',cden);     
    //Ct = syslin ('c',(s+Z),(s+P));//Compensador de Atraso de Fase
endfunction
