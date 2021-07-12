function rltool(sys)
    // Construção Gráfica
    dimensaoTela = get(0, "screensize_px");
    main_fig = figure('layout', 'gridbag',...//plotGraph = createWindow();
           'toolbar', 'figure',...
           'menubar', 'figure',...
           'axes_size',[800,600],...
           'backgroundcolor', [1 1 1],...
           'visible','off',..
           'tag','main_fig');
    dimensaoFig = get('main_fig','figure_size');
    set('main_fig','figure_position',..
                   [((dimensaoTela(1)+dimensaoTela(3)-dimensaoFig(1))/2);...
                    ((dimensaoTela(2)+dimensaoTela(4)-dimensaoFig(2))/2)]);//Coloca o tela no centro do monitor
    //A tela terá 3 frames sendo cada um uma linha onde a informação será apresentada
    //Organização da primeira coluna
    c1Frame = uicontrol(main_fig,...
                  'layout', 'gridbag', ...
                  'style', 'frame', ...
                  'tag','c1Frame',..
                  'String','fFigure',...
                  'constraints', createConstraints("gridbag", [1, 1, 1, 1], [0.1, 1], "both"));
    //Inserção da imagem
    
    uicontrol(c1Frame,...
               'HorizontalAlignment','center',...//Orientação do texto deste encapsulamento
               'Style','text',...
               'tag','fFigure',...
               'constraints', createConstraints("gridbag", [1, 1, 1, 1], [1, 0.5],"both","center"), ..
               'String','$\includegraphics{.\Imagens\FeedBackControl0.png}$'); 
    c1Frame.String= 'fFigure';
    datatipManagerMode(main_fig);
    c11Frame = uicontrol(c1Frame,...
               'layout', 'gridbag', ...
               'style', 'frame', ...
               'constraints', createConstraints("gridbag", [1, 2, 1, 1], [1, 1], "both"));
    uicontrol(c11Frame,...
           'HorizontalAlignment','center',..//Orientação do texto deste encapsulamento
           'Style','text',..
           'Margins', [10 10 10 0],..//Cria um espaço em branco [top esquerda abaixo direita]
           'constraints', createConstraints("gridbag", [1, 1, 1, 1], [0.5, 1], "horizontal", "right", [0, 0], [10 35]), ..
           'String','G(s)  =');                  
    uicontrol(c11Frame,...
           'Tag','tPV',..
           'HorizontalAlignment','left',..//Orientação do texto deste encapsulamento
           'Style','edit',..
           'String',string(sys.num),..
           'Margins', [10 0 10 0],..//Cria um espaço em branco [top esquerda abaixo direita]
           'constraints', createConstraints("gridbag", [2, 1, 1, 1], [1, 1], "horizontal", "center")); 
    uicontrol(c11Frame,...
           'HorizontalAlignment','center',..//Orientação do texto deste encapsulamento
           'Style','text',..
           'Margins', [10 0 10 0],..//Cria um espaço em branco [top esquerda abaixo direita]
           'constraints', createConstraints("gridbag", [3, 1, 1, 1], [0.1, 1], "horizontal", "right", [0, 0], [10 35]), ..
           'String','/');            
    uicontrol(c11Frame,...
           'Tag','tPV',..
           'HorizontalAlignment','left',..//Orientação do texto deste encapsulamento
           'Style','edit',..
           'String',string(sys.den),..
           'Margins', [10 0 10 20],..//Cria um espaço em branco [top esquerda abaixo direita]
           'constraints', createConstraints("gridbag", [4, 1, 1, 1], [1, 1], "horizontal", "center"));            
    c12Frame = uicontrol(c1Frame,...
               'layout', 'gridbag', ...
               'style', 'frame', ...
               'constraints', createConstraints("gridbag", [1, 3, 1, 1], [1, 1], "both"));
    uicontrol(c12Frame,...
           'HorizontalAlignment','center',..//Orientação do texto deste encapsulamento
           'Style','text',..
           'Margins', [10 10 10 0],..//Cria um espaço em branco [top esquerda abaixo direita]
           'constraints', createConstraints("gridbag", [1, 1, 1, 1], [0.5, 1], "horizontal", "right", [0, 0], [10 35]), ..
           'String','C(s)  =');                  
    uicontrol(c12Frame,...
           'Tag','tPV',..
           'HorizontalAlignment','left',..//Orientação do texto deste encapsulamento
           'Style','edit',..
           'String','1',..
           'Margins', [10 0 10 0],..//Cria um espaço em branco [top esquerda abaixo direita]
           'constraints', createConstraints("gridbag", [2, 1, 1, 1], [1, 1], "horizontal", "center")); 
    uicontrol(c12Frame,...
           'HorizontalAlignment','center',..//Orientação do texto deste encapsulamento
           'Style','text',..
           'Margins', [10 0 10 0],..//Cria um espaço em branco [top esquerda abaixo direita]
           'constraints', createConstraints("gridbag", [3, 1, 1, 1], [0.1, 1], "horizontal", "right", [0, 0], [10 35]), ..
           'String','/');            
    uicontrol(c12Frame,...
           'Tag','tPV',..
           'HorizontalAlignment','left',..//Orientação do texto deste encapsulamento
           'Style','edit',..
           'String','1',..
           'Margins', [10 0 10 20],..//Cria um espaço em branco [top esquerda abaixo direita]
           'constraints', createConstraints("gridbag", [4, 1, 1, 1], [1, 1], "horizontal", "center"));                 
    c22Frame = uicontrol(c1Frame,...
               'layout', 'gridbag', ...
               'style', 'frame', ...
               'constraints', createConstraints("gridbag", [1, 4, 1, 1], [1, 1], "both")); 
    uicontrol(c22Frame,...
           'HorizontalAlignment','center',..//Orientação do texto deste encapsulamento
           'Style','text',..
           'Margins', [10 10 10 0],..//Cria um espaço em branco [top esquerda abaixo direita]
           'constraints', createConstraints("gridbag", [1, 1, 1, 1], [0.5, 1], "horizontal", "right", [0, 0], [10 35]), ..
           'String','H(s)  =');                  
    uicontrol(c22Frame,...
           'Tag','tPV',..
           'HorizontalAlignment','left',..//Orientação do texto deste encapsulamento
           'Style','edit',..
           'String','1',..
           'Margins', [10 0 10 0],..//Cria um espaço em branco [top esquerda abaixo direita]
           'constraints', createConstraints("gridbag", [2, 1, 1, 1], [1, 1], "horizontal", "center")); 
    uicontrol(c22Frame,...
           'HorizontalAlignment','center',..//Orientação do texto deste encapsulamento
           'Style','text',..
           'Margins', [10 0 10 0],..//Cria um espaço em branco [top esquerda abaixo direita]
           'constraints', createConstraints("gridbag", [3, 1, 1, 1], [0.1, 1], "horizontal", "right", [0, 0], [10 35]), ..
           'String','/');            
    uicontrol(c22Frame,...
           'Tag','tPV',..
           'HorizontalAlignment','left',..//Orientação do texto deste encapsulamento
           'Style','edit',..
           'String','1',..
           'Margins', [10 0 10 20],..//Cria um espaço em branco [top esquerda abaixo direita]
           'constraints', createConstraints("gridbag", [4, 1, 1, 1], [1, 1], "horizontal", "center"));  
    //Organização da segunda coluna
    c2Frame = uicontrol(main_fig,...
                  'layout', 'gridbag', ...
                  'style', 'frame', ...
                  'constraints', createConstraints("gridbag", [2, 1, 1, 1], [1, 1], "both"));
    main_fig.visible = 'on';
    axes = newaxes(c2Frame);  
    axes.auto_clear = 'off'; //Equivalente ao 'hold on' no Matlab
    sca(axes)
    evans(sys,1000);
    sgrid('red');
    datatipManagerMode(gcf);
    // Post-tuning graphical elements
    (axes.children)(2).children.thickness = 2; 
endfunction

function Auto
    global axes Gt t y u;
    set('bManual','Enable','on');
    set('bAuto','Enable','off'); 
    set('tSP','Enable','on');
    set('tMV','Enable','off');    
endfunction

function Manual
    set('bManual','Enable','off');
    set('bAuto','Enable','on');  
    set('tSP','Enable','off');
    set('tMV','Enable','on');       
endfunction
