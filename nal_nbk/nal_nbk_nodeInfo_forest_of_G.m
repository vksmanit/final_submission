function [edges,g1_of_forest,g1] = nal_nbk_nodeInfo_forest_of_G(cktnetlist);
% Syntax : [edges,g1_of_forest,g1] = nal_nbk_nodeInfo_forest_of_G(cktnetlist);
%
% This will return the cell object g1 which is a column vector having information
% that each row represent the node number ('gnd' node is treated as the last node)
% and entry to each row corresponds to the edge identity of graph of G
%
% Also it return g1_of_forest cell object, which is column vector having info
% that each row represent the node number ('gnd' node is treated as the last node)
% and entry to each row corresponds to the edge identity of forest_of_G.
%
% Along with this we also returning the edges, which require in dfs_search of 
% graph of G
%
% 1. cktnetlist = nal_nbk_ckt_02();
% 2. [edges, g1] = nal_nbk_nodeInfo_with_edge_identity(cktnetlist)
%
%
% --------------------------------------------------------------------------------

% --------------------- written on : Oct 08, 2017 --------------------------------
 
[nodeVisited,edgeId_of_tree_of_G,dfs_nodes_of_A,dfs_nodes_of_B]= nal_nbk_modified_dfs_search_of_G(cktnetlist);
[edges, g1] = nal_nbk_nodeInfo_with_edge_identity(cktnetlist);

    global  edges_of_forest;
    N = length(cktnetlist.nodenames)+1;
    g1_of_forest = cell(N,1);

    for i = (edgeId_of_tree_of_G)
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
        g1_of_forest{node1} = [g1_of_forest{node1}, i];
        g1_of_forest{node2} = [g1_of_forest{node2}, i];
    end
end
