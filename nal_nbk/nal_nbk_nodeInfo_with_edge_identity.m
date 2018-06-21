function [edges, g1] = nal_nbk_nodeInfo_with_edge_identity(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax : [edges, g1] = nal_nbk_nodeInfo_with_edge_identity(cktnetlist)
% 
% This will return the cell object g1 which is a column vector having information
% that each row represent the node number ('gnd' node is treated as the last node)
% and entry to each row corresponds to the edge identity of graph of G
%
% Along with this we also returning the edges, which require in dfs_search of 
% graph of G
%
% 1. cktnetlist = nal_nbk_ckt_02();
% 2. [edges, g1] = nal_nbk_nodeInfo_with_edge_identity(cktnetlist)
%
%
% --------------------------------------------------------------------------------

% --------------------- written on : Oct 08, 2017 --------------------------------
    global g1;
    global edges;
    edges = {};
    
    N = length(cktnetlist.nodenames)+ 1;  %% '+1' is for gnd node 
   % nal_nbk_A_and_B_part = nal_nbk_partition(cktnetlist) ;
    g1 = cell(N,1);
    for i = 1:length(cktnetlist.elements)
        edges = [edges ; cktnetlist.elements{i}.nodes];
            edge = cktnetlist.elements{i}.nodes;
            node1 = edge(1,1);
            node2 = edge(1,2);
            % chage 'gnd' node name to the '0' and convert other nodes to mat-typefrom cell type 
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
                g1{node1} = [g1{node1}, i];
                g1{node2} = [g1{node2}, i];
    end
end

