function [S1,S2,S1_orig,S2_orig] = compute_ssd(breaks,origin,plasmid_l,prim)
S1 = zeros(plasmid_l,1);
S2 = zeros(plasmid_l,1);
S1_orig = -1*ones(plasmid_l,1);
S2_orig = -1*ones(plasmid_l,1);
for a=1:prim
    j = 1;
    % registration of strand breaks on S1
    while breaks(2*a-1,j)~=0
        b = breaks(2*a-1,j);
        S1(b,1) = S1(b,1)+1;
        if S1(b,1)>1
            if S1_orig(b,1) ~= origin(2*a-1,j)
                S1_orig(b,1) = 2;
            end
        else
            S1_orig(b,1) = origin(2*a-1,j);
        end
        j = j+1;
    end
    j = 1;
    % registration of strand breaks on S2
    while breaks(2*a,j)~=0
        b = breaks(2*a,j)-plasmid_l+1;
        S2(b,1) = S2(b,1)+1;
        if S2(b,1)>1
            if S2_orig(b,1) ~= origin(2*a,j)
                S2_orig(b,1) = 2;
            end
        else
            S2_orig(b,1) = origin(2*a,j);
        end
        j = j+1;
    end
end
S1(S1>0) = 1;
S2(S2>0) = 1;