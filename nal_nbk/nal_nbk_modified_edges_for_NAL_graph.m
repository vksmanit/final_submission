function all_modified_edges_for_NAL =  nal_nbk_modified_edges_for_NAL_graph(cktnetlist)
% --------------------------------------------------------------------------------
% syntax : all_modified_edges_for_NAL = nal_nbk_modified_edges_for_NAL_graph(cktnetlist) 
%
% This function will return modified_edges_for_NAL which is used to make incidence 
% matrix for a graph associated with circuit NAL i.e. Gx(AUL) 
% --------------------------------------------------------------------------------

% --------------------------- written on : Mar 13, 2018 --------------------------

    L_Branch = nal_nbk_L_branch_hybrid_analysis(cktnetlist);
    K_Branch = nal_nbk_K_branch_hybrid_analysis(cktnetlist);
    common_nodes = nal_nbk_A_and_B_common_nodes(cktnetlist);
    [nodeVisited,edgeId_of_tree_of_A,dfs_nodes_of_A]= nal_nbk_dfs_search_of_G_dot_A(cktnetlist);
    super_node = nal_nbk_super_node_of_forest_of_G(cktnetlist);
    [edgeId_of_tree_for_hybrid_analysis, super_node_edgeIds] = nal_nbk_tree_for_hybrid_analysis(cktnetlist);
    nodes_for_super_node_edgeIds = [];
    for edge = super_node_edgeIds
        nodeId = cktnetlist.elements{edge}.nodes;
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
        nodes_for_super_node_edgeIds = [nodes_for_super_node_edgeIds; start_node, end_node];
    end

    % The below loop will short the tree of B-Part and renamed the node name accordingly 
    common_nodes_index = find(common_nodes);
    for j = 1:length(super_node)
       for k = 1:length(common_nodes_index)
           if(~isempty(find(common_nodes_index(k) == super_node{j})) & isempty(find(common_nodes_index(k) == nodes_for_super_node_edgeIds)))
               aggregate_super_node(j) = common_nodes_index(k);
               break;
           end 
       end
    end

    for nodeId = dfs_nodes_of_A
        for j = 1:length(super_node)
            %for k = 1:size(nodes_for_super_node_edgeIds,1)
                if (ismember(nodeId, super_node{j}) & ~ismember(nodeId, aggregate_super_node)) %   ~ismember(nodeId, nodes_for_super_node_edgeIds(k,:)))
                %if (ismember(nodeId, super_node{j}) & ~ismember(nodeId, aggregate_super_node))
                    super_node{j} = super_node{j}(super_node{j} ~= nodeId);
                end
         end
     end


    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


    for k = 1:size(nodes_for_super_node_edgeIds,1)
        nodes = nodes_for_super_node_edgeIds(k,:);
            node1 = nodes(1);
            node2 = nodes(2);
        for j = 1:length(super_node)
            if (ismember(node1,super_node{j}))
               super_node{j} = [super_node{j}, node2];
            elseif (ismember(node2,super_node{j}))
               super_node{j} = [super_node{j}, node1]
            end
        end
    end

    all_modified_edges_for_NAL = []; 
    N = length(cktnetlist.nodenames)+1;
   % for j = 1:length(super_node)
    for i = 1:length(cktnetlist.elements)
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
        
        for j = 1:length(super_node)
           % if (ismember(node1,super_node{j}) || ismember(node2,super_node{j}))
                if (~isempty(find(node1 == super_node{j})))
                    node1 = aggregate_super_node(j);
                end
                if (~isempty(find(node2 == super_node{j})))
                    node2 = aggregate_super_node(j);
                end
            %end
        end
        %all_modified_edges_for_NAL = ([all_modified_edges_for_NAL ; node1 node2]);
        all_modified_edges_for_NAL = sparse([all_modified_edges_for_NAL ; node1 node2]);
    end

    
end
