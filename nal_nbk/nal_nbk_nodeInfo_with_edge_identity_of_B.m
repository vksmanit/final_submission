function [edges, g1_of_B] = nal_nbk_nodeInfo_with_edge_identity_of_B(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax : [edges, g1_of_B] = nal_nbk_nodeInfo_with_edge_identity_of_B(cktnetlist)
% 
% This will return the cell object g1_of_B which is a column vector having information
% that each row represent the node number ('gnd' node is treated as the last node)
% and entry to each row corresponds to the edge identity of graph of extended to
% full graph after growing G.A
%
% Along with this we also returning the edges, which require in dfs_search of 
% graph of G_dot_A
%
% 1. cktnetlist = nal_nbk_ckt_02();
% 2. [edges, g1_of_B] = nal_nbk_nodeInfo_with_edge_identity_of_B(cktnetlist)
%
%
% --------------------------------------------------------------------------------

% --------------------- written on : Oct 01, 2017 --------------------------------
 
    global g1_of_B;
    global edges;
    edges= {};
    N = length(cktnetlist.nodenames)+1;
    nal_nbk_A_and_B_part = nal_nbk_partition(cktnetlist);
    g1_of_B = cell(N,1);
    for i = 1:length(cktnetlist.elements)
        edges = [edges;cktnetlist.elements{i}.nodes];
        if (nal_nbk_A_and_B_part(i)==0) %%this will allow the elements belonging to the B-type 
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
