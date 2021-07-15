function [ssb,ssbp,dsb,compl,origin,edges] = compute_breaks(S1,S2,S1_orig,S2_orig,dist,plasmid_l)
ssb = 0;
ssbp = 0;
dsb = 0;
compl = 0;
a = 1;
b = 1;
edges = [0 0 0];
origin = 0;
while a<(plasmid_l+1)
    if S1(a,1) == 0
        a = a+1;
    elseif S1(a,1) == 1
        c = 0;
        S1(a,1) = 0;
        if a==1
            c = 1;
        end
        count1 = 1;
        count2 = 0;
        break_orig = -1;
        x = [1 a];
        break_orig = decide_orig(break_orig,x,S1_orig,S2_orig);
        [xs,S1,S2,count1,count2] = check_complex(dist,S1,S2,x,count1,count2);
        [len,~] = size(xs);
        if len~=0
            if len==1
                break_orig = decide_orig(break_orig,xs,S1_orig,S2_orig);
            else
                for s=1:len
                    break_orig = decide_orig(break_orig,xs(s,:),S1_orig,S2_orig);
                end
            end
        end
        x = [x; xs];
        t = 2;
%         while 1
%             if x(t,2)==1
%                 c = 1;
%             end
%             [xs,S1,S2,count1,count2] = check_complex(dist,S1,S2,x(t,:),count1,count2);
%             [len,~] = size(xs);
%             if len~=0
%                 if len==1
%                     break_orig = decide_orig(break_orig,xs,S1_orig,S2_orig);
%                 else
%                     for s=1:len
%                         break_orig = decide_orig(break_orig,xs(s,:),S1_orig,S2_orig);
%                     end
%                 end
%             end
%             x = [x; xs];
%             t = t+1;
%             if t>length(x)
%                 break
%             end
%         end
        [ssb,ssbp,dsb,compl] = decide_type(ssb,ssbp,dsb,compl,count1,count2);
        [d,~] = size(x);
        if d==1
            edges(b,:) = [x(2) x(2) c];
        else
            edges(b,:) = [min(x(:,2)) max(x(:,2)) c];
        end
        origin(b) = break_orig;
        a = a+1;
        b = b+1;
        end
    % disp(a)
end
a = 1;
while a<(plasmid_l+1)
    if S2(a,1) == 0
        a = a+1;
    elseif S2(a,1) == 1
        c = 0;
        S2(a,1) = 0;
        if a==1
            c = 1;
        end
        count1 = 0;
        count2 = 1;
        x = [2 a];
        break_orig = -1;
        break_orig = decide_orig(break_orig,x,S1_orig,S2_orig);
        [xs,S2,count2] = check_ssb(dist,S2,a,count2);
        [len,~] = size(xs);
        if len~=0
            if len==1
                break_orig = decide_orig(break_orig,xs,S1_orig,S2_orig);
            else
                for s=1:len
                    break_orig = decide_orig(break_orig,xs(s,:),S1_orig,S2_orig);
                end
            end
        end
        x = [x; xs];
        t = 2;
%         while 1
%             if x(t,2)==1
%                 c = 1;
%             end
%             [xs,S2,count2] = check_ssb(dist,S2,xs(t,2),count2);
%             [len,~] = size(xs);
%             if len~=0
%                 if len==1
%                     break_orig = decide_orig(break_orig,xs,S1_orig,S2_orig);
%                 else
%                     for s=1:len
%                         break_orig = decide_orig(break_orig,xs(s,:),S1_orig,S2_orig);
%                     end
%                 end
%             end
%             x = [x; xs];
%             t = t+1;
%             if t>length(x)
%                 break
%             end
%         end
        [ssb,ssbp,dsb,compl] = decide_type(ssb,ssbp,dsb,compl,count1,count2);
        [d,~] = size(x);
        if d==1
            edges(b,:) = [x(2) x(2) c];
        else
            edges(b,:) = [min(x(:,2)) max(x(:,2)) c];
        end
        origin(b) = break_orig;
        a = a+1;
        b = b+1;
    end
end