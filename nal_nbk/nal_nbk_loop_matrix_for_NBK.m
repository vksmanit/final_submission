function loop_matrix_for_NBK = nal_nbk_loop_matrix_for_NBK(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax : loop_matrix_for_NBK = nal_nbk_loop_matrix_for_NBK(cktnetlist)
% 
% This function will return the loop matrix of network NBK i.e. graph G.(BUK).
% --------------------------------------------------------------------------------

% ------------------------- written on : Mar 26, 2018 ----------------------------
    fundamental_circuit_for_NBK = nal_nbk_fundamental_circuit_for_NBK(cktnetlist);
   %[edgeId_for_NBK] = nal_nbk_edge_identity_of_NBK(cktnetlist);
    %loop_matrix_for_NBK = sparse (zeros (rows, cols));
    [g1_of_NBK, edges_for_NBK] = nal_nbk_nodeInfo_with_edge_identity_of_NBK(cktnetlist);
    N = length(cktnetlist.nodenames) + 1; 
    rows =  length(fundamental_circuit_for_NBK);
    cols =  length(edges_for_NBK);
    %loop_matrix_for_NBK = (zeros (rows, cols));
    loop_matrix_for_NBK = sparse(zeros (rows, cols));

    for i = 1:rows
        length_of_fundamental_circuit = length(fundamental_circuit_for_NBK{i});
        for k = 1:length_of_fundamental_circuit
            current_edgeId = fundamental_circuit_for_NBK{i}(length_of_fundamental_circuit-k+1);
            edge = edges_for_NBK(current_edgeId, :);
            otherNode = edge(1,2);
            if ( strcmp(otherNode, 'gnd'))
                otherNode = N;
            else 
                otherNode = str2num( cell2mat(edge(1,2)));
            end

            if k == 1
                loop_matrix_for_NBK(i,current_edgeId) = 1;
            elseif otherNode ~= currentNode
                loop_matrix_for_NBK(i,current_edgeId) = 1;
            elseif otherNode == currentNode 
                loop_matrix_for_NBK(i,current_edgeId) = -1;
                otherNode = edge(1,1);
                if ( strcmp(otherNode, 'gnd'))
                    otherNode = N;
                else 
                    otherNode = str2num( cell2mat(otherNode));
                end
            end
            currentNode = otherNode;
        end
    end

end


   %for i =1%:rows
   %   length_of_fundamental_circuit = length(fundamental_circuit_for_NBK{i});
   %   for k = 1:length_of_fundamental_circuit
   %       %for k = 1:length(fundamental_circuit_for_NBK{i})
   %       current_branch = fundamental_circuit_for_NBK{i}(length_of_fundamental_circuit - k + 1);
   %       edge = edges_for_NBK(current_branch, :);
   %       otherNode = edge(1,2);
   %       if ( strcmp(otherNode, 'gnd'))
   %           otherNode = N;
   %       else 
   %           otherNode = str2num( cell2mat(edge(1,2)));
   %       end

   %       if k == 1
   %           loop_matrix_for_NBK(i,fundamental_circuit_for_NBK{i}(length_of_fundamental_circuit-k+1)) = 1;
   %       elseif otherNode ~= currentNode 
   %           loop_matrix_for_NBK(i,fundamental_circuit_for_NBK{i}(length_of_fundamental_circuit-k+1)) = 1;
   %       elseif otherNode == currentNode  
   %           loop_matrix_for_NBK(i,fundamental_circuit_for_NBK{i}(length_of_fundamental_circuit-k+1)) = -1;
   %       end
   %       currentNode = otherNode;
   %   end
   %nd
