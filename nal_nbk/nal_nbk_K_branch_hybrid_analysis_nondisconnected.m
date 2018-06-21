function coloops = nal_nbk_K_branch_hybrid_analysis_nondisconnected(cktnetlist)
    clear coloops;  % why it is not clearing the  coloop variabl 
    % when we run nal_nbk_ckt_02 -- resutls in 6 and 8 as coloops 
    % but when run for ckt_01, giving the same coloops 
    coloops = [];
    modified_g1_of_tree = find_cell_of_coloops(cktnetlist);
    for i = 1:length(modified_g1_of_tree)
        coloops = [coloops, modified_g1_of_tree{i}];
    end
    coloops = unique(coloops);
end

function modified_g1_of_tree = find_cell_of_coloops(cktnetlist)
    global uncommon_nodes;
    global modified_g1_of_tree;
    g1_of_tree_of_A = nal_nbk_nodeInfo_of_tree_of_A(cktnetlist);
    start_nodes = [];
    uncommon_nodes = not(nal_nbk_A_and_B_common_nodes(cktnetlist));
    for i = 1:length(g1_of_tree_of_A)
        if ( uncommon_nodes(i) == 1 )
            if( length(g1_of_tree_of_A{i})== 1)
                start_nodes = [start_nodes,i]
            end
        end
    end
    recursive_function_to_remove_coloop(g1_of_tree_of_A);
end

function recursive_function_to_remove_coloop (g1_of_tree)
    global uncommon_nodes;
    global modified_g1_of_tree;
    for i = 1:length(g1_of_tree)
        if(~isempty(g1_of_tree{i}) && length(g1_of_tree{i}) == 1 && uncommon_nodes(i) == 1)
            edge_entry_in_node_i = g1_of_tree{i};
            g1_of_tree(i) = [];
            uncommon_nodes(i) = [];
            break;
        else 
            return;
        end
    end
    for i = 1:length(g1_of_tree)
        index = find(g1_of_tree{i} == edge_entry_in_node_i);
        if (index)
            g1_of_tree{i}(index) = [];
            break;
        end
    end
    modified_g1_of_tree = g1_of_tree;
    recursive_function_to_remove_coloop(modified_g1_of_tree)
end

