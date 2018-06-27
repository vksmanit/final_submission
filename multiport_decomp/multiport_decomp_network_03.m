function [modified_edges_for_network_03, number_of_port_branch_in_network_03] =  multiport_decomp_network_03(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax : [modified_edges_for_network_03, number_of_port_branch_in_network_03] = multiport_decomp_network_03(cktnetlist)
%
% This function will return the network 03 modified edges along with a port voltage
% edge sources;
% --------------------------------------------------------------------------------

% ------------------------- modified on : Jun 17, 2018 ---------------------------
    common_nodes = multiport_decomp_common_nodes(cktnetlist);
    common_nodes_index = find(common_nodes);
    %%%%% partition_simple can be patition in more general or can be hardcoded %%%%%
    [nodeVisited,edgeId_of_tree_of_C,dfs_nodes_of_C] = multiport_decomp_dfs_search_of_G_dot_C(cktnetlist);
    partition_simple = multiport_decomp_partition_simple(cktnetlist);
    N = length(cktnetlist.nodenames)+1;
    modified_edges_for_network_03 = [];
    for i = 1: length(cktnetlist.elements)
        if (partition_simple(i) == 2) 
            edge = cktnetlist.elements{i}.nodes;
            node1 = edge(1,1);
            node2 = edge(1,2);
            if (strcmp(node1,'gnd'))
                node1 = N;
            else 
                node1 = str2num(cell2mat(node1));
            end
            if (strcmp(node2,'gnd'))
                node2 = N;
            else 
                node2 = str2num(cell2mat(node2));
            end
            modified_edges_for_network_03 = [modified_edges_for_network_03; node1 node2];
        end 
    end
    number_of_port_branch_in_network_03 = 0;
    shared_nodes_of_C = intersect(dfs_nodes_of_C, common_nodes_index);
    for i = 1:(length(shared_nodes_of_C)-1)
        number_of_port_branch_in_network_03 = number_of_port_branch_in_network_03 + 1;
        modified_edges_for_network_03 = [modified_edges_for_network_03; shared_nodes_of_C(i) shared_nodes_of_C(i+1)];
    end

end
