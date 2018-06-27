function [edges, g1_of_B] = multiport_decomp_nodeInfo_with_edge_identity_of_B(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax : [edges, g1_of_B] = multiport_decomp_nodeInfo_with_edge_identity_of_B(cktnetlist)
%
% This will return a cell object g1_of_B which is a column vector having information 
% that each row represent the node number and entry to each row corresponds to the% edge identity of graph of G.B.
% --------------------------------------------------------------------------------

% ----------------------------- written on : May 27, 2018 ------------------------
 
    global g1_of_B;
    global edges;
    edges= {};
    N = length(cktnetlist.nodenames)+1;
    multiport_decomp_A_and_B_part = multiport_decomp_partition_simple(cktnetlist);
    g1_of_B = cell(N,1);
    for i = 1:length(cktnetlist.elements)
        edges = [edges;cktnetlist.elements{i}.nodes];
        if (multiport_decomp_A_and_B_part(i)==1) %%this will allow the elements belonging to the B-type 
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
            g1_of_B{node1} = [g1_of_B{node1},i];
            g1_of_B{node2} = [g1_of_B{node2},i];
        end
    end
end
