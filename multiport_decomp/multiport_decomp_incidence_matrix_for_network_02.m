function [A1g_n2, A2g_n2, A2e_n2] = multiport_decomp_incidence_matrix_for_network_02(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax : [A1g_n2, A2g_n2, A2e_n2] = multiport_decomp_incidence_matrix_for_network_02(cktnetlist)
%
% This funciton will return the incidence matrix of graph (Two Graph method) 
% of multiport network 02.
% --------------------------------------------------------------------------------

    incidence_matrix_of_network_02_g1 = multiport_decomp_incidence_matrix_for_network_02_g1(cktnetlist);
    A1g_n2 = incidence_matrix_of_network_02_g1(1:end-1,:);
    incidence_matrix_of_network_02_g2 = multiport_decomp_incidence_matrix_for_network_02_g2(cktnetlist);
    A2g_n2 = incidence_matrix_of_network_02_g2(1:end-1,1:size(A1g_n2,2));
    A2e_n2 = incidence_matrix_of_network_02_g2(1:end-1,size(A1g_n2,2)+1:end); 



end
