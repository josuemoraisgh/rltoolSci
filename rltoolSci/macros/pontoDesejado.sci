function [zetamf, wnmf, wdmf, sigmamf] = pontoDesejado(Mp, T5)
    //Mp=exp(-pi*(zeta/sqrt(1-zeta^2)))
    zetamf = abs(log(Mp/100))/((%pi^2)+(log(Mp/100))^2)^(1/2);
    //T5 = 3/(wn*zeta)
    wnmf = 3/(T5*zetamf);//wn
    //Polos malha fechada Smf = -(zeta*wn)+/- i(wn*sqrt(1-zeta^2))
    wdmf = (wnmf*sqrt(1-zetamf^2));
    sigmamf = zetamf*wnmf;
endfunction
