function [nodeVisited,edgeId_of_tree_of_C,dfs_nodes_of_C] = multiport_decomp_dfs_search_of_G_dot_C(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax : [nodeVisited,edgeId_of_tree_of_C,dfs_nodes_of_C] = multiport_decomp_dfs_search_of_G_dot_C(cktnetlist)
%
% This function will return the nodeVisited, edgeId_of_tree_of_C, dfs_nodes_of_C
% of graph G.C
% --------------------------------------------------------------------------------

% ----------------------------- written on : May 26, 2018 ------------------------
    global g1_of_C;
    global nodeVisited;
    global edges;
    global edgeId_of_tree_of_C;
    global dfs_nodes_of_C;
    dfs_nodes_of_C= [];
    edgeId_of_tree_of_C = [];
    [edges ,g1_of_C] = multiport_decomp_nodeInfo_with_edge_identity_of_C(cktnetlist);
    nodeVisited = zeros(length(g1_of_C),1);
    edgeID_of_tree_of_C = [];
    multiport_decomp_start_node_of_G_dot_C(cktnetlist);
end 

function  multiport_decomp_start_node_of_G_dot_C(cktnetlist)
    global g1_of_C;
    global nodeVisited;
    global edges;
    global edgeId_of_tree_of_C;
    global dfs_nodes_of_C;
    for i = 1:length(g1_of_C)
        if(nodeVisited(i)==0 )%&& ~isempty(g1_of_C{i}))
            start_node = i;
            multiport_decomp_dfs_search(start_node);
        end
    end
end 

function multiport_decomp_dfs_search(nodeId)

    global g1_of_C;
    global edges;
    global nodeVisited;
    global edgeId_of_tree_of_C;
    global dfs_nodes_of_C;
    if (~isempty(g1_of_C{nodeId}))
        nodeVisited(nodeId) = 1;
        if ( isempty(dfs_nodes_of_C))
            dfs_nodes_of_C = [dfs_nodes_of_C,nodeId];
        elseif(nodeId ~= dfs_nodes_of_C(end))
            dfs_nodes_of_C = [dfs_nodes_of_C,nodeId];
        end
    end
    adjEdgeIdsOfCurrentNode = g1_of_C{nodeId};
    for edgeId=adjEdgeIdsOfCurrentNode
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
        %% this if__else__end is written for the print_ohterNode
        %% if node is gnd instead of printing it last node it prints node 0
%       if otherNode == length(nodeVisited)
%           print_otherNode = 0;
%       else
%           print_otherNode = otherNode;
%       end

        dfs_nodes_of_C = [dfs_nodes_of_C,otherNode];
        edgeId_of_tree_of_C = [edgeId_of_tree_of_C, edgeId];
        %fprintf ('visiting node [%d] from [%d] using edgeId [%d]\n', print_otherNode, nodeId, edgeId);
        multiport_decomp_dfs_search (otherNode);
    end
end



