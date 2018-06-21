function [tree_branch_for_NBK, link_branch_for_NBK] = nal_nbk_tree_and_link_branch_for_NBK(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax : [tree_branch_for_NBK, link_branch_for_NBK] = nal_nbk_tree_and_link_branch_for_NBK(cktnetlist)
%
% This function will return the edgeIds of tree and link branch of NBK Graph.
% --------------------------------------------------------------------------------

% -------------------------- Written on : Apr 05, 2018 ---------------------------
   global g1_of_NBK;
   global edges;
   global nodeVisited;
   global tree_branch_for_NBK;
   global dfs_nodes_of_NBK;
   dfs_nodes_of_NBK = [];
   tree_branch_for_NBK = [];
   link_branch_for_NBK = [];
   [g1_of_NBK,edges,edgeId_for_NBK] = nal_nbk_nodeInfo_with_edge_identity_of_NBK(cktnetlist);
   nodeVisited = zeros(length(g1_of_NBK),1);
   nal_nbk_start_node_of_NBK(cktnetlist);
   for item = edgeId_for_NBK
       if (~ismember(item, tree_branch_for_NBK))
            link_branch_for_NBK = [link_branch_for_NBK, item];
       end
   end
end

function nal_nbk_start_node_of_NBK(cktnetlist)
   global g1_of_NBK;
   global edges;
   global nodeVisited;
   global tree_branch_for_NBK;
   global dfs_nodes_of_NBK;
   for i = 1: length(g1_of_NBK)
       if (nodeVisited(i) == 0)
           start_node = i;
           nal_nbk_dfs_search_NBK(start_node);
       end
   end
end

function nal_nbk_dfs_search_NBK(nodeId)
    global g1_of_NBK;
    global edges;
    global nodeVisited;
    global tree_branch_for_NBK;
    global dfs_nodes_of_NBK;
    if ( ~isempty(g1_of_NBK{nodeId}))
        nodeVisited(nodeId) = 1;
        if ( isempty(dfs_nodes_of_NBK))
            dfs_nodes_of_NBK = [dfs_nodes_of_NBK,nodeId];
        elseif(nodeId ~= dfs_nodes_of_NBK(end))
            dfs_nodes_of_NBK = [dfs_nodes_of_NBK,nodeId];
        end
    end

    adjEdgeIdsOfCurrentNode = g1_of_NBK{nodeId};
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
        dfs_nodes_of_NBK = [dfs_nodes_of_NBK, otherNode];
        tree_branch_for_NBK = [tree_branch_for_NBK, edgeId];
        nal_nbk_dfs_search_NBK(otherNode);
    end
end
