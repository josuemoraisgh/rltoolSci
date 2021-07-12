function rltGuiEvans()
    global main_fig1 axes sys gnum gden cnum cden hnum hden Mp T5 ganhoEvans 
    main_fig1 = figure('layout', 'gridbag',...//plotGraph = createWindow();
           'toolbar', 'figure',...
           'menubar', 'figure',...
           'axes_size',[700,550],...
           'backgroundcolor', [1 1 1],...
           'visible','off',..
           'tag','main_fig1');
    axes = gca();
    dimensaoTela = get(0, "screensize_px");
    dimensaoFig = get(main_fig1,'figure_size');
    set(main_fig1,'figure_position',..
                   [((dimensaoTela(1)+dimensaoTela(3))/2)-165;...
                    (dimensaoTela(2)+dimensaoTela(4)-dimensaoFig(2))/2]);//Coloca o tela no centro do monitor

    main_fig1.visible = 'on'; 
    plotEvans();   
endfunction
