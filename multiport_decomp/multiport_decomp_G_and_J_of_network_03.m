function [G_n3, J_n3]=  multiport_decomp_G_and_J_of_network_03(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax : [G_n3, J_n3] = multiport_decomp_G_and_J_of_network_03(cktnetlist)
%   
% This function will return the G-matrix and J-matrix of each device element
% of multiport network 03.
% --------------------------------------------------------------------------------
    partition_simple = multiport_decomp_partition_simple(cktnetlist);
    size_of_G = 0 ;
    for i = (partition_simple)
        if (i == 2) 
            size_of_G = size_of_G + 1;
        end
    end
    %size_of_G = length(find(partition_simple));
    G_n3 = zeros(size_of_G, size_of_G);
    J_n3 = zeros(size_of_G, 1);
    index = 1;
    for i = 1: length(cktnetlist.elements)
        if (partition_simple(i) == 2)
            if (~isempty(cktnetlist.elements{i}.parms))
                resistance = cell2mat(cktnetlist.elements{i}.parms);
                G_n3(index,index) = 1/resistance;
                J_n3(index) = 0;
            else 
                G_n3(index,index) = 0;
                J_n3(index) = (cktnetlist.elements{i}.udata{1}.QSSval);
            end
            index = index + 1;
        end
    end


end
