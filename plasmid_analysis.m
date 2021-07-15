function [n,plasmid_name,plasmid_weight] = plasmid_analysis(plasmid)
[n,~] = size(plasmid);
switch n
    case 350
        plasmid_name = '1ZB';
        plasmid_weight = 10^(-21);
    case 2686
        plasmid_name = 'pUC19';
        plasmid_weight = 2.77169*10^(-21);
    case 4361 
        plasmid_name = 'pBR322';
        plasmid_weight = 4.50035*10^(-21);
end