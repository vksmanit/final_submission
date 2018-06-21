function [hybridTreeEdgeId_of_A, hybridTreeEdgeId_of_B] = nal_nbk_tree_partition_for_hybrid_analysis(cktnetlist)
% --------------------------------------------------------------------------------
%
% Syntax : [hybridTreeEdgeId_of_A, hybridTreeEdgeId_of_B] = nal_nbk_tree_partition_for_hybrid_analysis(cktnetlist)
%
% This function will return the edgeId of tree of A and B part for hybrid Analysis.
%
% --------------------------------------------------------------------------------

% -------------------------- written on : Oct 11, 2017 ---------------------------
    edgeId_of_tree_for_hybrid_analysis = nal_nbk_tree_for_hybrid_analysis(cktnetlist);
%    common_nodes = nal_nbk_A_and_B_common_nodes(cktnetlist);
    nal_nbk_A_and_B_part = nal_nbk_partition(cktnetlist);
    hybridTreeEdgeId_of_A = [];
    hybridTreeEdgeId_of_B = [];
    for treeEdgeId = edgeId_of_tree_for_hybrid_analysis
        if (nal_nbk_A_and_B_part(treeEdgeId) == 1)
            hybridTreeEdgeId_of_A = [hybridTreeEdgeId_of_A,treeEdgeId];
        else
            hybridTreeEdgeId_of_B = [hybridTreeEdgeId_of_B,treeEdgeId];
        end
    end
end
