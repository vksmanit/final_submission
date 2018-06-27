function [nodeVisited,edgeId_of_tree_of_G,dfs_nodes_of_A,dfs_nodes_of_B]= nal_nbk_modified_dfs_search_of_G(cktnetlist)
% Syntax :  [nodeVisited,edgeId_of_tree_of_G,dfs_nodes_of_A,dfs_nodes_of_B]= nal_nbk_modified_dfs_search_of_G(cktnetlist)
% 
% This function will return 'nodeVisited' vector representing visited nodes 
% of Graph G.
%
% Firstly it print the node visited in graph G.A and then search the remaining 
% nodes in Graph G. 
%
% Also it will print the string "visiting node [x] from [y] using edgeId [xId]"
% as deapth first search is progressing on graph G.
% 
% It is also modified to return the edgeIds and nodeIds of Graph G in DFS 
% search sequentially.
%
% It first search the nodes/edges in Graph G.A and complete DFS in gull graph G.
% --------------------------------------------------------------------------------

% -- ERROR -- it is returning wrong dfs_node_of_B -- but can be taken 
% ------------------------------ written on: Oct 08, 2017 ------------------------
    global g1_of_B;
    global nodeVisited;
    global edges;
    global edgeId_of_tree_of_G;
    global dfs_nodes_of_B;
    dfs_nodes_of_B = [];
    [edges ,g1_of_B] = nal_nbk_nodeInfo_with_edge_identity_of_B(cktnetlist);
    common_nodes = nal_nbk_A_and_B_common_nodes(cktnetlist);
    %nodeVisited = zeros(length(g1_of_B),1);
    [nodeVisited,edgeId_of_tree_of_G,dfs_nodes_of_A]= nal_nbk_dfs_search_of_G_dot_A(cktnetlist);
    % this will first do ddfs on A-part and then we will extend it to part B
    %fprintf('------------------------------------------------\n');
    %fprintf('------------End of search in part A-------------\n');
    %fprintf('------------------------------------------------\n');
%    pause(1)
    temp_node = find(common_nodes)';
    for i =(temp_node) 
        nal_nbk_dfs_search(i);
    end
end 

function nal_nbk_dfs_search(nodeId)

    global g1_of_B;
    global edges;
    global nodeVisited;
    global edgeId_of_tree_of_G;
    global dfs_nodes_of_B;
    if (~isempty(g1_of_B{nodeId}))
        nodeVisited(nodeId) = 1;
        if ( isempty(dfs_nodes_of_B))
            dfs_nodes_of_B = [dfs_nodes_of_B,nodeId];
        elseif(nodeId ~= dfs_nodes_of_B(end))
%            dfs_nodes_of_B = [dfs_nodes_of_B,nodeId];
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
        edgeId_of_tree_of_G = [ edgeId_of_tree_of_G, edgeId];
        %fprintf ('visiting node [%d] from [%d] using edgeId [%d]\n', print_otherNode, nodeId, edgeId);
        nal_nbk_dfs_search (otherNode);
    end
    dfs_nodes_of_B = unique(dfs_nodes_of_B);
end


