function [i_p1, G_p1] =  multiport_decomp_G_and_b_of_network_01(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax: [i_p1, G_p1] =  multiport_decomp_G_and_b_of_network_01(cktnetlist)
% 
% This function will return the short circuit current and conductance matrix
% of multiport network 01.
% --------------------------------------------------------------------------------


    [G_n1, J_n1] = multiport_decomp_G_and_J_of_network_01(cktnetlist);
    [A1g_n1, A2g_n1, A2e_n1] = multiport_decomp_incidence_matrix_for_network_01(cktnetlist);

   %equation_5_matrix = A1g_n1 * G_n1 * A1g_n1';
   %v_n1 = equation_5_matrix\(-A1g_n1 *J_n1);   
   %i_p1 = A2e_n1\(-A2g_n1 * G_n1 * A1g_n1' * v_n1 - A2g_n1 * J_n1);
   %v_n1 = equation_5_matrix \ (- A1g_n1 * G_n1 * A2g_n1' * inv(A2e_n1')); 
   %G_p1 = inv(A2e_n1) * (-A2g_n1 * G_n1 *(A1g_n1' * v_n1 + A2g_n1' * inv(A2e_n1')));
    size_of_A2e_n1 = size(A2e_n1);
    v_E = eye(size_of_A2e_n1);
    M = A1g_n1 * G_n1 * A1g_n1';
    v_n1 = M\(-A1g_n1 * G_n1 * A2g_n1' * (A2e_n1'\v_E));
    %G_p1 = A2e_n1 \ (-A2g_n1 * G_n1 *(A1g_n1' * v_n1 + A2g_n1' * inv(A2e_n1')));
    G_p1 = A2e_n1 \ (-A2g_n1 * G_n1 *(A1g_n1' * v_n1 + A2g_n1' * (A2e_n1'\v_E)));
    %%%% for short ckt current %%%
    v_n1 = M\(-A1g_n1 * J_n1);
    i_p1 = A2e_n1 \ (-A2g_n1 * G_n1 * A1g_n1' * v_n1 - A2g_n1 *  J_n1); 
end
