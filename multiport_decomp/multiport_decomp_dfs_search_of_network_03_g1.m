function [edgeId_of_tree_of_network_03_g1] = multiport_decomp_dfs_search_of_network_03_g1(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax :  [edgeId_of_tree_of_network_03_g1] = multiport_decomp_dfs_search_of_network_03_g1(cktnetlist)
%
% This function will return edgeIds of tree of graph G1 of multiport network 03.
% --------------------------------------------------------------------------------

    global g1;
    global nodeVisited;
    global edges;
    global edgeId_of_tree_of_network_03_g1;
    global dfs_ndoes_of_network_03_g1;
    dfs_ndoes_of_network_03_g1 = [];
    edgeId_of_tree_of_network_03_g1 = [];
    g1 = multiport_decomp_nodeInfo_network_03_g1(cktnetlist);
    edges = multiport_decomp_network_03_edges_for_G1(cktnetlist);
    nodeVisited = zeros(length(g1),1);
    multiport_start_node_network_03_g1(cktnetlist);
end
function multiport_start_node_network_03_g1(cktnetlist)
    global g1;
    global nodeVisited;
    global edges;
    global edgeId_of_tree_of_network_03_g1;
    global dfs_ndoes_of_network_03_g1;
    for i = 1:length(g1) 
        if ( nodeVisited(i) == 0) 
            start_node = i;
            multiport_dfs_search_of_netowrk_01_g1(start_node);
        end 
    end
end

function multiport_dfs_search_of_netowrk_01_g1(nodeId)
    global g1;
    global nodeVisited;
    global edges;
    global edgeId_of_tree_of_network_03_g1;
    global dfs_ndoes_of_network_03_g1;
    if ( ~isempty(g1{nodeId}))
        nodeVisited(nodeId) = 1;
        if ( isempty(dfs_ndoes_of_network_03_g1)) 
            dfs_ndoes_of_network_03_g1 = [dfs_ndoes_of_network_03_g1, nodeId];
        elseif ( nodeId ~= dfs_ndoes_of_network_03_g1(end))
            dfs_ndoes_of_network_03_g1 = [dfs_ndoes_of_network_03_g1, nodeId]; 
        end 
    end
    adjEdgeIdsOfCurrentNode = g1{nodeId};
    for edgeId = adjEdgeIdsOfCurrentNode 
        edge = edges(edgeId, :) ;
        otherNode = edge(1,2); 
        if otherNode == nodeId 
            otherNode = edge(1,1);
            if (isempty(otherNode)) 
                otherNode = length(nodeVisited) 
            end
        end
        if 1 == nodeVisited(otherNode)
            continue
        end;
        dfs_ndoes_of_network_03_g1 = [dfs_ndoes_of_network_03_g1, otherNode];
        edgeId_of_tree_of_network_03_g1 = [edgeId_of_tree_of_network_03_g1, edgeId];
        multiport_dfs_search_of_netowrk_01_g1(otherNode);
    end
end
