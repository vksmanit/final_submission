function [L,U] = multiport_decomp_LU_decomp_of_network_01(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax : [L_n1, U_n1] = multiport_decomp_LU_decomp_of_network_01(cktnetlist) 
%
% This funciton will return LU decomposition of coefficient matrix of 
% multiport network 01.
% --------------------------------------------------------------------------------
    incidence_matrix_of_network_01_g1 = multiport_decomp_incidence_matrix_for_network_01_g1(cktnetlist);
    A1g_n1 = incidence_matrix_of_network_01_g1(1:end-1,:);
    [G_n1, J_n1] = multiport_decomp_G_and_J_of_network_01(cktnetlist);
    coeff_matrix = A1g_n1 * G_n1 * A1g_n1';
    [L,U] = multiport_decomp_lu(coeff_matrix);
end
