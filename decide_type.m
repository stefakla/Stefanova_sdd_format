function [ssb,ssbp,dsb,compl] = decide_type(ssb,ssbp,dsb,compl,count1,count2)
switch count1
    case 0
        switch count2
            case 0
                disp('no breaks')
            case 1
                ssb = ssb+1;
            otherwise
                ssbp = ssbp+1;
        end
    case 1
        switch count2
            case 0
                ssb = ssb+1;
            case 1
                dsb = dsb+1;
            otherwise
                compl = compl+1;
        end
    otherwise
        if count2==0
            ssbp = ssbp+1;
        else
            compl = compl+1;
        end
end