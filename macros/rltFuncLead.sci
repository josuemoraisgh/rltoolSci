function rltFuncLead
    global axes1 comp gnum gden cnum cden hnum hden cCk Mp T5
    s = %s;
    txtT5='';
    execstr(msprintf('G = clean(syslin(''c'',(%s)*(%s)*(%s),(%s)*(%s)*(%s)));',cnum,gnum,hnum,cden,gden,hden));
    [zetamf, wnmf, wdmf, sigmamf] = pontoDesejado(Mp, T5);
    smf = -sigmamf + wdmf*%i;//Raizes de Malha Fechada
    //[phi mg] = phasemag(horner(G,smf));
    [G_z G_p G_k] = tf2zp(G); 
    vZ = 0
    for i=1:length(G_z)
        if sigmamf>-(G_z(i)) then
            vZ = vZ+180-atand(wdmf/(sigmamf+G_z(i)));
        else
            vZ = vZ-atand(wdmf/(sigmamf+G_z(i)));
        end
    end
    vP = 0
    for i=1:length(G_p)
        if sigmamf>-(G_z(i)) then
            vZ = vZ+180-atand(wdmf/(sigmamf+G_p(i)));
        else
            vZ = vZ-atand(wdmf/(sigmamf+G_p(i)));
        end
    end
    phi = vZ-vP;
    //phi = 180-ph;   
    if phi<=0 then
        //x_dialog(['Compensador com phi Negativo']);
        phi = -phi;
        P1 = ((sigmamf^2+wdmf^2)*tand(phi))/(wdmf-sigmamf*tand(phi));
        P2 = -(wdmf+sigmamf*tand(phi))/tand(phi);      
        x = poly(0,"x");
        smf = (-log(0.05*sqrt(1-(log(Mp/100)^2)/(%pi^2+log(Mp/100)^2)))/x)*(-1 + (%pi/abs((log(Mp/100))))*%i);
        [G_z G_p G_k] = tf2zp(G); 
        vZ = 1
        for i=1:length(G_z)
            vZ = vZ*(smf-G_z(i));
        end
        vP = 1
        for i=1:length(G_p)
            vP = vP*(smf-G_p(i));
        end
        Y = G_k*vZ/vP;
        TAux = real(roots(log(Mp/100)*imag(Y).num-%pi*real(Y).num));  
        TAux = min(TAux(TAux > 0)); 
        if TAux == [] then TAux = %inf, end;    
        txtT5 = sprintf("Para T5%% > %f;",TAux);
        if tand(phi) > 0  then 
            txtResp = sprintf("Para %f &lt; P &lt; %f;",P2,P1); 
        elseif tand(phi)< 0 then
            txtResp = sprintf("Para %f &lt; P &lt; %f;",P1,P2);
        else    
            txtResp = '';
            x_dialog(['Não é possivel!!';...
                     txtT5]);
        end
        if txtResp <> '' then
            aux = messagebox(['Pressione Gráfico para Escolher um ponto no Grafico';...
                              'Ou Manual para digitar um valor do Polo ?';...
                               txtT5],...
                                      'modal', 'info', ['Gráfico' 'Manual']);
            if aux == 2 then
                if tand(phi)>0 then
                    sig = x_mdialog(['Entre com o Polo do Compensador';...
                                     'fi = '+string(phi);...
                                     txtT5;...
                                     txtResp;],'Polo do Compensador','');
                elseif tand(phi)< 0 then
                    sig = x_mdialog(['Entre com o Polo do Compensador';...
                                     'fi = '+string(phi);...
                                     txtT5;...
                                     txtResp;],'Polo do Compensador','');
                end
                if(sig==[])
                    return
                else
                    P = evstr(sig(1));
                end
            elseif aux == 1 then                
                P = locate(1)(1);
            else
                return
            end
            cden = rtlFuncFactorForm(clean(evstr(cden)*(s-P)));
            set('eCNum','String',cden); 
            Z=(wdmf*P-tand(phi)*(sigmamf^2+P*sigmamf+wdmf^2))/(wdmf+(P+sigmamf)*tand(phi)); 
            cnum = rtlFuncFactorForm((clean(evstr(cnum)*(s-Z))));
            set('eCDen','String',cnum);
            //////////////////////////////////////////////////////////
            //////////////Análise no lugar das raizes/////////////////
            [G_z G_p G_k] = tf2zp(G);  
            dsmfZ = 1
            for i=1:length(G_z)
                dsmfZ = dsmfZ*sqrt((wdmf)^2+(sigmamf+G_z(i))^2);
            end
            dsmfP = 1
            for i=1:length(G_p)
                dsmfP = dsmfP*sqrt((wdmf)^2+(sigmamf+G_p(i))^2);
            end
            cCk=string((dsmfP*sqrt((wdmf)^2+(sigmamf-P)^2))/(G_k*(dsmfZ*sqrt((wdmf)^2+(sigmamf-Z)^2))));
            set('eCk','String',cCk);
        end
    else
        Z1 = ((sigmamf^2+wdmf^2)*tand(phi))/(wdmf-sigmamf*tand(phi));
        Z2 = -(wdmf+sigmamf*tand(phi))/tand(phi);      
        x = poly(0,"x");
        smf = (-log(0.05*sqrt(1-(log(Mp/100)^2)/(%pi^2+log(Mp/100)^2)))/x)*(-1 + (%pi/abs((log(Mp/100))))*%i);
        [G_z G_p G_k] = tf2zp(G); 
        vZ = 1
        for i=1:length(G_z)
            vZ = vZ*(smf-G_z(i));
        end
        vP = 1
        for i=1:length(G_p)
            vP = vP*(smf-G_p(i));
        end
        Y = G_k*vZ/vP;
        TAux = real(roots(log(Mp/100)*imag(Y).num-%pi*real(Y).num));  
        TAux = min(TAux(TAux > 0)); 
        if TAux == [] then TAux = %inf, end;    
        txtT5 = sprintf("Para T5%% > %f;",TAux);
        if tand(phi) > 0  then 
            txtResp = sprintf("Para %f &lt; Z &lt; %f;",Z2,Z1); 
        elseif tand(phi)< 0 then
            txtResp = sprintf("Para %f &lt; Z &lt; %f;",Z1,Z2);
        else    
            txtResp = '';
            x_dialog(['Não é possivel!!';...
                     txtT5]);
        end
        if txtResp <> '' then
            aux = messagebox(['Pressione Gráfico para Escolher um ponto no Grafico';...
                              'Ou Manual para digitar um valor de Zero ?';...
                               txtT5],...
                                      'modal', 'info', ['Gráfico' 'Manual']);
            if aux == 2 then
                if tand(phi)>0 then
                    sig = x_mdialog(['Entre com o Zero do Compensador';...
                                     'fi = '+string(phi);...
                                     txtT5;...
                                     txtResp;],'Zero do Compensador','');
                elseif tand(phi)< 0 then
                    sig = x_mdialog(['Entre com o Zero do Compensador';...
                                     'fi = '+string(phi);...
                                     txtT5;...
                                     txtResp;],'Zero do Compensador','');
                end
                if(sig==[])
                    return
                else
                    Z = evstr(sig(1));
                end
            elseif aux == 1 then                
                Z = locate(1)(1);
            else
                return
            end
            cnum = rtlFuncFactorForm(clean(evstr(cnum)*(s-Z)));
            set('eCNum','String',cnum); 
            P=(wdmf*Z-tand(phi)*(sigmamf^2+Z*sigmamf+wdmf^2))/(wdmf+(Z+sigmamf)*tand(phi)); 
            cden = rtlFuncFactorForm((clean(evstr(cden)*(s-P))));
            set('eCDen','String',cden);
            //////////////////////////////////////////////////////////
            //////////////Análise no lugar das raizes/////////////////
            [G_z G_p G_k] = tf2zp(G);  
            dsmfZ = 1
            for i=1:length(G_z)
                dsmfZ = dsmfZ*sqrt((wdmf)^2+(sigmamf+G_z(i))^2);
            end
            dsmfP = 1
            for i=1:length(G_p)
                dsmfP = dsmfP*sqrt((wdmf)^2+(sigmamf+G_p(i))^2);
            end
            cCk=string((dsmfP*sqrt((wdmf)^2+(sigmamf-P)^2))/(G_k*(dsmfZ*sqrt((wdmf)^2+(sigmamf-Z)^2))));
            set('eCk','String',cCk);
       end
    end
    plotEvans();
endfunction
