function [A1g_n3, A2g_n3, A2e_n3] = multiport_decomp_incidence_matrix_for_network_03(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax : [A1g_n3, A2g_n3, A2e_n3] = multiport_decomp_incidence_matrix_for_network_03(cktnetlist)
%
% This funciton will return the incidence matrix of graph (Two Graph method) 
% of multiport network 03.
% --------------------------------------------------------------------------------

    incidence_matrix_of_network_03_g1 = multiport_decomp_incidence_matrix_for_network_03_g1(cktnetlist);
    A1g_n3 = incidence_matrix_of_network_03_g1(1:end-1,:);
    incidence_matrix_of_network_03_g2 = multiport_decomp_incidence_matrix_for_network_03_g2(cktnetlist);
    A2g_n3 = incidence_matrix_of_network_03_g2(1:end-1,1:size(A1g_n3,2));
    A2e_n3 = incidence_matrix_of_network_03_g2(1:end-1,size(A1g_n3,2)+1:end); 
    %incidence_matrix_of_network_03 = [incidence_matrix_of_network_03_g1, zeros(size(incidence_matrix_of_network_03_g1,1),1);
     %                                 incidence_matrix_of_network_03_g2];

end
