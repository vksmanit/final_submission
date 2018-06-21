function K_branch = nal_nbk_K_branch_hybrid_analysis(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax : K_branch = nal_nbk_K_branch_hybrid_analysis(cktnetlist) 
% 
% This function will return the K-branches whihch belongs to the A-part. By opening
% these branches we will get A-K and B as seperators
% --------------------------------------------------------------------------------

% ------------------------- written on : Oct 13, 2017 ----------------------------

    global g1_of_tree_of_A;
    global uncommon_nodes;
    g1_of_tree_of_A = nal_nbk_nodeInfo_of_tree_of_A(cktnetlist);
    uncommon_nodes = not(nal_nbk_A_and_B_common_nodes(cktnetlist));
    K_branch = [];
    recursive_call_to_remove_coloops();
    for i = 1:length(g1_of_tree_of_A)
        K_branch = [K_branch,g1_of_tree_of_A{i}];
    end
    K_branch = unique(K_branch);
end

function recursive_call_to_remove_coloops()
    global g1_of_tree_of_A;
    global uncommon_nodes;
    for i = 1:length(g1_of_tree_of_A)
        if( length(g1_of_tree_of_A{i}) == 1)
            if ( uncommon_nodes(i) == 1)
                edge_entry = g1_of_tree_of_A{i};
                g1_of_tree_of_A{i} = [];  
                break;
           else 
                edge_entry = 0;
            end
        end
    end
    for i = 1:length(g1_of_tree_of_A)
       if(edge_entry == 0) 
            return ;
        else
        index = find(g1_of_tree_of_A{i} == edge_entry);
        if (index)
            g1_of_tree_of_A{i}(index) = [];
            break;
        end
       end
    end
    recursive_call_to_remove_coloops();
end

