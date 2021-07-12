function rltFuncStep
    global axes1 comp gnum gden cCk cnum cden  hnum hden cCk Mp T5 ti dt tf
    s = %s;
    execstr(msprintf('C = clean(syslin(''c'',(%s),(%s)));',cnum,cden));
    execstr(msprintf('G = clean(syslin(''c'',(%s)*(%s),(%s)));',cCk,gnum,gden));
    execstr(msprintf('H = clean(syslin(''c'',(%s),(%s)));',hnum,hden));
    vt = x_mdialog('Entre com os dados abaixo:',...
        ['Tempo Inicial:   ';'Taxa de variação:';'Tempo Final:     '],...
        [ti;dt;tf]);
    ti = vt(1);
    dt = vt(2);
    tf = vt(3);   
    t = evstr(vt(1)):evstr(vt(2)):evstr(vt(3));
    [y,x] = csim('step',t,C*G/(1+C*G*H));
    plt = figure();
    plot(plt.children,t,y,'-r');
endfunction
