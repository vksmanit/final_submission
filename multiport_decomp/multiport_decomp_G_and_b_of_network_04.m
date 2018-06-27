function [i_p4, G_p4] =  multiport_decomp_G_and_b_of_network_04(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax: [i_p4, G_p4] =  multiport_decomp_G_and_b_of_network_04(cktnetlist)
% 
% This function will return the short circuit current and conductance matrix
% of multiport network 04.
% --------------------------------------------------------------------------------


    [G_n4, J_n4] = multiport_decomp_G_and_J_of_network_04(cktnetlist);
    [A1g_n4, A2g_n4, A2e_n4] = multiport_decomp_incidence_matrix_for_network_04(cktnetlist);

   %equation_5_matrix = A1g_n4 * G_n4 * A1g_n4';
   %v_n4 = equation_5_matrix\(-A1g_n4 *J_n4);   
   %i_p4 = A2e_n4\(-A2g_n4 * G_n4 * A1g_n4' * v_n4 - A2g_n4 * J_n4);
   %v_n4 = equation_5_matrix \ (- A1g_n4 * G_n4 * A2g_n4' * inv(A2e_n4')); 
   %G_p4 = inv(A2e_n4) * (-A2g_n4 * G_n4 *(A1g_n4' * v_n4 + A2g_n4' * inv(A2e_n4')));
    size_of_A2e_n4 = size(A2e_n4);
    v_E = eye(size_of_A2e_n4);
    M = A1g_n4 * G_n4 * A1g_n4';
    v_n4 = M\(-A1g_n4 * G_n4 * A2g_n4' * (A2e_n4'\v_E));
    %G_p4 = A2e_n4 \ (-A2g_n4 * G_n4 *(A1g_n4' * v_n4 + A2g_n4' * inv(A2e_n4')));
    G_p4 = A2e_n4 \ (-A2g_n4 * G_n4 *(A1g_n4' * v_n4 + A2g_n4' * (A2e_n4'\v_E)));
    %%%% for short ckt current %%%
    v_n4 = M\(-A1g_n4 * J_n4);
    i_p4 = A2e_n4 \ (-A2g_n4 * G_n4 * A1g_n4' * v_n4 - A2g_n4 *  J_n4); 
end
