function g1_of_tree_of_A = nal_nbk_nodeInfo_of_tree_of_A(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax : g1_of_tree_of_A = nal_nbk_nodeInfo_of_tree_of_A(cktnetlist)
%
% This function will return the cell object g1_of_tree_of_Ai which is a column 
% vector having information, that each row represent the node number and entry to
% each row corresponds to the edge identity of tree of A -part. 
%
% This is useful to find coloop branches to get K-type branched in Hybrid Analysis.
% --------------------------------------------------------------------------------

% -------------------------- Written on : Oct 13, 2017 ---------------------------
    [nodeVisited,edgeId_of_tree_of_A,dfs_nodes_of_A]= nal_nbk_dfs_search_of_G_dot_A(cktnetlist);
    N = length(nodeVisited);
    g1_of_tree_of_A = cell(N,1); %cell(length(dfs_nodes_of_A),1);
    for edgeId = edgeId_of_tree_of_A
        edge = cktnetlist.elements{edgeId}.nodes;
        node1 = edge(1,1);
        node2 = edge(1,2);
        
        if (strcmp(node1,'gnd'))
            node1 = N;
        else 
            node1 = str2num(cell2mat(node1));
        end

        if (strcmp(node2,'gnd'))
            node2 = N;
        else 
            node2 = str2num(cell2mat(node2));
        end
        g1_of_tree_of_A{node1} = [g1_of_tree_of_A{node1},edgeId];
        g1_of_tree_of_A{node2} = [g1_of_tree_of_A{node2},edgeId];
    end
end
