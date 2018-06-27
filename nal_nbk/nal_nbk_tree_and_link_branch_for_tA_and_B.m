function [tree_branch_for_tA_and_B, link_branch_for_tA_and_B] =  nal_nbk_tree_and_link_branch_for_tA_and_B(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax : [tree_branch_for_tA_and_B, link_branch_for_tA_and_B] = nal_nbk_tree_and_link_branch_for_tA_and_B(cktnetlist);
%
% This function will return the edgeIds of tree and link branch of tA_and_B Graph.
% --------------------------------------------------------------------------------
   global g1_of_tA_and_B;
   global edges;
   global nodeVisited;
   global tree_branch_for_tA_and_B;
   global dfs_nodes_of_tA_and_B;
   dfs_nodes_of_tA_and_B = [];
   tree_branch_for_tA_and_B = [];
   link_branch_for_tA_and_B = [];
   [g1_of_tA_and_B,edges,edgeId_for_tA_and_B] = nal_nbk_nodeInfo_with_edge_identity_of_tA_and_B(cktnetlist);
   nodeVisited = zeros(length(g1_of_tA_and_B),1);
   nal_nbk_start_node_of_tA_and_B(cktnetlist);
   for item = edgeId_for_tA_and_B
       if (~ismember(item, tree_branch_for_tA_and_B))
            link_branch_for_tA_and_B = [link_branch_for_tA_and_B, item];
       end
   end
end

function nal_nbk_start_node_of_tA_and_B(cktnetlist)
   global g1_of_tA_and_B;
   global edges;
   global nodeVisited;
   global tree_branch_for_tA_and_B;
   global dfs_nodes_of_tA_and_B;
   for i = 1: length(g1_of_tA_and_B)
       if (nodeVisited(i) == 0)
           start_node = i;
           nal_nbk_dfs_search_tA_and_B(start_node);
       end
   end
end

function nal_nbk_dfs_search_tA_and_B(nodeId)
    global g1_of_tA_and_B;
    global edges;
    global nodeVisited;
    global tree_branch_for_tA_and_B;
    global dfs_nodes_of_tA_and_B;
    if ( ~isempty(g1_of_tA_and_B{nodeId}))
        nodeVisited(nodeId) = 1;
        if ( isempty(dfs_nodes_of_tA_and_B))
            dfs_nodes_of_tA_and_B = [dfs_nodes_of_tA_and_B,nodeId];
        elseif(nodeId ~= dfs_nodes_of_tA_and_B(end))
            dfs_nodes_of_tA_and_B = [dfs_nodes_of_tA_and_B,nodeId];
        end
    end

    adjEdgeIdsOfCurrentNode = g1_of_tA_and_B{nodeId};
    for edgeId = adjEdgeIdsOfCurrentNode
        edge = edges(edgeId, :);
        otherNode = edge(1,2);
        if (strcmp(otherNode,'gnd'))
            otherNode = length(nodeVisited);
        else
            otherNode = str2num(cell2mat(edge(1,2)));
        end
        if otherNode == nodeId 
            otherNode = str2num(cell2mat(edge(1,1)));
            if (isempty(otherNode))
                otherNode = length(nodeVisited);
            end
        end
        if 1 == nodeVisited(otherNode)
            continue
        end
        dfs_nodes_of_tA_and_B = [dfs_nodes_of_tA_and_B, otherNode];
        tree_branch_for_tA_and_B = [tree_branch_for_tA_and_B, edgeId];
        nal_nbk_dfs_search_tA_and_B(otherNode);
    end

end
