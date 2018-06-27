function[nodeVisited, edgeId_of_tree_of_B,dfs_nodes_of_B] =  multiport_decomp_dfs_search_of_G_dot_B(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax : [nodeVisited,edgeId_of_tree_of_B,dfs_nodes_of_B] = multiport_decomp_dfs_search_of_G_dot_B(cktnetlist)
%
% This function will return the nodeVisited, edgeId_of_tree_of_B, dfs_nodes_of_B
% of graph G.B
% --------------------------------------------------------------------------------
    
% ----------------------------- written on : May 26, 2018 ------------------------
    global g1_of_B;
    global nodeVisited;
    global edges;
    global edgeId_of_tree_of_B;
    global dfs_nodes_of_B;
    dfs_nodes_of_B= [];
    edgeId_of_tree_of_B = [];
    [edges ,g1_of_B] = multiport_decomp_nodeInfo_with_edge_identity_of_B(cktnetlist);
    nodeVisited = zeros(length(g1_of_B),1);
    multiport_decomp_start_node_of_G(cktnetlist);
end 

function  multiport_decomp_start_node_of_G(cktnetlist)
    global g1_of_B;
    global nodeVisited;
    global edges;
    global edgeId_of_tree_of_B;
    global dfs_nodes_of_B;
    for i = 1:length(g1_of_B)
        if(nodeVisited(i)==0 )%&& ~isempty(g1_of_B{i}))
            start_node = i;
            multiport_decomp_dfs_search(start_node);
        end
    end
end 

function multiport_decomp_dfs_search(nodeId)

    global g1_of_B;
    global edges;
    global nodeVisited;
    global edgeId_of_tree_of_B;
    global dfs_nodes_of_B;
    if (~isempty(g1_of_B{nodeId}))
        nodeVisited(nodeId) = 1;
        if ( isempty(dfs_nodes_of_B))
            dfs_nodes_of_B = [dfs_nodes_of_B,nodeId];
        elseif(nodeId ~= dfs_nodes_of_B(end))
            dfs_nodes_of_B = [dfs_nodes_of_B,nodeId];
        end
    end
    adjEdgeIdsOfCurrentNode = g1_of_B{nodeId};
    for edgeId=adjEdgeIdsOfCurrentNode
        edge = edges(edgeId, :);
        otherNode = edge(1,2);
        if (strcmp(otherNode,'gnd'))
            otherNode = length(nodeVisited);
        else
            otherNode = str2num(cell2mat(edge(1,2)));
        end
        if otherNode == nodeId 
            %% adding following if condition that if otherNode is compare to 'gnd' cell2mat() return
            %% empty cell hence it is the gnd node.
            %% we assign 'gnd' node as the last nodeId.
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
        if otherNode == length(nodeVisited)
            print_otherNode = 0;
        else
            print_otherNode = otherNode;
        end
        dfs_nodes_of_B = [dfs_nodes_of_B,otherNode];
        edgeId_of_tree_of_B = [edgeId_of_tree_of_B,edgeId];
        %fprintf ('visiting node [%d] from [%d] using edgeId [%d]\n', print_otherNode, nodeId, edgeId);
       % %fprintf ('visiting node [%d] from [%d] using edgeId [%d]\n', otherNode, nodeId, edgeId);
        multiport_decomp_dfs_search (otherNode);
    end
end
