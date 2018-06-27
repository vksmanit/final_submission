function [v_nP, ArP]  = multiport_decomp_port_potential(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax : [v_nP, ArP] = multiport_decomp_port_potential(cktnetlist);
%
% This function will return port node potential vector v_nP. 
% This node potential can be used to calculate potential difference 
% across the port terminals.
%
% It is also modified to return reduced incidence matrix of port connection 
% diagram. 
% --------------------------------------------------------------------------------

    %ArP = multiport_decomp_incidence_matrix_for_port(cktnetlist);
    ArP = multiport_decomp_port(cktnetlist);
    ArP = ArP(1:end-1,:);
    [i_p1, G_p1] =  multiport_decomp_G_and_b_of_network_01(cktnetlist);
    [i_p2, G_p2] =  multiport_decomp_G_and_b_of_network_02(cktnetlist);
   % G = blkdiag(G_p1, G_p2 );
   % b = [i_p1;i_p2];
    %%%%%%%% for ckt-04 %%%%%%%%%%
    %{
    [i_p3, G_p3] =  multiport_decomp_G_and_b_of_network_03(cktnetlist);
    G = blkdiag(G_p1, G_p2, G_p3);
    b = [i_p1;i_p2;i_p3];
    %}

    % this below matrix can be solved using conjugate gradient method 
    % as this matrix is symmetirc 
    
    %%%%%%%%%%%%%%%% for ckt-05 %%%%%%%%%%%%%%%%%%%%
    [i_p3, G_p3] =  multiport_decomp_G_and_b_of_network_03(cktnetlist);
    [i_p4, G_p4] =  multiport_decomp_G_and_b_of_network_04(cktnetlist);
    G = blkdiag(G_p1, G_p2, G_p3,G_p4);
    b = [i_p1;i_p2;i_p3;i_p4];



    v_nP = (ArP * G * ArP')\(-ArP * b);


end


