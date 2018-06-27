function [vg, ig] = multiport_decomp_solution_of_network(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax : [vg, ig] = multiport_decomp_solution_of_network(cktnetlist)
%
% This function will give complete solution of network.
% --------------------------------------------------------------------------------

    [partition_simple, number_of_partition]  = multiport_decomp_partition_simple(cktnetlist);
    %partition_simple = multiport_decomp_partition_simple(cktnetlist);
    [v_nP, ArP] = multiport_decomp_port_potential(cktnetlist);
    %%%%%%%%%%%%% for A-Part %%%%%%%%%%%%%%%
    if (number_of_partition == 2)
        [L_n1, U_n1] = multiport_decomp_LU_decomp_of_network_01(cktnetlist);
        [A1g_n1, A2g_n1, A2e_n1] = multiport_decomp_incidence_matrix_for_network_01(cktnetlist);
        [G_n1, J_n1] = multiport_decomp_G_and_J_of_network_01(cktnetlist);
        number_of_ports_in_n1 = size(A2e_n1,1);

        %%%%%%%%%%%%% for B-Part %%%%%%%%%%%%%%%
        [L_n2, U_n2] = multiport_decomp_LU_decomp_of_network_02(cktnetlist);
        [A1g_n2, A2g_n2, A2e_n2] = multiport_decomp_incidence_matrix_for_network_02(cktnetlist);
        [G_n2, J_n2] = multiport_decomp_G_and_J_of_network_02(cktnetlist);
        number_of_ports_in_n2 = size(A2e_n2,1);
        
        
        ArP_n1 = [ArP(:,1:number_of_ports_in_n1)];
        vE_n1 = ArP_n1' * v_nP;
        vn_n1 = A2e_n1' \ vE_n1;
        rhs_n1 = -A1g_n1 * J_n1 - A1g_n1 * G_n1 * A2g_n1' * vn_n1;
        vn1_n1 = multiport_decomp_solution_of_system_using_lu(L_n1,U_n1,rhs_n1);
        vg_n1 = A1g_n1' * vn1_n1 + A2g_n1' * vn_n1;
        ig_n1 = J_n1 + G_n1 * vg_n1;


        ArP_n2 = [ArP(:, number_of_ports_in_n1 + 1 : number_of_ports_in_n1 + number_of_ports_in_n2)];
        vE_n2 = ArP_n2' * v_nP;
        vn_n2 = A2e_n2' \ vE_n2;
        rhs_n2 = -A1g_n2 * J_n2 - A1g_n2 * G_n2 * A2g_n2' * vn_n2;
        vn1_n2 = multiport_decomp_solution_of_system_using_lu(L_n2,U_n2,rhs_n2);
        vg_n2 = A1g_n2' * vn1_n2 + A2g_n2' * vn_n2;
        ig_n2 = J_n2 + G_n2 * vg_n2;

        vg = [vg_n1;vg_n2];
        ig = [ig_n1;ig_n2];
    elseif ( number_of_partition == 3) 
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        [L_n1, U_n1] = multiport_decomp_LU_decomp_of_network_01(cktnetlist);
        [A1g_n1, A2g_n1, A2e_n1] = multiport_decomp_incidence_matrix_for_network_01(cktnetlist);
        [G_n1, J_n1] = multiport_decomp_G_and_J_of_network_01(cktnetlist);
        number_of_ports_in_n1 = size(A2e_n1,1);

        %%%%%%%%%%%%% for B-Part %%%%%%%%%%%%%%%
        [L_n2, U_n2] = multiport_decomp_LU_decomp_of_network_02(cktnetlist);
        [A1g_n2, A2g_n2, A2e_n2] = multiport_decomp_incidence_matrix_for_network_02(cktnetlist);
        [G_n2, J_n2] = multiport_decomp_G_and_J_of_network_02(cktnetlist);
        number_of_ports_in_n2 = size(A2e_n2,1);
        
        
        ArP_n1 = [ArP(:,1:number_of_ports_in_n1)];
        vE_n1 = ArP_n1' * v_nP;
        vn_n1 = A2e_n1' \ vE_n1;
        rhs_n1 = -A1g_n1 * J_n1 - A1g_n1 * G_n1 * A2g_n1' * vn_n1;
        vn1_n1 = multiport_decomp_solution_of_system_using_lu(L_n1,U_n1,rhs_n1);
        vg_n1 = A1g_n1' * vn1_n1 + A2g_n1' * vn_n1;
        ig_n1 = J_n1 + G_n1 * vg_n1;


        ArP_n2 = [ArP(:, number_of_ports_in_n1 + 1 : number_of_ports_in_n1 + number_of_ports_in_n2)];
        vE_n2 = ArP_n2' * v_nP;
        vn_n2 = A2e_n2' \ vE_n2;
        rhs_n2 = -A1g_n2 * J_n2 - A1g_n2 * G_n2 * A2g_n2' * vn_n2;
        vn1_n2 = multiport_decomp_solution_of_system_using_lu(L_n2,U_n2,rhs_n2);
        vg_n2 = A1g_n2' * vn1_n2 + A2g_n2' * vn_n2;
        ig_n2 = J_n2 + G_n2 * vg_n2;

    %%%%%%%%%%%%% for ckt-04 %%%%%%%%%%%%
   
        [L_n3, U_n3] = multiport_decomp_LU_decomp_of_network_03(cktnetlist);
        [A1g_n3, A2g_n3, A2e_n3] = multiport_decomp_incidence_matrix_for_network_03(cktnetlist);
        [G_n3, J_n3] = multiport_decomp_G_and_J_of_network_03(cktnetlist);
        number_of_ports_in_n3 = size(A2e_n3,1);
        ArP_n3 = [ArP(:, number_of_ports_in_n1 + number_of_ports_in_n2 + 1 : number_of_ports_in_n1 + number_of_ports_in_n2 + number_of_ports_in_n3)] ;
        vE_n3 = ArP_n3' * v_nP;
        vn_n3 = A2e_n3' \ vE_n3;
        rhs_n3 = -A1g_n3 * J_n3 - A1g_n3 * G_n3 * A2g_n3' * vn_n3;
        vn1_n3 = multiport_decomp_solution_of_system_using_lu(L_n3,U_n3,rhs_n3);
        vg_n3 = A1g_n3' * vn1_n3 + A2g_n3' * vn_n3;
        ig_n3 = J_n3 + G_n3 * vg_n3;

        vg = [vg_n1;vg_n2;vg_n3];
        ig = [ig_n1;ig_n2;ig_n3];
    elseif (number_of_partition == 4)  
       %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
        [L_n1, U_n1] = multiport_decomp_LU_decomp_of_network_01(cktnetlist);
        [A1g_n1, A2g_n1, A2e_n1] = multiport_decomp_incidence_matrix_for_network_01(cktnetlist);
        [G_n1, J_n1] = multiport_decomp_G_and_J_of_network_01(cktnetlist);
        number_of_ports_in_n1 = size(A2e_n1,1);

        %%%%%%%%%%%%% for B-Part %%%%%%%%%%%%%%%
        [L_n2, U_n2] = multiport_decomp_LU_decomp_of_network_02(cktnetlist);
        [A1g_n2, A2g_n2, A2e_n2] = multiport_decomp_incidence_matrix_for_network_02(cktnetlist);
        [G_n2, J_n2] = multiport_decomp_G_and_J_of_network_02(cktnetlist);
        number_of_ports_in_n2 = size(A2e_n2,1);
        
        
        ArP_n1 = [ArP(:,1:number_of_ports_in_n1)];
        vE_n1 = ArP_n1' * v_nP;
        vn_n1 = A2e_n1' \ vE_n1;
        rhs_n1 = -A1g_n1 * J_n1 - A1g_n1 * G_n1 * A2g_n1' * vn_n1;
        vn1_n1 = multiport_decomp_solution_of_system_using_lu(L_n1,U_n1,rhs_n1);
        vg_n1 = A1g_n1' * vn1_n1 + A2g_n1' * vn_n1;
        ig_n1 = J_n1 + G_n1 * vg_n1;


        ArP_n2 = [ArP(:, number_of_ports_in_n1 + 1 : number_of_ports_in_n1 + number_of_ports_in_n2)];
        vE_n2 = ArP_n2' * v_nP;
        vn_n2 = A2e_n2' \ vE_n2;
        rhs_n2 = -A1g_n2 * J_n2 - A1g_n2 * G_n2 * A2g_n2' * vn_n2;
        vn1_n2 = multiport_decomp_solution_of_system_using_lu(L_n2,U_n2,rhs_n2);
        vg_n2 = A1g_n2' * vn1_n2 + A2g_n2' * vn_n2;
        ig_n2 = J_n2 + G_n2 * vg_n2;


        [L_n3, U_n3] = multiport_decomp_LU_decomp_of_network_03(cktnetlist);
        [A1g_n3, A2g_n3, A2e_n3] = multiport_decomp_incidence_matrix_for_network_03(cktnetlist);
        [G_n3, J_n3] = multiport_decomp_G_and_J_of_network_03(cktnetlist);
        number_of_ports_in_n3 = size(A2e_n3,1);
        ArP_n3 = [ArP(:, number_of_ports_in_n1 + number_of_ports_in_n2 + 1 : number_of_ports_in_n1 + number_of_ports_in_n2 + number_of_ports_in_n3)] ;
        vE_n3 = ArP_n3' * v_nP;
        vn_n3 = A2e_n3' \ vE_n3;
        rhs_n3 = -A1g_n3 * J_n3 - A1g_n3 * G_n3 * A2g_n3' * vn_n3;
        vn1_n3 = multiport_decomp_solution_of_system_using_lu(L_n3,U_n3,rhs_n3);
        vg_n3 = A1g_n3' * vn1_n3 + A2g_n3' * vn_n3;
        ig_n3 = J_n3 + G_n3 * vg_n3;

        [L_n4, U_n4] = multiport_decomp_LU_decomp_of_network_04(cktnetlist);
        [A1g_n4, A2g_n4, A2e_n4] = multiport_decomp_incidence_matrix_for_network_04(cktnetlist);
        [G_n4, J_n4] = multiport_decomp_G_and_J_of_network_04(cktnetlist);
        number_of_ports_in_n4 = size(A2e_n4,1);
        ArP_n4 = [ArP(:, number_of_ports_in_n1 + number_of_ports_in_n2 + number_of_ports_in_n3 + 1 : number_of_ports_in_n1 + number_of_ports_in_n2 + number_of_ports_in_n3 +  number_of_ports_in_n4)] ;
        vE_n4 = ArP_n4' * v_nP;
        vn_n4 = A2e_n4' \ vE_n4;
        rhs_n4 = -A1g_n4 * J_n4 - A1g_n4 * G_n4 * A2g_n4' * vn_n4;
        vn1_n4 = multiport_decomp_solution_of_system_using_lu(L_n4,U_n4,rhs_n4);
        vg_n4 = A1g_n4' * vn1_n4 + A2g_n4' * vn_n4;
        ig_n4 = J_n4 + G_n4 * vg_n4;
        vg = [vg_n1;vg_n2;vg_n3;vg_n4];
        ig = [ig_n1;ig_n2;ig_n3;ig_n4];
    end

end
