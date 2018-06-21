function graph_of_super_node=  nal_nbk_graph_info_of_super_node(cktnetlist)
% -------------------------------------------------------------------------
% Syntax : graph_of_super_node = nal_nbk_graph_info_of_super_node(cktnetlist)
%
% This function will return a cell object which consist of information of 
% edges which are connected to supernodes.
% 
% This is useful to perform dfs on supernodes. With this this we are able
% to get tree of full graph, starting with a type branched and then extend
% it to B type branches.
% -------------------------------------------------------------------------

% ------------------------- written on : Oct 10, 2017 ---------------------
    
    graph_of_super_node = cell(length(cktnetlist.elements),1);
    supernode =  nal_nbk_super_node_of_forest_of_G(cktnetlist);
    [edges, g1_of_supernode] = nal_nbk_nodeInfo_with_edge_identity_of_super_node_of_G(cktnetlist);
    for i = 1:length(cktnetlist.elements)
        for j = 1:length(supernode)
            if (~isempty(find(g1_of_supernode{j} == i)))
                graph_of_super_node{i} = [graph_of_super_node{i},j];
            end
        end
    end
end


