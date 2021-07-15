# Impact of environment parameters on the plasmid DNA damage induced by ionizing radiation #

This code is a part of master thesis "Impact of environment parameters on the plasmid DNA damage induced by ionizing radiation" written by Klára Stefanová, Faculty of Nuclear Sciences and Physical Engineering at the Czech Technical University in Prague, 2021.

This work was based on publication on article Schuemann J, McNamara AL, Warmenhoven JW, et al. A New Standard DNA Damage (SDD) Data Format. Radiat Res. 2019;191(1):76-92. doi:10.1667/RR15209.1 which presents a new way how to store information about DNA damage. It was developed to store information about DNA damage of the plasmid gained during our Geant4-DNA simulation.

This work is pending publication, therefore at this moment this repository is considered confidential by the authors.

### Prerequistes ###

The code is provided in the form of source code. To run the code a computer with Matlab software is needed. The code has been tested with versions 2020a and 201(5/6)b on a Windows system.

Detailed instructions how to get a Matlab software is described on [Matlab webside](https://www.mathworks.com/products/matlab.html).

## breaks_data ##

The brakes_data.m is an application which can identify and store DNA damage of plasmid in accordance with New Standard DNA Damage (SDD) Data Format.

To run this application you must go to the file where your code is saved, for example (~/Documents/).

The lines starting with % are comments.

```
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
```

This part of the code is meant to be changed by a user. Following data can be modified:

* Scan... output file from Geant4-DNA application with information about hits of plasmid DNA by ionizing radiation or products of radiolysis of water. For further information about this file see the master thesis.

* mac... input file for Geant4-DNA application with information about simulation characteristics, for example energy of primary particle. For further information about this file see the master thesis.

* edep... output file from Geant4-DNA application with energy deposit in Bounding volume from each particle. For further information about this file see the master thesis.

* output... output file from Geant4-DNA application with information about simulation geometry. Use of it is optional.

* plasmid... file with positions of base pairs of plasmid.

* dist... maximum distance between two breaks of opposite DNA strands to become one double strand break.

```
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
```

This part of code is where the DNA damage of plasmid is identified. Following scripts are used:

* sort_breaks... this script goes throw the ouput file and locates hits on plasmid and their origin - direct or indirect.

* compute_breaks... this script can tell from location of hits which type of DNA damage they cause: SSB, SSB+, DSB or complex DNA damage and what the location and origin of this damage.

```
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
```

In this part of code output file in SDD format is generated.

### Contacts ###
If you have any comments or suggestions, we'll be glad to hear them.

Klára Stefanová, stefakla@fjfi.cvut.cz

Václav Štěpán, stepan@ujf.cas.cz
