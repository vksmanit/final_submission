function [fundamental_circuit_edgeId_for_NBK] =  nal_nbk_fundamental_circuit_edgeId_for_NBK_using_coloops(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax : fundamental_circuit_edgeId_for_NBK = nal_nbk_fundamental_circuit_edgeId_for_NBK_using_coloops(cktnetlist)
% 
% This function return cell kind of object containing informaiton about fundamental
% circuit in NBK graph. 
% This uses the concept of removing all the coloops in tree with one link branch. 
%
% This function we will not use to get the hybrid analysis equation. Another function
% is there to get fundamental circuit of NBK. (nal_nbk_fundamental_circuit_for_NBK).
% --------------------------------------------------------------------------------

% ---------------------------- Written On : Apr 07, 2018 -------------------------

    global edges_for_NBK;
    global fundamental_circuit_edgeId_for_NBK;
    %global circuit_edgeIds;
    global new_g1;

    N = length(cktnetlist.nodenames) + 1;
   [tree_branch_of_NBK, link_branch_for_NBK] = nal_nbk_tree_and_link_branch_for_NBK(cktnetlist);
    fundamental_circuit_edgeId_for_NBK = cell(length(link_branch_for_NBK),1);

    for i = 1:length(link_branch_for_NBK)
        circuit_edgeIds = [];
        node_visited = zeros(N,1);
        [g1_of_tree_of_NBK, edges_for_NBK] = nal_nbk_nodeInfo_with_edge_identity_of_tree_of_NBK(cktnetlist);
        edge = cktnetlist.elements{link_branch_for_NBK(i)}.nodes;
        node1 = edge(1,1);
        node2 = edge(1,2);
        if (strcmp(node1, 'gnd'))
            node1 = N;
        else 
            node1 = str2num(cell2mat(node1));
        end
        if (strcmp(node2,'gnd'))
            node2 = N;
        else 
            node2 = str2num(cell2mat(node2));
        end
        g1_of_tree_of_NBK{node1} = [g1_of_tree_of_NBK{node1}, link_branch_for_NBK(i)];
        g1_of_tree_of_NBK{node2} = [g1_of_tree_of_NBK{node2}, link_branch_for_NBK(i)];

        function_to_find_fundamental_circuit(g1_of_tree_of_NBK);
        for k = 1:length(new_g1)
            circuit_edgeIds = [circuit_edgeIds, new_g1{k}];
        end
        circuit_edgeIds = unique(circuit_edgeIds);
        fundamental_circuit_edgeId_for_NBK{i} = circuit_edgeIds;
    end
end

function function_to_find_fundamental_circuit(g1_of_tree_of_NBK)
    global edges_for_NBK;
    global new_g1 ;
    new_g1 = g1_of_tree_of_NBK;
    for i = 1: length(new_g1) 
        if ( length(new_g1{i}) == 1) % | isempty(new_g1{i}))
            edge_entry = new_g1{i};
            new_g1{i} = [];
            break;
        else
            edge_entry = 0;
        end
    end
    for i = 1:length(new_g1) 
        if (edge_entry == 0) 
            return ;
        else 
            index = find(new_g1{i} == edge_entry);
            if (index) 
                new_g1{i}(index) = [];
                break;
            end
        end
    end
    function_to_find_fundamental_circuit(new_g1);
end
