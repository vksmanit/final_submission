function incidence_matrix_of_network_02_g1 =  multiport_decomp_incidence_matrix_for_network_02_g1(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax : incidence_matrix_of_network_02_g1 = multiport_decomp_incidence_matrix_for_network_02_g1(cktnetlist)
%
% This funciton will return the incidence matrix of graph G1 (two-graph method) 
% of multiport network 02.
% --------------------------------------------------------------------------------
     modified_edges_for_network_02_g1 = multiport_decomp_network_02_edges_for_G1(cktnetlist);
     rows = length(unique(modified_edges_for_network_02_g1));
     cols = size(modified_edges_for_network_02_g1,1);
     incidence_matrix_of_network_02_g1 = zeros(rows,cols);
     for i = 1:cols
         if (modified_edges_for_network_02_g1(i,1) ~= modified_edges_for_network_02_g1(i,2));
            incidence_matrix_of_network_02_g1(modified_edges_for_network_02_g1(i,1),i) = +1 ;
            incidence_matrix_of_network_02_g1(modified_edges_for_network_02_g1(i,2),i) = -1 ;
         end
     end
     incidence_matrix_of_network_02_g1 = incidence_matrix_of_network_02_g1(unique(modified_edges_for_network_02_g1),:);
end
