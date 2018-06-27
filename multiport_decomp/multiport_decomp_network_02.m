function [modified_edges_for_network_02, number_of_port_branch_in_network_02] =  multiport_decomp_network_02(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax : [modified_edges_for_network_02, number_of_port_branch_in_network_02] = multiport_decomp_network_02(cktnetlist)
%
% This function will return the network 02 modified edges along with a port voltage
% edge sources.
% --------------------------------------------------------------------------------
    common_nodes = multiport_decomp_common_nodes(cktnetlist);
    common_nodes_index = find(common_nodes);
    %%%%% partition_simple can be patition in more general or can be hardcoded %%%%%

    [nodeVisited,edgeId_of_tree_of_B,dfs_nodes_of_B] = multiport_decomp_dfs_search_of_G_dot_B(cktnetlist);

    partition_simple = multiport_decomp_partition_simple(cktnetlist);
    N = length(cktnetlist.nodenames)+1;
    modified_edges_for_network_02 = [];
    for i = 1: length(cktnetlist.elements)
        if (partition_simple(i) == 1) 
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
            modified_edges_for_network_02 = [modified_edges_for_network_02; node1 node2];
        end 
    end
    number_of_port_branch_in_network_02 = 0;
    shared_nodes_of_B = intersect(dfs_nodes_of_B, common_nodes_index);
    for i = 1:(length(shared_nodes_of_B)-1)
        number_of_port_branch_in_network_02 = number_of_port_branch_in_network_02 + 1;
        modified_edges_for_network_02 = [modified_edges_for_network_02; shared_nodes_of_B(i) shared_nodes_of_B(i+1)];
    end

end
