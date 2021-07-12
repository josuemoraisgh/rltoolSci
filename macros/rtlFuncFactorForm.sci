function str = rtlFuncFactorForm(varargin)
    isConst = %F;
    select type(varargin(1)),
        case 1 then
            isConst = %T;
            str = string(varargin(1));
        case 2 then r = roots(varargin(1)),
        else 
            if type(evstr(varargin(1))) == 1 then
                isConst = %T;
                str = varargin(1);
            else
                r = roots(evstr(varargin(1)));
            end
    end
    if isConst == %F then
        if length(r)>0 then
            if r(1) == 0 then
                str = 's';
            else
                if r(1) < 0 then
                    str = '(s+'+string(-1*r(1))+')';
                else
                    str = '(s-'+string(r(1))+')';
                end
            end
        else
            str = '';
        end
        for i=2:length(r)
            if r(i) == 0 then
                str = 's*'+str;
            else
                if r(i) < 0 then
                    str = str+'*(s+'+string(-1*r(i))+')';
                else
                    str = str+'*(s-'+string(r(i))+')';
               end
            end
       end
    end
endfunction
