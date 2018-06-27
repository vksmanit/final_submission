function [A1g_n4, A2g_n4, A2e_n4] = multiport_decomp_incidence_matrix_for_network_04(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax : [A1g_n4, A2g_n4, A2e_n4] = multiport_decomp_incidence_matrix_for_network_04(cktnetlist)
%
% This funciton will return the incidence matrix of graph (Two Graph method) 
% of multiport network 04.
% --------------------------------------------------------------------------------

    incidence_matrix_of_network_04_g1 = multiport_decomp_incidence_matrix_for_network_04_g1(cktnetlist);
    A1g_n4 = incidence_matrix_of_network_04_g1(1:end-1,:);
    incidence_matrix_of_network_04_g2 = multiport_decomp_incidence_matrix_for_network_04_g2(cktnetlist);
    A2g_n4 = incidence_matrix_of_network_04_g2(1:end-1,1:size(A1g_n4,2));
    A2e_n4 = incidence_matrix_of_network_04_g2(1:end-1,size(A1g_n4,2)+1:end); 
    %incidence_matrix_of_network_04 = [incidence_matrix_of_network_04_g1, zeros(size(incidence_matrix_of_network_04_g1,1),1);
     %                                 incidence_matrix_of_network_04_g2];

end
