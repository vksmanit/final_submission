function [G_n2,J_n2]=  multiport_decomp_G_and_J_of_network_02(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax : [G_n2, J_n2] = multiport_decomp_G_and_J_of_network_02(cktnetlist)
%   
% This function will return the G-matrix and J-matrix of each device element
% of multiport network 02.
% --------------------------------------------------------------------------------


    partition_simple = multiport_decomp_partition_simple(cktnetlist);
    %%%%% partition_simple can be patition in more general or can be hardcoded %%%%%
    size_of_G_n2 = 0;
    for i = partition_simple
        if i == 1 
            size_of_G_n2 = size_of_G_n2 + 1;
        end
    end
    %size_of_G_n2 = length(find(partition_simple));
    %size_of_G_n2 = length(partition_simple) - size_of_G_n2;
    G_n2 = zeros(size_of_G_n2, size_of_G_n2);
    J_n2 = zeros(size_of_G_n2, 1);
    index = 1;
    for i = 1: length(cktnetlist.elements)
        if (partition_simple(i) == 1)
            if (~isempty(cktnetlist.elements{i}.parms))
                resistance = cell2mat(cktnetlist.elements{i}.parms);
                G_n2(index,index) = 1/resistance;
                J_n2(index) = 0;
            else 
                G_n2(index, index) = 0;
                J_n2(index) = (cktnetlist.elements{i}.udata{1}.QSSval);
            end
            index = index + 1;
        end
    end
end
