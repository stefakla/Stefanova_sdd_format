function [xs,S1,S2,count1,count2] = check_complex(dist,S1,S2,x,count1,count2)
s1 = 0;
s2 = 0;
poz = x(1);
find_something = (mod([x(2)-dist-1:x(2)+dist-1],length(S1))+1); 
if poz==1
    for b=find_something
        if S1(b,1)==1
            s1 = s1+1;
            count1 = count1+1;
            S1(b,1)=0;
            ps1(s1) = b;
        end
    end
    for c=find_something
        if S2(c,1)==1
            s2 = s2+1;
            count2 = count2+1;
            S2(c,1)=0;
            ps2(s2) = c;
        end
    end
elseif poz==2
    for b=find_something
        if S2(b,1)==1
            s2 = s2+1;
            count2 = count2+1;
            S2(b,1)=0;
            ps2(s2) = b;
        end
    end
    for c=find_something
        if S1(c,1)==1
            s1 = s1+1;
            count1 = count1+1;
            S1(c,1)=0;
            ps1(s1) = c;
        end
    end
end
if ((s1==0) && (s2==0))
    xs = [];
    % disp('prazdno')
else
    if poz==1
        s = 1;
        xs = [0 1];
        if s1~=0
            xs(s,:) = [1 max(ps1)];
            s = s+1;
        end
        if s2~=0
            if length(ps2)==1
                xs(s,:) = [2 ps2];
            else
                xs(s,:) = [2 min(ps2)];
                xs(s+1,:) = [2 max(ps2)];
            end
            % disp(ps2)
        end
    elseif poz==2
        s = 1;
        xs = [0 1];
        if s2~=0
            xs(s,:) = [2 max(ps2)];
            s = s+1;
        end
        if s1~=0
            if length(ps1)==1
                xs(s,:) = [1 ps1];
            else
                xs(s,:) = [1 min(ps1)];
                xs(s+1,:) = [1 max(ps1)];
            end
        end        
    end
end
