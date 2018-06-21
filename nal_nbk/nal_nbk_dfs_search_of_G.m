function [nodeVisited,edgeId_of_tree_of_G,dfs_nodes_of_A,dfs_nodes_of_B]=  nal_nbk_dfs_search_of_G(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax :  [nodeVisited,edgeId_of_tree_of_G,dfs_nodes_of_A,dfs_nodes_of_B]= nal_nbk_dfs_search_of_G(cktnetlist)
%
% This function is not returning the correct edgeIds for the dfs search of Graph G.
% For correct edgeId <<< type : help nal_nbk_dfs_search_of_supernode_of_G >>>
% 
% This function will return 'node_visited' vector representing visited nodes 
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

% This function is have some problem with the nal_nbk_ckt_02_v2();
% the nal_nbk_ckt_02_v2 --> here only node6 is interchanged with 'gnd' in nal_nbk_ckt_02
% Modified the code with if else condition in to overcome the 'gnd' node problme
% Same modification done to nal_nbk_dfs_search_of_G_dot_A(cktnetlist) -----------
% --------------------------modified on : Oct 03, 2017 ---------------------------
% This code is modified to give edgeId_of_tree_of_G that is full graph, but in
% this case the problem is we are not getting any edge conncetivity b/w A and B 
% ------------------------- modified on : Oct 07,2017 ----------------------------% This code is modified to give dfs_node_of_G that is full graph with starting A 
% part and completing it into B part
% ------------------------- modified on : Oct 07,2017 ----------------------------
%
% -------------------------- written on : Oct 03, 2017 ---------------------------
    
    global g1_of_B;
    global nodeVisited;
    global edges;
    global edgeId_of_tree_of_G;
    global dfs_nodes_of_B;
    dfs_nodes_of_B = [];
    [edges ,g1_of_B] = nal_nbk_nodeInfo_with_edge_identity_of_B(cktnetlist);
    %nodeVisited = zeros(length(g1_of_B),1);
    [nodeVisited,edgeId_of_tree_of_G,dfs_nodes_of_A]= nal_nbk_dfs_search_of_G_dot_A(cktnetlist); % this will first do ddfs on A-part and then we will extend it to part B
    %fprintf('------------------------------------------------\n');
    %fprintf('------------End of search in part A-------------\n');
    %fprintf('------------------------------------------------\n');
%    pause(1)
    nal_nbk_start_node_of_G(cktnetlist);
end 

function  nal_nbk_start_node_of_G(cktnetlist)
    global g1_of_B;
    global nodeVisited;
    global edges;
    global edgeId_of_tree_of_G;
    global dfs_nodes_of_B;
    for i = 1:length(g1_of_B)
        if(nodeVisited(i)==0 )%&& ~isempty(g1_of_B{i}))
                start_node = i;
                nal_nbk_dfs_search(start_node);
        end
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
            otherNode = str2num(cell2mat(edge(1,1)));
            if (isempty(otherNode))
                otherNode = length(nodeVisited);
            end
        end
 
        if 1 == nodeVisited(otherNode)
            continue
        end
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
end


