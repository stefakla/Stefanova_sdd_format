function [dim,move,edep] = volume_data(Scan)
[n,~] = size(Scan{1,1});
delky = 'Rozmery';
posun = 'Posun';
e = 'Celkova';
edep = 0;
for a=1:n
    x = Scan{1,1}{a,1};
    if strcmp(x,delky)==1
        dim.x = str2double(Scan{1,5}{a,1});
        dim.y = str2double(Scan{1,6}{a,1});
        dim.z = str2double(Scan{1,7}{a,1});
    elseif strcmp(x,posun)==1
        mov = Scan{1,6}{a,1};
    elseif strcmp(x,e)==1
        if edep<str2double(Scan{1,6}{a,1})
            edep = str2double(Scan{1,6}{a,1});
        end
    end
end
mov = mov(1,2:end-1);
mov = strsplit(mov,',');
move.x = str2double(mov{1,1});
move.y = str2double(mov{1,2});
move.z = str2double(mov{1,3});