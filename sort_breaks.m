function [S1,S2,S1_orig,S2_orig] = sort_breaks(Scan,plasmid_l,num_par)
S1 = zeros(plasmid_l,1);
S2 = zeros(plasmid_l,1);
S1_orig = -1*ones(plasmid_l,1);
S2_orig = -1*ones(plasmid_l,1);
n = length(Scan{1,1});
for a=2*num_par-1:2*num_par
    strand = Scan{1,1}{a,1};
    if strcmp(strand,'S1:')==1
        b = 1;
        while Scan{1,2*b}(a)~=0
            c = Scan{1,2*b}(a);
            S1(c,1) = S1(c,1)+1;
            if S1(c,1)>1
                if S1_orig(c,1) ~= Scan{1,2*b+1}(a)
                    S1_orig(c,1) = 2;
                end
            else
                S1_orig(c,1) = Scan{1,2*b+1}(a);
            end
            b = b+1;
        end        
    elseif strcmp(strand,'S2:')==1
        b = 1;
        while Scan{1,2*b}(a)~=0
            c = Scan{1,2*b}(a)-plasmid_l;
            S2(c,1) = S2(c,1)+1;
            if S2(c,1)>1
                if S2_orig(c,1) ~= Scan{1,2*b+1}(a)
                    S2_orig(c,1) = 2;
                end
            else
                S2_orig(c,1) = Scan{1,2*b+1}(a);
            end
            b = b+1;
        end
    end
end
S1(S1>0) = 1;
S2(S2>0) = 1;