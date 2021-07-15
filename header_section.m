function header_list = header_section(gun_rad,particle,energy,world_rad,bound,...
    Mbps,dsb_distance,beam,lession,time,plasmid_name)
if strcmp(particle,'proton') == 1
    particle_pdg = 2212;
elseif strcmp(particle,'gamma') == 1
    particle_pdg = 22;
end
density = Mbps/((4/3)*pi*(gun_rad*10^(-3))^3);
header_list{1,1} = 'SDD, version, SDDv1.0;';
header_list{2,1} = 'Software, Geant4 v10.7;';
header_list{3,1} = ['Author, Klara Stefanova, stefakla@fjfi.cvut.cz, August 2021, ',...
    'master thesis Impact of environment parameters on the plasmid DNA damage ',...
    'induced by ionizing radiation, FNSPE, CTU;'];
header_list{4,1} = ['Simulation details, Simulation of DNA damage of the plasmid,',...
    'using pdb4dna and chem3 and chem6 example, used plasmid: ', plasmid_name,';'];
header_list{5,1} = ['Source, Monoenergetic ',particle,' randomly generated on the ',...
    'surface on the sphere with radius ',num2str(gun_rad),' nm exposing plasmid inside the sphere. ',...
    'Energy: ',num2str(energy),' MeV;'];
header_list{6,1} = 'Source type, 1;';
header_list{7,1} = ['Incident particles, ',num2str(particle_pdg),';'];
header_list{8,1} = ['Mean particle energy, ',num2str(energy),';'];
header_list{9,1} = 'Energy distribution, M,0;';
header_list{10,1} = 'Particle fraction, 1.0;';
header_list{11,1} = 'Dose or fluence, 0;';
header_list{12,1} = 'Dose rate, 0;';
header_list{13,1} = ['Irradiation target, plasmid ',plasmid_name,', supercoiled form;'];
header_list{14,1} = ['Volumes, 0,',num2str(0.001*world_rad),',',num2str(0.001*world_rad),...
    ',',num2str(0.001*world_rad),',0,0,0, 1,',num2str(0.001*gun_rad),',',...
    num2str(0.001*gun_rad),',',num2str(0.001*gun_rad),',0,0,0;'];
header_list{15,1} = ['Chromozome sizes, 1, ',num2str(Mbps),';'];
header_list{16,1} = ['DNA Density, ',num2str(density),';'];
header_list{17,1} = 'Cell Cycle Phase, 0;';
header_list{18,1} = 'DNA Structure, 6, 1;';
header_list{19,1} = 'In vitro / in vivo, 0;';
header_list{20,1} = 'Proliferation status, 0, plasmid is static;';
header_list{21,1} = 'Microenvironment, 20, 0;';
if time==0
    header_list{22,1} = ['Damage definition, 0, 0, ',num2str(dsb_distance),', -1, 8.22;'];
    header_list{23,1} = 'Time, 0;';
elseif time>0
    header_list{22,1} = ['Damage definition, 1, 0, ',num2str(dsb_distance),', -1, 8.22;'];
    header_list{23,1} = ['Time, ',num2str(time),';'];
end
header_list{24,1} = ['Damage and primary count, ',num2str(lession),', ',num2str(beam),';'];
header_list{25,1} = 'Data entries, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0';
header_list{26,1} = 'Additional information, Damage position is scored as a center of damaged base pair;';
header_list{27,1} = '***EndOfHeader***';
header_list{28,1} = ' ';