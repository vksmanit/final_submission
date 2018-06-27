function [edgeId_of_tA_and_B] = nal_nbk_edge_identity_of_tA_and_B(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax : edgeId_of_tA_and_B = nal_nbk_edge_identity_of_tA_and_B(cktnetlist);
%
% This function will return edgeId of network tree(A) and B network. Later used 
% to find the K-branch.
% --------------------------------------------------------------------------------


    nal_nbk_A_and_B_part = nal_nbk_partition(cktnetlist);
    B_branch_index = find(not(nal_nbk_A_and_B_part));
    [nodeVisited,edgeId_of_tree_of_A,dfs_nodes_of_A]= nal_nbk_dfs_search_of_G_dot_A(cktnetlist);
    [edgeId_of_tA_and_B] =  [B_branch_index,edgeId_of_tree_of_A ];

end
