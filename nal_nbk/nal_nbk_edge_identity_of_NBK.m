function  [edgeId_for_NBK] = nal_nbk_edge_identity_of_NBK(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax :[edgeId_for_NBK] = nal_nbk_edge_identity_of_NBK(cktnetlist)
% 
% This function will return the edgeIds for network G.(BUK) i.e. NBK. This is 
% obtain by just B-Part and K-Branch of network N.
% --------------------------------------------------------------------------------

% ------------------------ written on : Mar 17, 2018 -----------------------------
    nal_nbk_A_and_B_part = nal_nbk_partition(cktnetlist);
    B_branch_index = find(not(nal_nbk_A_and_B_part));
    K_branch = nal_nbk_K_branch_hybrid_analysis(cktnetlist);
    edgeId_for_NBK = [B_branch_index, K_branch];
end
