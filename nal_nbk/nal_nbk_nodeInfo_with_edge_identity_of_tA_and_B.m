function [g1_of_tA_and_B, edges, edgeId_for_tA_and_B] = nal_nbk_nodeInfo_with_edge_identity_of_tA_and_B(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax : [g1_of_tA_and_B, edges, edgeId_for_tA_and_B] = nal_nbk_nodeInfo_with_edge_identity_of_tA_and_B(cktnetlist)
%
% This function will return cell object g1_of_tA_and_B which is column vector having 
% information, that each row represent the node number and entry to each rows 
% corresponds to the edge identity of tA_and_B.
% This function also return the edges, and edgeId of tA_and_B.
% --------------------------------------------------------------------------------


    global g1_of_tA_and_B;
    edges = {};
    [edgeId_for_tA_and_B] = nal_nbk_edge_identity_of_tA_and_B(cktnetlist);
    %[edgeId_for_tA_and_B] = nal_nbk_edge_identity_of_tA_and_B(cktnetlist);
    %number_of_edges = length(edgeId_for_tA_and_B);
    N = length(cktnetlist.nodenames)+1;
    g1_of_tA_and_B = cell(N,1);
    for i = 1:length(cktnetlist.elements) % can we store to short the calculation
        edges = [edges; cktnetlist.elements{i}.nodes];
        if (ismember(i,edgeId_for_tA_and_B))
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
            g1_of_tA_and_B{node1} = [g1_of_tA_and_B{node1}, i];
            g1_of_tA_and_B{node2} = [g1_of_tA_and_B{node2}, i];
        end
    end


end
