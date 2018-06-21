function super_node =  nal_nbk_super_node_of_forest_of_G(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax : super_node =  nal_nbk_super_node_of_forest_of_G(cktnetlist)
%
% This function will return the supernodes after forming a forest. This forest is
% a special kind forest. It first form forest on A part and then forest is extened
% to form forest of G(some edges_are_left)
% 
% This will extend to find tree of G.
% --------------------------------------------------------------------------------

% ---------------------------- Written on : Oct 08, 2017 -------------------------

    global g1_of_forest;
    global edges;
    global dfs_nodes_of_forest_of_G;
    global counter;
    global nodeVisited;
    counter = 0;
    [edges, g1_of_forest,g1] = nal_nbk_nodeInfo_forest_of_G(cktnetlist);
    nodeVisited = zeros(length(g1_of_forest));
    
    for i = 1:length(g1_of_forest)
        if(nodeVisited(i)==0 )%&& ~isempty(g1_of_forest{i}))
                start_node = i;
                %% can we do dfs(count, : ) here???/
                counter = counter+1;
                nal_nbk_dfs_search(start_node);
                super_node(counter,:) = {dfs_nodes_of_forest_of_G};
                dfs_nodes_of_forest_of_G = [];
        end
    end
end

function nal_nbk_dfs_search(nodeId)
    global g1_of_forest;
    global edges;
    global nodeVisited;
    global edgeId_of_tree_of_G;
    global counter;
    global dfs_nodes_of_forest_of_G;
    if (~isempty(g1_of_forest{nodeId}))
        nodeVisited(nodeId) = 1;
        if ( isempty(dfs_nodes_of_forest_of_G))
            dfs_nodes_of_forest_of_G = [dfs_nodes_of_forest_of_G,nodeId];
        elseif(nodeId ~= dfs_nodes_of_forest_of_G(end))
            dfs_nodes_of_forest_of_G = [dfs_nodes_of_forest_of_G,nodeId];
        end
    end
    adjEdgeIdsOfCurrentNode = g1_of_forest{nodeId};
    for edgeId=adjEdgeIdsOfCurrentNode
        edge = edges(edgeId, :);
        otherNode = edge(1,2);
        if (strcmp(otherNode,'gnd'))
            otherNode = length(nodeVisited);
        else
            otherNode = str2num(cell2mat(edge(1,2)));
        end
        if otherNode == nodeId 
            %% adding following if condition that if otherNode is compare to 'gnd' cell2mat() return
            %% empty cell hence it is the gnd node.
            %% we assign 'gnd' node as the last nodeId.
            otherNode = str2num(cell2mat(edge(1,1)));
            if (isempty(otherNode))
                otherNode = length(nodeVisited);
            end
        end
        if 1 == nodeVisited(otherNode)
            continue
        end
        %% this if__else__end is written for the print_ohterNode
        %% if node is gnd instead of printing it last node it prints node 0
        if otherNode == length(nodeVisited)
            print_otherNode = 0;
        else
            print_otherNode = otherNode;
        end
        dfs_nodes_of_forest_of_G = [dfs_nodes_of_forest_of_G,otherNode];
        nal_nbk_dfs_search (otherNode);
    end
end
