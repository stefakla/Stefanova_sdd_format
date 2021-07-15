function [S1,S2,S1_orig,S2_orig] = compute_ssd_phys(breaks,origin,plasmid_l,prim)
S1 = zeros(plasmid_l,1);
S2 = zeros(plasmid_l,1);
S1_orig = -1*ones(plasmid_l,1);
S2_orig = -1*ones(plasmid_l,1);
for a=1:prim
    j = 1;
    % registration of strand breaks on S1
    while breaks(2*a-1,j)~=0
        if origin(2*a-1,j)~=1
            b = breaks(2*a-1,j);
            S1(b,1) = S1(b,1)+1;
            S1_orig(b,1) = 0;
        end
        j = j+1;
    end
    j = 1;
    % registration of strand breaks on S2
    while breaks(2*a,j)~=0
        if origin(2*a,j)~=1
            b = breaks(2*a,j);
            S2(b,1) = S2(b,1)+1;
            S2_orig(b,1) = 0;
        end
        j = j+1;
    end
end
S1(S1>0) = 1;
S2(S2>0) = 1;