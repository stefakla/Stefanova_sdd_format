function break_orig = decide_orig(break_orig,xs,S1_orig,S2_orig)
if xs(1)==1
    S = S1_orig;
elseif xs(1)==2
    S = S2_orig;
end
switch break_orig
    case -1
        break_orig = S(xs(2));
    case 0
        if S(xs(2))==0
            break_orig = 0;
        elseif (S(xs(2))==1) || (S(xs(2))==2)
            break_orig = 2;
        end
    case 1
        if S(xs(2))==1
            break_orig = 1;
        elseif (S(xs(2))==0) || (S(xs(2))==2)
            break_orig = 2;
        end
%     case 2
%         break_orig = 2;
end