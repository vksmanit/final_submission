function common_nodes =  nal_nbk_A_and_B_common_nodes(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax : common_nodes = nal_nbk_A_and_B_common_nodes(cktnetlist)
%
% This function will give the nodes which are common to both A and B parts
% --------------------------------------------------------------------------------

% ---------------------------- Written on : Oct 03, 2017 -------------------------

  nodes_of_A = nal_nbk_dfs_search_of_G_dot_A(cktnetlist);
  nodes_of_B = nal_nbk_dfs_search_of_G_dot_B(cktnetlist);
  common_nodes = nodes_of_B.* nodes_of_A;
end

