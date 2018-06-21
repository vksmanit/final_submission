function [A, B, mcg_index, ArNAL, BbNBK] = nal_nbk_hybrid_analysis_equation(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax : [A, B, mcg_index] = nal_nbk_hybrid_analysis_equation(cktnetlist)
% 
% This function will return the final equation which is used to solve using 
% Modified Conjugate Gradient (MCG). 
%
% It also return a term mcg_index which is used in modified conjugate gradient.
%
% It is modified to return incidence matrix for NAL and loop matrix for NBK.
% These matrix used in nal_nbk_solution of network to calculate [vg, ig]. 
% Syntax : [A, B, mcg_index, ArNAL, BbNBK] = nal_nbk_hybrid_analysis_equation(cktnetlist)
% --------------------------------------------------------------------------------

% ---------------------------- written on : Apr 01, 2018 -------------------------
% ---------------------------- modified on : Jun 20, 2018 ------------------------

    loop_matrix_for_NBK = nal_nbk_loop_matrix_for_NBK(cktnetlist);
    incidence_matrix_for_NAL = nal_nbk_incidence_matrix_for_NAL(cktnetlist);
    incidence_matrix_for_NAL = incidence_matrix_for_NAL(1:end-1, :);
    L_branch = nal_nbk_L_branch_hybrid_analysis(cktnetlist);
    K_branch = nal_nbk_K_branch_hybrid_analysis(cktnetlist);
    partition = nal_nbk_partition(cktnetlist);
  %  [GA,EA,JA] = nal_nbk_matrix_for_NAL(cktnetlist);
    [GA,JA, RB, EB] = nal_nbk_matrix_for_NAL_and_NBK(cktnetlist);
    %[GA, EA, JA, RB, EB, JB] = nal_nbk_matrix_for_NAL_and_NBK(cktnetlist);
   % [RB,EB,JB] = nal_nbk_matrix_for_NBK(cktnetlist);
   ArA= sparse([]);
   Bb = sparse([]);
   ArL =sparse([]);
   BK = sparse([]);
   ArK =sparse([]);
   BL = sparse([]);
   ArA_right_side = sparse([]);
   Bb_right_side = sparse([]);
   %ArA= ([]);
   %Bb = ([]);
   %ArL =([]);
   %BK = ([]);
   %ArK =([]);
   %BL = ([]);
   %ArA_right_side = ([]);
   %Bb_right_side = ([]);
    index = 1;
   % index_for_ArA = 1;
    for item = partition 
        if (item == 1 & not(strcmp(cktnetlist.elements{index}.name(1),'I'))) 
            ArA = [ArA, incidence_matrix_for_NAL(:,index)];
        elseif(item == 0 & not(strcmp(cktnetlist.elements{index}.name(1),'V')))
            Bb = [Bb, loop_matrix_for_NBK(:,index)];
        end
        if item == 1
            ArA_right_side = [ArA_right_side, incidence_matrix_for_NAL(:,index)];
        elseif item == 0 
            Bb_right_side = [Bb_right_side, loop_matrix_for_NBK(:,index)];
        end
        index = index + 1;
    end
    for item = L_branch
        ArL = [ArL,incidence_matrix_for_NAL(:,item)];
        BL = [BL, loop_matrix_for_NBK(:,item)];
    end
    for item = K_branch
        BK = [BK,loop_matrix_for_NBK(:,item)];
        ArK = [ArK, incidence_matrix_for_NAL(:,item)];
    end

    ArNAL = ArA_right_side;
    BbNBK = Bb_right_side;
    A_left_top = ArA * GA * ArA';
    A_left_bottom = BK * ArK';
    A_right_top = ArL * BL';
    A_right_bottom = Bb * RB * Bb' ;
    A = [A_left_top, A_right_top; A_left_bottom, A_right_bottom];
%    B_top = ArA * GA * EA - ArA * JA;
    B_top = - ArA_right_side * JA;
%    B_bottom = Bb * RB * JB - Bb * EB;
    B_bottom = - Bb_right_side * EB;
    B = [B_top;B_bottom];

    mcg_index = size(A_left_bottom,2);
                                       
end
