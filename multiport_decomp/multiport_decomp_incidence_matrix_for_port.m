function incidence_matrix_for_port = multiport_decomp_incidence_matrix_for_port(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax : incidence_matrix_for_port = multiport_decomp_incidence_matrix_for_port(cktnetlist)
% --------------------------------------------------------------------------------  
    [A1g_n1, A2g_n1, A2e_n1] = multiport_decomp_incidence_matrix_for_network_01(cktnetlist);
    [A1g_n2, A2g_n2, A2e_n2] = multiport_decomp_incidence_matrix_for_network_02(cktnetlist);    
    %incidence_matrix_for_port = [A2e_n1, A2e_n2];
    %%%%%%%%%% for ckt-04 %%%%%%%
    %{
    [A1g_n3, A2g_n3, A2e_n3] = multiport_decomp_incidence_matrix_for_network_03(cktnetlist);    
    sn1 = size(A2e_n1);
    sn2 = size(A2e_n2);
    sn3 = size(A2e_n3);
    a = max(max(sn1(1),sn2(1)),sn3(1));
    incidence_matrix_for_port = [[A2e_n1 ;zeros(abs([a 0]-sn1))],[A2e_n2;zeros(abs([a,0]-sn2))],[A2e_n3;zeros(abs([a,0]-sn3))]];
    %}

    %%%%%%%%%%%% for ckt-05 %%%%%%%%%%%%%%%%%%
    [A1g_n3, A2g_n3, A2e_n3] = multiport_decomp_incidence_matrix_for_network_03(cktnetlist);    
    [A1g_n4, A2g_n4, A2e_n4] = multiport_decomp_incidence_matrix_for_network_04(cktnetlist);    
    sn1 = size(A2e_n1);
    sn2 = size(A2e_n2);
    sn3 = size(A2e_n3);
    sn4 = size(A2e_n4);
    
    a = max(max(sn1(1),sn2(1)),max(sn3(1),sn4(1)));
    incidence_matrix_for_port = [[A2e_n1 ;zeros(abs([a 0]-sn1))],[A2e_n2;zeros(abs([a,0]-sn2))],[A2e_n3;zeros(abs([a,0]-sn3))],[A2e_n4;zeros(abs([a,0]-sn4))]];
      
end
