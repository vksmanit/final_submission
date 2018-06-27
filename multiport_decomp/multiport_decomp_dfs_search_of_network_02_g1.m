function [edgId_of_tree_of_network_02_g1] = multiport_decomp_dfs_search_of_network_02_g1(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax :  [edgId_of_tree_of_network_02_g1] = multiport_decomp_dfs_search_of_network_02_g1(cktnetlist)
%
% This function will return edgeIds of tree of graph G1 of multiport network 02.
% --------------------------------------------------------------------------------

    global g2;
    global nodeVisited;
    global edges;
    global edgId_of_tree_of_network_02_g1;
    global dfs_ndoes_of_network_02_g2;
    dfs_ndoes_of_network_02_g2 = [];
    edgId_of_tree_of_network_02_g1 = [];
    g2 = multiport_decomp_nodeInfo_network_02_g1(cktnetlist);
    edges = multiport_decomp_network_02_edges_for_G1(cktnetlist);
    nodeVisited = zeros(length(g2),1);
    multiport_start_node_network_02_g2(cktnetlist);
end
function multiport_start_node_network_02_g2(cktnetlist)
    global g2;
    global nodeVisited;
    global edges;
    global edgId_of_tree_of_network_02_g1;
    global dfs_ndoes_of_network_02_g2;
    for i = 1:length(g2) 
        if ( nodeVisited(i) == 0) 
            start_node = i;
            multiport_dfs_search_of_netowrk_01_g2(start_node);
        end 
    end
end

function multiport_dfs_search_of_netowrk_01_g2(nodeId)
    global g2;
    global nodeVisited;
    global edges;
    global edgId_of_tree_of_network_02_g1;
    global dfs_ndoes_of_network_02_g2;
    if ( ~isempty(g2{nodeId}))
        nodeVisited(nodeId) = 1;
        if ( isempty(dfs_ndoes_of_network_02_g2)) 
            dfs_ndoes_of_network_02_g2 = [dfs_ndoes_of_network_02_g2, nodeId];
        elseif ( nodeId ~= dfs_ndoes_of_network_02_g2(end))
            dfs_ndoes_of_network_02_g2 = [dfs_ndoes_of_network_02_g2, nodeId]; 
        end 
    end
    adjEdgeIdsOfCurrentNode = g2{nodeId};
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
        dfs_ndoes_of_network_02_g2 = [dfs_ndoes_of_network_02_g2, otherNode];
        edgId_of_tree_of_network_02_g1 = [edgId_of_tree_of_network_02_g1, edgeId];
        multiport_dfs_search_of_netowrk_01_g2(otherNode);
    end
end
