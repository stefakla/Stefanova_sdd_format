function data_list=data_section(origin,edges,plasmid,plasmid_l)
[~,n] = size(origin);
for a=1:n
    if edges(a,1)==edges(a,2)
        center = edges(a,1);
    else
        if edges(a,3)==1 && edges(a,1)~=1
            b = plasmid_l-edges(a,2)-1;
            center = round(b+0.5*(edges(a,1)-b));
            if center<0
                center = center+plasmid_l+1;
            elseif center==0
                center = 1;
            end
        else
            center = round(edges(a,1)+0.5*(edges(a,2)-edges(a,1)));
        end
    end
    % disp(plasmid(center,:))
    if edges(a,3)==1 && edges(a,1)~=1
        data_list{a,1} = [num2str(plasmid(center,1)),', ',num2str(plasmid(center,2)),...
            ', ',num2str(plasmid(center,3)),', ',num2str(plasmid(edges(a,2),1)),...
            ', ',num2str(plasmid(edges(a,2),2)),', ',num2str(plasmid(edges(a,2),3)),...
            ', ',num2str(plasmid(edges(a,1),1)),', ',num2str(plasmid(edges(a,1),2)),...
            ', ',num2str(plasmid(edges(a,1),3)),'; ',num2str(origin(a)),';'];
    else
        data_list{a,1} = [num2str(plasmid(center,1)),', ',num2str(plasmid(center,2)),...
            ', ',num2str(plasmid(center,3)),', ',num2str(plasmid(edges(a,1),1)),...
            ', ',num2str(plasmid(edges(a,1),2)),', ',num2str(plasmid(edges(a,1),3)),...
            ', ',num2str(plasmid(edges(a,2),1)),', ',num2str(plasmid(edges(a,2),2)),...
            ', ',num2str(plasmid(edges(a,2),3)),'; ',num2str(origin(a)),';'];
    end
end