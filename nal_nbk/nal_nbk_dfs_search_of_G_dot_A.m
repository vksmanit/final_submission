function [nodeVisited,edgeId_of_tree_of_A,dfs_nodes_of_A] = nal_nbk_dfs_search_of_G_dot_A(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax : [nodeVisited,edgeId_of_tree_of_A,dfs_nodes_of_A]= nal_nbk_dfs_search_of_G_dot_A(cktnetlist)
% 
% This function will return 'node_visited' vector representing visited nodes 
% of Graph G.A.
% 
% Also it will print the string "visiting node [x] from [y] using edgeId [xId]"
% as deapth first search is progressing on graph G.A.
% 
% It is also modified to return the edgeIds of Graph G.B in DFS search sequentially.
% 
% It is also modified to return the NodeIds of Graph G.A in DFS search sequentially.
% --------------------------------------------------------------------------------

% Prob_01 : not able to search the disconnected a component ----------------------
% ---------- corrected : modified on : Sep 30, 2017 ------------------------------
% Prob_02 : printing the nodes correctly but giving nodeVisited output incorrect 
% ---------- corrected : modified on : Oct 01, 2017 ------------------------------
% getting nodeVisted = ones(N) which is incorrect---------------------------------
% --------------------------------------------------------------------------------
% Finally modified the code : update the nodeVisted at line no. 77, to update the 
% nodeVisited only if g1_of_B is not empty : modified on : Oct 03, 2017 ----------
% --------------------------------------------------------------------------------
% This code is modified to return also the edge Id during DFS search of G.A ------
% --------------------------- modified on : Oct 07, 2017 -------------------------
% This code is also modified to return the nodeIds during DFS search of G.A ------
% --------------------------- modified on : Oct 07, 2017 -------------------------
%    
% -------------------------- written on : Sep 28, 2017 ---------------------------
    global g1_of_A;
    global nodeVisited;
    global edges;
    global edgeId_of_tree_of_A;
    global dfs_nodes_of_A;
    dfs_nodes_of_A= [];
    edgeId_of_tree_of_A = [];
    [edges ,g1_of_A] = nal_nbk_nodeInfo_with_edge_identity_of_A(cktnetlist);
    nodeVisited = zeros(length(g1_of_A),1);
    edgeID_of_tree_of_A = [];
    nal_nbk_start_node_of_G_dot_A(cktnetlist);
end 

function  nal_nbk_start_node_of_G_dot_A(cktnetlist)
    global g1_of_A;
    global nodeVisited;
    global edges;
    global edgeId_of_tree_of_A;
    global dfs_nodes_of_A;
    for i = 1:length(g1_of_A)
        if(nodeVisited(i)==0 )%&& ~isempty(g1_of_A{i}))
            start_node = i;
            nal_nbk_dfs_search(start_node);
        end
    end
end 

function nal_nbk_dfs_search(nodeId)

    global g1_of_A;
    global edges;
    global nodeVisited;
    global edgeId_of_tree_of_A;
    global dfs_nodes_of_A;
    if (~isempty(g1_of_A{nodeId}))
        nodeVisited(nodeId) = 1;
        if ( isempty(dfs_nodes_of_A))
            dfs_nodes_of_A = [dfs_nodes_of_A,nodeId];
        elseif(nodeId ~= dfs_nodes_of_A(end))
            dfs_nodes_of_A = [dfs_nodes_of_A,nodeId];
        end
    end
    adjEdgeIdsOfCurrentNode = g1_of_A{nodeId};
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

        dfs_nodes_of_A = [dfs_nodes_of_A,otherNode];
        edgeId_of_tree_of_A = [edgeId_of_tree_of_A, edgeId];
        %fprintf ('visiting node [%d] from [%d] using edgeId [%d]\n', print_otherNode, nodeId, edgeId);
        nal_nbk_dfs_search (otherNode);
    end
end



