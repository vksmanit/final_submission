function [edgeId_of_tree_of_G, super_node_edgeIds]  = nal_nbk_tree_for_hybrid_analysis(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax : [edgeId_of_tree_for_hybrid_analysis, super_node_edgeIds] = nal_nbk_tree_for_hybrid_analysis(cktnetlist)
%
% This function will return the edgeIds for graph which form a tree of 
% Graph G. This tree is useful for Hybrid Analysis Method.
%
% This tree is first grown into A-part of the Graph and then it is extended
% to B-part of the graph to get full tree of Graph.
% 
% This will also return the super_node_edgeIds which are useful in forming incidence matrix 
% for NAL graph.
% --------------------------------------------------------------------------------

% --------------------------- written on : Oct 10, 2017 --------------------------
    
    
    global g1_of_supernode;
    global super_node_visited;
    global graph_of_super_node;
%    global nodeVisited;
    global edgeId_of_tree_of_G;
    global super_node_edgeIds;
    super_node_edgeIds = [];

    [nodeVisited,edgeId_of_tree_of_G,dfs_nodes_of_A,dfs_nodes_of_B] = nal_nbk_modified_dfs_search_of_G(cktnetlist);
    graph_of_super_node =  nal_nbk_graph_info_of_super_node(cktnetlist);
    [edges, g1_of_supernode] = nal_nbk_nodeInfo_with_edge_identity_of_super_node_of_G(cktnetlist);
    super_node_visited = zeros(length(g1_of_supernode),1);
    %fprintf('-------------------------------------------------------\n');
    %fprintf('------------ starting search in supernode -------------\n');
    %fprintf('-------------------------------------------------------\n');
    nal_nbk_dfs_search(1);
end

function nal_nbk_dfs_search(superNodeId)
    global g1_of_supernode;
    global super_node_visited;
    global super_node_edgeIds;
    global graph_of_super_node;
    global edgeId_of_tree_of_G;
    super_node_visited(superNodeId) = 1;
    adjEdgeIdsOfCurrentNode = g1_of_supernode{superNodeId};
    for edgeId=adjEdgeIdsOfCurrentNode
        edge = graph_of_super_node{edgeId};
        otherSuperNode = edge(1,2);
        if otherSuperNode == superNodeId 
            otherSuperNode = edge(1,1);
        end
        if super_node_visited(otherSuperNode) == 1
            continue
        end
        super_node_edgeIds = [super_node_edgeIds, edgeId];
        edgeId_of_tree_of_G = [edgeId_of_tree_of_G,edgeId];
        nal_nbk_dfs_search (otherSuperNode);
    end
end
