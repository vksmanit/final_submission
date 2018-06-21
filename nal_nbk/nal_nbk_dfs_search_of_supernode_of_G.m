function edgeId_of_tree_of_G = nal_nbk_dfs_search_of_supernode_of_G(cktnetlist)
% --------------------------------------------------------------------------
% Syntax : edgeId_of_tree_of_G = nal_nbk_dfs_search_of_supernode_of_G(cktnetlist)
%
% This function will perform the dfs serach on the graph of super node 
% return by the function nal_nbk_graph_info_of_super_node(cktnetlist)
%
% This function is also modified to return the edgeId of tree of graph.
% --------------------------------------------------------------------------

% ------------------------- written on : Oct 10, 2017 ----------------------
    
    
    global g1_of_supernode;
    global super_node_visited;
    global graph_of_super_node;
%    global nodeVisited;
    global edgeId_of_tree_of_G;
    [nodeVisited,edgeId_of_tree_of_G,dfs_nodes_of_A,dfs_nodes_of_B] = nal_nbk_modified_dfs_search_of_G(cktnetlist);
    graph_of_super_node=  nal_nbk_graph_info_of_super_node(cktnetlist);
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
        if 1 == super_node_visited(otherSuperNode)
            continue
        end
        edgeId_of_tree_of_G = [edgeId_of_tree_of_G,edgeId];
        %fprintf('visiting SuperNode [%d] from [%d] using edgeId [%d]\n', otherSuperNode, superNodeId,edgeId);
       nal_nbk_dfs_search (otherSuperNode);
    end
end



        
 

        
    
