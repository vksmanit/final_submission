function [i_p3, G_p3] =  multiport_decomp_G_and_b_of_network_03(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax: [i_p3, G_p3] =  multiport_decomp_G_and_b_of_network_03(cktnetlist)
% 
% This function will return the short circuit current and conductance matrix
% of multiport network 03.
% --------------------------------------------------------------------------------


    [G_n3, J_n3] = multiport_decomp_G_and_J_of_network_03(cktnetlist);
    [A1g_n3, A2g_n3, A2e_n3] = multiport_decomp_incidence_matrix_for_network_03(cktnetlist);

   %equation_5_matrix = A1g_n3 * G_n3 * A1g_n3';
   %v_n3 = equation_5_matrix\(-A1g_n3 *J_n3);   
   %i_p3 = A2e_n3\(-A2g_n3 * G_n3 * A1g_n3' * v_n3 - A2g_n3 * J_n3);
   %v_n3 = equation_5_matrix \ (- A1g_n3 * G_n3 * A2g_n3' * inv(A2e_n3')); 
   %G_p3 = inv(A2e_n3) * (-A2g_n3 * G_n3 *(A1g_n3' * v_n3 + A2g_n3' * inv(A2e_n3')));
    size_of_A2e_n3 = size(A2e_n3);
    v_E = eye(size_of_A2e_n3);
    M = A1g_n3 * G_n3 * A1g_n3';
    v_n3 = M\(-A1g_n3 * G_n3 * A2g_n3' * (A2e_n3'\v_E));
    %G_p3 = A2e_n3 \ (-A2g_n3 * G_n3 *(A1g_n3' * v_n3 + A2g_n3' * inv(A2e_n3')));
    G_p3 = A2e_n3 \ (-A2g_n3 * G_n3 *(A1g_n3' * v_n3 + A2g_n3' * (A2e_n3'\v_E)));
    %%%% for short ckt current %%%
    v_n3 = M\(-A1g_n3 * J_n3);
    i_p3 = A2e_n3 \ (-A2g_n3 * G_n3 * A1g_n3' * v_n3 - A2g_n3 *  J_n3); 
end
