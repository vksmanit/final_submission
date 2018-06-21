function [g1_of_NBK,edges,edgeId_for_NBK] = nal_nbk_nodeInfo_with_edge_identity_of_NBK(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax : [g1_of_NBK,edges, edgeId_for_NBK] = nal_nbk_nodeInfo_with_edge_identity_of_NBK(cktnetlist)
%
% This function will return cell object g1_of_NBK which is column vector having 
% information, that each row represent the node number and entry to each rows 
% corresponds to the edge identity of NBK.
% This function also return the edges, and edgeId of NBK.
% --------------------------------------------------------------------------------

% -------------------------- Modified On : Apr 02, 2018 --------------------------


    global g1_of_NBK;
    edges = {};
    [edgeId_for_NBK] = nal_nbk_edge_identity_of_NBK(cktnetlist);
    %[edgeId_for_NBK] = nal_nbk_edge_identity_of_NBK(cktnetlist);
    %number_of_edges = length(edgeId_for_NBK);
    N = length(cktnetlist.nodenames)+1;
    g1_of_NBK = cell(N,1);
    for i = 1:length(cktnetlist.elements) % can we store to short the calculation
        edges = [edges; cktnetlist.elements{i}.nodes];
        if (ismember(i,edgeId_for_NBK))
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
            g1_of_NBK{node1} = [g1_of_NBK{node1}, i];
            g1_of_NBK{node2} = [g1_of_NBK{node2}, i];
        end
    end
end 
