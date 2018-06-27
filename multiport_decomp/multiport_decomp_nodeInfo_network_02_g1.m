function g2 = multiport_decomp_nodeInfo_network_02_g1(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax : g2 = multiport_decomp_nodeInfo_network_02_g1(cktnetlist)
% 
% This function will return a cell object which is having information about the edges
% attached to the nodes of graph G1 (Two-Graph Method) of  multiport network 02.
% --------------------------------------------------------------------------------

    global g2;
    global edges;
    N = length(cktnetlist.nodenames) + 1;
    modified_edges_for_network_02_g1 = multiport_decomp_network_02_edges_for_G1(cktnetlist);
    g2 = cell(N,1);
    for i = 1:size(modified_edges_for_network_02_g1,1)
        edge = modified_edges_for_network_02_g1(i,:);
        node1 = edge(1,1);
        node2 = edge(1,2);
        g2{node1} = [g2{node1}, i];
        g2{node2} = [g2{node2}, i];
    end
end
