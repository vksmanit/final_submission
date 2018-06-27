function [G_n1, J_n1]=  multiport_decomp_G_and_J_of_network_01(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax : [G_n1, J_n1] = multiport_decomp_G_and_J_of_network_01(cktnetlist)
%   
% This function will return the G-matrix and J-matrix of each device element
% of multiport network 01.
% --------------------------------------------------------------------------------
    %%%%% partition_simple can be patition in more general or can be hardcoded %%%%%
    partition_simple = multiport_decomp_partition_simple(cktnetlist);
    size_of_G = 0 ;
    for i = (partition_simple)
        if (i == 0) 
            size_of_G = size_of_G + 1;
        end
    end
    %size_of_G = length(find(partition_simple));
    G_n1 = zeros(size_of_G, size_of_G);
    J_n1 = zeros(size_of_G, 1);
    for i = 1: length(cktnetlist.elements)
        if (partition_simple(i) == 0)
            if (~isempty(cktnetlist.elements{i}.parms))
                resistance = cell2mat(cktnetlist.elements{i}.parms);
                G_n1(i,i) = 1/resistance;
                J_n1(i) = 0;
            else 
                G_n1(i,i) = 0;
                J_n1(i) = (cktnetlist.elements{i}.udata{1}.QSSval);
            end
        end
    end


end
