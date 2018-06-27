function modified_edges_for_network_02_g2 = multiport_decomp_network_02_edges_for_G2(cktnetlist)
% -------------------------------------------------------------------------------
% Syntax : modified_edges_for_network_02_g2 = multiport_decomp_network_02_edges_for_G2(cktnetlist)
% 
% This function will return the modified edges of graph G2 (Two-Graph Method) of 
% multiport network 02. The edgeId may be different by name.  
% -------------------------------------------------------------------------------

    [edgeId_of_tree_of_network_02_g1] = multiport_decomp_dfs_search_of_network_02_g1(cktnetlist);
    modified_edges_for_network_02 = multiport_decomp_network_02(cktnetlist);
    super_node_for_network_02_g2 = [];
    for edge = edgeId_of_tree_of_network_02_g1
        super_node_for_network_02_g2 = [super_node_for_network_02_g2, modified_edges_for_network_02(edge, :)];
    end
    super_node_for_network_02_g2 = unique(super_node_for_network_02_g2);
    modified_edges_for_network_02_g2 = [];
    for i = 1:size(modified_edges_for_network_02,1)
        edge = modified_edges_for_network_02(i,:);
        node1 = edge(1,1);
        node2 = edge(1,2);
        if ismember(node1, super_node_for_network_02_g2) 
            node1 = super_node_for_network_02_g2(1);
        end
        if ismember(node2, super_node_for_network_02_g2) 
            node2 = super_node_for_network_02_g2(1);
        end
        modified_edges_for_network_02_g2 = [modified_edges_for_network_02_g2; node1 node2];
    end 


end
