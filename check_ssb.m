function [xs,S2,count2] = check_ssb(dist,S2,a,count2)
s2 = 0;
find_something = (mod([a-dist-1:a+dist-1],length(S2))+1); 
for b=find_something
    if S2(b,1)==1
        s2 = s2+1;
        count2 = count2+1;
        S2(b,1)=0;
        ps2(s2) = b;
    end
end
if (s2==0)
    xs = [];
else
    if s2~=0
        xs = [2 max(ps2)];
    end
    
end
