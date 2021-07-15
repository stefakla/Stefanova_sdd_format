function [particle,energy,time,beam,radius] = load_mac(Scan)
[n,~] = size(Scan{1,1});
time = 0;
for a=1:n
    x = Scan{1,1}{a,1};
    if strcmp('/gun/particle',x)==1
        particle = Scan{1,2}{a,1};
    elseif strcmp('/gun/energy',x)==1
        energy = Scan{1,2}{a,1};
        if strcmp(Scan{1,3}{a,1},'MeV')==1
            energy = str2double(energy);
        elseif strcmp(Scan{1,3}{a,1},'keV')==1
            energy = 10^(-3)*str2double(energy);
        elseif strcmp(Scan{1,3}{a,1},'eV')==1
            energy = 10^(-6)*str2double(energy);
        end
    elseif strcmp('/scheduler/endTime',x)==1
        time = Scan{1,2}{a,1};
        if strcmp(Scan{1,3}{a,1},'ps')==1
            time = 10^(-3)*str2double(time);
        elseif strcmp(Scan{1,3}{a,1},'ns')==1
            time = str2double(time);
        end
    elseif strcmp('/run/beamOn',x)==1
        beam = str2double(Scan{1,2}{a,1});
    elseif strcmp('/PDB4DNA/det/setBoundingRadius',x)==1
        radius = str2double(Scan{1,2}{a,1});
    end
end