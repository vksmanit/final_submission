function [g1_of_tree_of_tA_and_B, edges] = nal_nbk_nodeInfo_with_edge_identity_of_tree_of_tA_and_B(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax : [g1_of_tree_of_tA_and_B, edges] = nal_nbk_nodeInfo_with_edge_identity_of_tree_of_tA_and_B(cktnetlist)
% 
% This function return a cell object g1_of_tree_of_tA_and_B which is a column vector having 
% information, that each row represent the node number and entry to each row corresponds
% to the edge identity of tree of tA_and_B.
% --------------------------------------------------------------------------------

% ------------------------------- Written On : Apr 05, 2018 ----------------------

    global g1_of_tree_of_tA_and_B;
    edges = {};

    [tree_branch_for_tA_and_B, link_branch_for_tA_and_B] = nal_nbk_tree_and_link_branch_for_tA_and_B(cktnetlist);
    N = length(cktnetlist.nodenames) + 1;
    g1_of_tree_of_tA_and_B = cell(N,1);
    for i = 1:length(cktnetlist.elements)
        edges = [edges;cktnetlist.elements{i}.nodes];
        if (ismember(i,tree_branch_for_tA_and_B))
            edge = cktnetlist.elements{i}.nodes;
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
            g1_of_tree_of_tA_and_B{node1} = [g1_of_tree_of_tA_and_B{node1}, i];
            g1_of_tree_of_tA_and_B{node2} = [g1_of_tree_of_tA_and_B{node2}, i];
        end
    end
end
