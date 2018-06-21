function [edges,g1_of_supernode] =  nal_nbk_nodeInfo_with_edge_identity_of_super_node_of_G(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax : [edges,g1_of_supernode] =  nal_nbk_nodeInfo_with_edge_identity_of_super_node_of_G(cktnetlist)
%
% This function will return the cell object g1_of_supernode, which is a column vector
% having information that each row represent the super_node number and entry to
% each row corresponds to the edge identity of graph return by function 
% nal_nbk_super_node_of_forest_of_G(cktnetlist)
% --------------------------------------------------------------------------------

% -------------------------------- Written on : Oct 09,2017 ----------------------

    global g1_of_supernode;
    global edges;
    super_node  =  nal_nbk_super_node_of_forest_of_G(cktnetlist);
    N = length(super_node);
    g1_of_supernode = cell(N,1);
    for i = 1: length(cktnetlist.elements)
        edges = [edges;cktnetlist.elements{i}.nodes];
        edge = cktnetlist.elements{i}.nodes;
        node1 = edge(1,1);
        node2 = edge(1,2);
        % chage 'gnd' node name to the '0' and convert other nodes to mat-typefrom cell type 
        if (strcmp(node1,'gnd'))
            node1 = length(cktnetlist.nodenames)+ 1;
        else 
            node1 = str2num(cell2mat(node1));
        end
        if (strcmp(node2,'gnd'))
            node2 = length(cktnetlist.nodenames)+ 1;
        else 
            node2 = str2num(cell2mat(node2));
        end
        for j = 1:N
            if(~isempty(find(super_node{j} == node1))) % node1 is in super_node
                if(isempty(find(super_node{j} == node2))) % node2 is not is super_node
                    g1_of_supernode{j} = [g1_of_supernode{j},i];
                end
            elseif(~isempty(find(super_node{j} == node2))) % node2 is in super_node
                if(isempty(find(super_node{j} == node1))) % node1 is not is super_node
                    g1_of_supernode{j} = [g1_of_supernode{j},i];
                end
            end
        end
       % edges = unique(edges);
end
