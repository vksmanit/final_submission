function [L,U] = multiport_decomp_LU_decomp_of_network_01(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax : [L_n2, U_n2] = multiport_decomp_LU_decomp_of_network_02(cktnetlist) 
%
% This funciton will return LU decomposition of coefficient matrix of 
% multiport network 02.
% --------------------------------------------------------------------------------
    incidence_matrix_of_network_02_g1 = multiport_decomp_incidence_matrix_for_network_02_g1(cktnetlist);
    A1g_n2 = incidence_matrix_of_network_02_g1(1:end-1,:);
    [G_n2, J_n2] = multiport_decomp_G_and_J_of_network_02(cktnetlist);
    coeff_matrix = A1g_n2 * G_n2 * A1g_n2';
    [L,U] = multiport_decomp_lu(coeff_matrix);
end
