function [header_list,data_list] = sdd_generated(dim,particle,energy,beam,...
    gun_rad,world_rad,plasmid_lenght,dist,lession,origin,edges,plasmid_name,...
    time,plasmid)
Mbps = plasmid_lenght*10^(-6);
% generating header section
header_list = header_section(gun_rad,particle,energy,world_rad,dim,Mbps,dist,...
    beam,lession,time,plasmid_name);
% generating data section
data_list=data_section(origin,edges,plasmid,plasmid_lenght);

