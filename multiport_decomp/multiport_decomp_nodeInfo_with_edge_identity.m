function [edges, g1] = multiport_decomp_nodeInfo_with_edge_identity(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax : [edges, g1] = multiport_decomp_nodeInfo_with_edge_identity(cktnetlist)
% 
% This function return the edges of the graphs. 
%
% This will return a cell object g1 which is a column vector having information 
% that each row represent the node number and entry to each row corresponds to thei
% edge identity of graph of G.
% --------------------- written on : May 29, 2018 --------------------------------
    global g1;
    global edges;
    edges = {};
    
    N = length(cktnetlist.nodenames)+ 1;  %% '+1' is for gnd node 
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
