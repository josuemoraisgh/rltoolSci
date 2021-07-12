function alteraPontoDesejado
    global main_fig1 axes Mp T5
    str = get('eMp','String');
    if ~isempty(str) then
        Mp = strtod(str);
        set('tMp','String','Mp = '+str+' %');
        set('eMp','String','');// set to a dummy character        
    end
    str = get('eT5','String');
    if ~isempty(str) then
        T5 = strtod(str);
        set('tT5','String','t5% = '+str+' s');
        set('eT5','String','');// set to a dummy character        
    end    
    [zetamf, wnmf, wdmf, sigmamf] = pontoDesejado(Mp, T5);
    set('tZetaWn','String','${\zeta = '+string(zetamf)+',\,\,\,\,\omega n = '+string(wnmf)+'}$');
    set('tRDese','String','${(grafico\,\,*)\,\,s = -'+string(sigmamf)+' \pm j*'+string(wdmf)+'}$');
    
    plotEvans();
endfunction
