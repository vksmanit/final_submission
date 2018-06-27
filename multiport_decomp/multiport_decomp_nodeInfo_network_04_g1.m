function g1 = multiport_decomp_nodeInfo_network_04_g1(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax : g1 = multiport_decomp_nodeInfo_network_04_g1(cktnetlist)
% 
% This function will return a cell object which is having information about the edges
% attached to the nodes of graph G1 (Two-Graph Method) of  multiport network 04.
% --------------------------------------------------------------------------------
    global g1;
    global edges;
    N = length(cktnetlist.nodenames) + 1;
    modified_edges_for_network_04_g1 = multiport_decomp_network_04_edges_for_G1(cktnetlist);
    g1 = cell(N,1);
    for i = 1:size(modified_edges_for_network_04_g1,1)
        edge = modified_edges_for_network_04_g1(i,:);
        node1 = edge(1,1);
        node2 = edge(1,2);
        g1{node1} = [g1{node1}, i];
        g1{node2} = [g1{node2}, i];
    end
end
