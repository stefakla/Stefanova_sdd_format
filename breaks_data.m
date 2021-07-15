%% loading data about simulation and used plasmid
% loading data for pos.txt
clear all
fileID = fopen('pos_puc_200_508_100_2.txt');
Scan = textscan(fileID,'%s%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d%d','Delimiter', ' '); 
fclose(fileID);
% opening mac file
fileID = fopen('m_508_100_2.mac');
mac = textscan(fileID,'%s%s%s%s%s%s%s%s%s%s%s','Delimiter', ' '); 
fclose(fileID);
% loading information from mac file
[particle,energy,time,beam,radius] = load_mac(mac);
% loading energy from output file
edep = dlmread('edep_puc_200_508_100_2.txt');
dim = 0;
move = 0;
% % opening output information file
% fileID = fopen('volume.txt');
% output = textscan(fileID,'%s%s%s%s%s%s%s','Delimiter', ' '); 
% fclose(fileID);
% % characteristics of irradiated volume
% [dim,move,edep] = volume_data(output);
% opening file with centers of base pairs of plasmid
plasmid = dlmread('ekvi_0508.txt');
% characteristics of used plasmids
[plasmid_lenght,plasmid_name,plasmid_weight] = plasmid_analysis(plasmid);
% distance for dsb
dist = 10;
%% analysis of lessions on plasmid
% absorbed dose
edep = edep*1.602*10^(-19);
dose = edep/((4/3)*pi*(radius*10^(-9))^3*997);
% compute strand breaks from one particle
num_par = 388;
[S1,S2,S1_orig,S2_orig] = sort_breaks(Scan,plasmid_lenght,num_par);
% compute and identify damage of plasmid
[ssb,ssbp,dsb,compl,origin,edges] = compute_breaks(S1,S2,S1_orig,S2_orig,dist,...
    plasmid_lenght);
% saving information about lession and absorbed dose
lession = [ssb; ssbp; dsb; compl; dose];
file = 'lession.txt';
dlmwrite(file,lession)
%% generating output file in sdd format
% halflength of World Box
world_rad = 10000000;
% generating file in sdd format
[header_list,data_list] = sdd_generated(dim,particle,energy,1,radius,...
    world_rad,plasmid_lenght,dist,sum(lession),origin,edges,plasmid_name,...
    time,plasmid);
% writing down into text file 
ID = ['sdd_',plasmid_name,'.txt'];
fileID = fopen(ID,'w');
[n,~] = size(header_list);
for l = 1:n
    fprintf(fileID,'%s\n',header_list{l,1});
end
[m,~] = size(data_list);
for a = 1:m
    fprintf(fileID,'%s\n',data_list{a,1});
end
fclose(fileID);