function plotEvans()
    global main_fig1 axes sys gnum gden cnum cden hnum hden Mp T5 ganhoEvans 
    delete (axes.children);
    axes.auto_clear = 'off'; //Equivalente ao 'hold off' no Matlab
    s = %s;
    i = %i;
    execstr(msprintf('sys = clean(syslin(''c'',(%s)*(%s),(%s)*(%s)));',cnum,gnum,cden,gden));

    smax = 0.002;
    smin = smax/3;
    nptmax = 2000 //nbre maxi de pt de discretisation en k
    
    kmax = ganhoEvans;
    //Check syntax
    n=clean(sys.num);d=clean(sys.den);
    
    if prod(size(n))<>1 then
        error(msprintf(_("%s: Wrong value for input argument #%d: Single input, single output system expected.\n"),"evans",1));
    end

    if degree(n)<=0 & degree(d)<=0 then
        error(msprintf(_("%s: The given system has no poles and no zeros.\n"),"evans"));
    end

    if kmax<=0 then
        nm=min([degree(n),degree(d)])
        fact=norm(coeff(d),2)/norm(coeff(n),2)
        kmax=round(500*fact),
    end
    //
    //Compute the discretization for "k" and the associated roots
    nroots=roots(n);racines=roots(d);
    if nroots==[] then
        nrm=max([norm(racines,1),norm(roots(d+kmax*n),1)])
    else
        nrm=max([norm(racines,1),norm(nroots,1),norm(roots(d+kmax*n),1)])
    end
    md=degree(d)
    //
    ord=1:md;kk=0;nr=1;k=0;pas=0.99;fin="no";
    klim=gsort(krac2(rlist(n,d,"c")),"g","i")
    ilim=1
    while fin=="no" then
        k=k+pas
        r=roots(d+k*n);r=r(ord)
        dist=max(abs(racines(:,nr)-r))/nrm
        //
        point=%f

        if dist <smax then //pas correct
            if k-pas<klim(ilim)& k>klim(ilim) then,
                k=klim(ilim);
                r=roots(d+k*n);r=r(ord)
            end
            if k>klim(ilim) then ilim=min(ilim+1,size(klim,"*"));end
            point=%t
        else //Too big step or incorrect root order
            // look for a root order that minimize the distance
            ix=1:md
            ord1=[]
            for ky=1:md
                yy=r(ky)
                mn=10*dist*nrm
                for kx=1:md
                    if ix(kx)>0 then
                        if  abs(yy-racines(kx,nr)) < mn then
                            mn=abs(yy-racines(kx,nr))
                            kmn=kx
                        end
                    end
                end
                ix(kmn)=0
                ord1=[ord1 kmn]
            end
            r(ord1)=r
            dist=max(abs(racines(:,nr)-r))/nrm
            if dist <smax then
                point=%t,
                ord(ord1)=ord
            else
                k=k-pas,pas=pas/2.5
            end
        end
        if dist<smin then
            //KToo small step
            pas=2*pas;
        end
        if point then
            racines=[racines,r];kk=[kk,k];nr=nr+1
            if k>kmax then fin="kmax",end
            if nr>nptmax then
                 if messagebox(['Atingido o numero maximo de Discretização !!';...
                                 'Deseja Continuar?';],...
                                 'modal', 'info', ['Yes' 'No']) == 2 then
                    fin="nptmax";
                else
                    nptmax = nptmax+20000;
                end
            end
        end
    end

    //draw the axis
    x1 =[nroots;matrix(racines,md*nr,1)];
    [xmin, xmax] = (min(real(x1)), max(real(x1)));
    [ymin, ymax] = (min(imag(x1)), max(imag(x1)));
    dx = abs(xmax-xmin)*0.05;
    dy = abs(ymax-ymin)*0.05;
    if dx<1d-10, dx = 0.01, end

    [legs, lstyle, lhandle] = ([],[],[]);
    rect = [xmin-dx; ymin-dy ;xmax+dx; ymax+dy];

    immediate_drawing = main_fig1.immediate_drawing;
    main_fig1.immediate_drawing = "off";
    data_bounds = rect([1 3 2 4]);
    axes.axes_visible="on";
    axes.clip_state = "clipgrf";

    title("Evans root locus", "fontsize",2);
    xlabel("Real axis");
    ylabel("Imaginary axis");

    if nroots<>[] then
        xpoly(real(nroots),imag(nroots))
        e = gce();
        e.line_mode = "off";
        e.mark_mode = "on";
        e.mark_size_unit = "point";
        e.mark_size  = 15;
        e.mark_style = 5;
        legs = [legs;"Zeros do Sistema"];
        lhandle = [lhandle; e];
    end

    if racines<>[] then
        xpoly(real(racines(:,1)),imag(racines(:,1)))
        e = gce();
        e.line_mode = "off";
        e.mark_mode = "on";
        e.mark_size_unit = "point";
        e.mark_size  = 7;
        e.mark_style = 2;
        legs = [legs;"Polos do Sistema"];
        lhandle = [lhandle; e];
    end

    dx = max(abs(xmax-xmin),abs(ymax-ymin));
    //plot the zeros locations
    //computes and draw the asymptotic lines
    m = degree(n);
    q = md - m
    if q>0 then
        la = 0:q-1;
        so = (sum(racines(:,1))-sum(nroots))/q
        i1 = real(so);i2=imag(so);
        if prod(size(la))<>1 then
            ang1=%pi/q*(ones(la)+2*la)
            x1=dx*cos(ang1),y1=dx*sin(ang1)
        else
            x1=0,y1=0,
        end
        if md==2,
            if coeff(d,md)<0 then
                x1= zeros(2),y1= zeros(2)
            end,
        end;
        if max(k)>0 then
            col = color("grey50");
            xpoly(i1,i2);
            e = gce();
            e.foreground = col;
            legs = [legs;"asymptotic directions"]
            lhandle = [lhandle; e];
            axes.clip_state = "clipgrf";
            for i = 1:q
                xsegs([i1,x1(i)+i1],[i2,y1(i)+i2])
                gce().segs_color = col;
            end
            //      axes.clip_state = "off";
        end
    end;

    [n1,n2]=size(racines);

    // assign the colors for each root locus
    cmap = main_fig1.color_map;
    cols = 1:size(cmap,1);
    if axes.background==-2 then
        cols(and(cmap==1,2))=[]; //remove white
    elseif axes.background==-1 then
        cols(and(cmap==0,2))=[]; //remove black
    else
        cols(axes.background)=[];
    end
    cols = cols(modulo(0:n1-1,size(cols,"*"))+1);

    //draw the root locus
    xpolys(real(racines)', imag(racines)',cols)
    //set info for datatips
    E=gce();
    for k=1:size(E.children,"*")
        E.children(k).display_function = "formatEvansTip";
        E.children(k).display_function_data = kk;
        datatipManagerMode(E.Children(k),'off');
    end
    c = captions(lhandle,legs($:-1:1),"lower_caption")
    c.background = axes.background;
 
    axes.data_bounds = data_bounds;
    main_fig1.immediate_drawing = immediate_drawing;

    if fin=="nptmax" then
        x_dialog(msprintf("%s: Curve truncated to the first %d discretization points.\n","evans",nptmax));
    end

    // Post-tuning graphical elements
    (axes.children)(2).children.thickness = 2; 
    [zetamf, wnmf, wdmf, sigmamf] = pontoDesejado(Mp, T5);    

    // Sinalizando a região desejada para a operação no LGR
    plot(axes,[-sigmamf -sigmamf],[wdmf -wdmf], '*b');
    deff('y = asymptotes1(x)','y = (wdmf*x)/sigmamf');
    t=[0:-1:axes.data_bounds(1)];
    plot(axes,[t t],[-asymptotes1(t) asymptotes1(t)]);
    deff('x = asymptotes2(y)','x = -sigmamf*ones(1,length(y))');
    y=[[-wdmf:((2*wdmf)/10):wdmf] wdmf];
    plot(axes,asymptotes2(y),y);     
    sgrid('red');

endfunction
