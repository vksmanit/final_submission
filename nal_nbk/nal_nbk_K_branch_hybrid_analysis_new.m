function K_branch = nal_nbk_K_branch_hybrid_analysis_new(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax : K_branch = nal_nbk_K_branch_hybrid_analysis_new(cktnetlist)
%
% This function will return the K-branches whihch belongs to the A-part. By opening
% these branches we will get A-K and B as seperators
% --------------------------------------------------------------------------------
    
    global g1_of_tree_of_tA_and_B;
    global edges_for_tA_and_B;
    global node_visited;
    global MyCktIds;
    global MyOutput;
    
    [tree, link] = nal_nbk_tree_and_link_branch_for_tA_and_B(cktnetlist);
    [nodeVisited,edgeId_of_tree_of_A,dfs_nodes_of_A]= nal_nbk_dfs_search_of_G_dot_A(cktnetlist);

    N = length(cktnetlist.nodenames) + 1;
    [g1_of_tree_of_tA_and_B, edges_for_tA_and_B] = nal_nbk_nodeInfo_with_edge_identity_of_tree_of_tA_and_B(cktnetlist);
    fundamentalCircuitEdgeIds = link;
    coloop_edges = [];
    K_branch = [];
    for i = 1:length(link)
        edge = cktnetlist.elements{link(i)}.nodes;
        node_visited = zeros(N,1);
        node1 = edge(1,1);
        node2 = edge(1,2);
        if (strcmp(node1, 'gnd'))
            node1 = N ;
        else 
            node1 = str2num(cell2mat(node1));
        end
        if (strcmp(node2, 'gnd'))
            node2 = N ;
        else 
            node2 = str2num(cell2mat(node2));
        end
        MyCktIds = [];
        dfs_to_get_fundamental_circuit(node1,node2) %, g1_of_tree_of_tA_and_B);%, MyCktIds);
        fundamentalCircuitEdgeIds = [fundamentalCircuitEdgeIds, MyOutput];
        %fundamentalCircuitEdgeIds{i} = [MyOutput, link(i)] ;
    end
    for edge = tree
        if ~ismember(edge,fundamentalCircuitEdgeIds)
            coloop_edges = [coloop_edges ,edge];
        end
    end

    for edge = edgeId_of_tree_of_A
        if ~ismember(edge, coloop_edges)
            K_branch = [K_branch, edge];
        end
    end

    
end

function dfs_to_get_fundamental_circuit(start_node, end_node) %, g1_of_tree_of_tA_and_B)
    global edges_for_tA_and_B;
    global node_visited;
    global MyOutput;
    global MyCktIds;
    global g1_of_tree_of_tA_and_B;

    node_visited(start_node) = 1;
    adjEdgeIdsOfCurrentNode = g1_of_tree_of_tA_and_B{start_node};
    length_of_adjEdgeIdsOfCurrentNode = length(adjEdgeIdsOfCurrentNode);
    for i = 1:length(adjEdgeIdsOfCurrentNode)
        edgeId = adjEdgeIdsOfCurrentNode(i);
        edge = edges_for_tA_and_B(edgeId, :);
        otherNode = edge(1,2);
        if (strcmp(otherNode,'gnd'))
            otherNode = length(node_visited);
        else
            otherNode = str2num(cell2mat(edge(1,2)));
        end

        if otherNode == start_node 
            otherNode = str2num(cell2mat(edge(1,1)));
            if (isempty(otherNode))
                otherNode = length(node_visited);
            end
        end

        if (otherNode == end_node)
            MyOutput = [MyCktIds, edgeId];
            return ;
        end
        
        if (node_visited(otherNode) ~= 1)
            MyCktIds = [MyCktIds, edgeId];
            dfs_to_get_fundamental_circuit(otherNode, end_node) %, g1_of_tree_of_tA_and_B);  
        end
       
        if ( i == length_of_adjEdgeIdsOfCurrentNode)% & node_visited(otherNode) == 1)
            MyCktIds = MyCktIds(1:end-1);
            continue
        end

    end
end
