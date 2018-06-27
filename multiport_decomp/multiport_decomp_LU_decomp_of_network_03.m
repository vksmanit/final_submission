function [L,U] = multiport_decomp_LU_decomp_of_network_03(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax : [L_n3, U_n3] = multiport_decomp_LU_decomp_of_network_03(cktnetlist) 
%
% This funciton will return LU decomposition of coefficient matrix of 
% multiport network 03.
% --------------------------------------------------------------------------------
    incidence_matrix_of_network_03_g1 = multiport_decomp_incidence_matrix_for_network_03_g1(cktnetlist);
    A1g_n3 = incidence_matrix_of_network_03_g1(1:end-1,:);
    [G_n3, J_n3] = multiport_decomp_G_and_J_of_network_03(cktnetlist);
    coeff_matrix = A1g_n3 * G_n3 * A1g_n3';
    [L,U] = multiport_decomp_lu(coeff_matrix);
end
