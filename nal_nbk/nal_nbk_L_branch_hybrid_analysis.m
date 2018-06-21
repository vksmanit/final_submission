function L_branch = nal_nbk_L_branch_hybrid_analysis(cktnetlist)
% -------------------------------------------------------------------------------
% Syntax : L_Branch = nal_nbk_L_branch_hybrid_analysis(cktnetlist)
%
% This function will return the L-branches which belongs to the B-part. By shorting
% these branch we get A and B-L will be as seperators.
% --------------------------------------------------------------------------------

% --------------------------- written on : Oct 11, 2017 --------------------------  
% working correctly, this uses the concept of SuperNode of all the B-part Node.
% --------------------------- modified on : Oct 15, 2017 -------------------------

    nal_nbk_A_and_B_part = nal_nbk_partition(cktnetlist);
    [hybridTreeEdgeId_of_A, hybridTreeEdgeId_of_B] = nal_nbk_tree_partition_for_hybrid_analysis(cktnetlist);
    % this return hybridTreeEdgeId_of_A and hybridTreeEdgeId_of_B part
    L_branch = []; 
    common_nodes = nal_nbk_A_and_B_common_nodes(cktnetlist);
    [nodeVisited,edgeId_of_tree_of_G,dfs_nodes_of_A,dfs_nodes_of_B]= nal_nbk_dfs_search_of_G(cktnetlist);
    hybridLinkEdgeId_of_B = [];
    super_node = {dfs_nodes_of_B};
    % this for loop is to find the hybridLinkEdgeId_of_B of B;
    for i = 1:length(nal_nbk_A_and_B_part)
        if( nal_nbk_A_and_B_part(i) == 0 && isempty(find(i == hybridTreeEdgeId_of_B)))
            hybridLinkEdgeId_of_B = [hybridLinkEdgeId_of_B, i] ;
        end
    end
    % this for loop will also contain the nodes 
    % having node of tree branches of B-PART in hybrid tree 
    for edgeId = hybridTreeEdgeId_of_B
        nodeId = cktnetlist.elements{edgeId}.nodes;
        start_node = nodeId(1);
        end_node = nodeId(2);
        if (strcmp(start_node, 'gnd'))
            start_node = length(nodeVisited);
        else
            start_node = str2num(cell2mat(start_node));
        end
        if (strcmp(end_node,'gnd'))
            end_node = length(nodeVisited);
        else
            end_node = str2num(cell2mat(end_node));
        end
        if (isempty(find(start_node == dfs_nodes_of_B)))
            super_node{1} = [super_node{1}, start_node];
        elseif (isempty(find(end_node == dfs_nodes_of_B)))
            super_node{1} = [super_node{1}, end_node ];
        else 
            super_node = super_node;
        end
    end

    for edgeId = hybridLinkEdgeId_of_B
        nodeId = cktnetlist.elements{edgeId}.nodes;
        start_node = nodeId(1);
        end_node = nodeId(2);
        if (strcmp(start_node, 'gnd'))
            start_node = length(nodeVisited);
        else
            start_node = str2num(cell2mat(start_node));
        end
        if (strcmp(end_node,'gnd'))
            end_node = length(nodeVisited);
        else
            end_node = str2num(cell2mat(end_node));
        end

        if (~isempty(find(start_node == super_node{1})) && ~isempty(find(end_node == super_node{1})))
            L_branch = L_branch;
        else 
            L_branch = [L_branch,edgeId];
        end
    end
end
