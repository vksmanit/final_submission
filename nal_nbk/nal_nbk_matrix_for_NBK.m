function [RB, EB, JB] = nal_nbk_matrix_for_NBK(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax :- [RB,EB,JB] = nal_nbk_matrix_for_NBK(cktnetlist)
% 
% This function will return the Resistance Matrix(RB), Voltage Matrix (VB) and 
% Current Matrix (JB) for network NBK i.e. G.(BUK)
% 
% This function and nal_nbk_matrix_for_NAL is combined and written on funciton 
% nal_nbk_matrix_for_NAL_and_NBK to eliminate number of loop iteration.
% The funciton nal_nbk_matrix_for_NAL_and_NBK, used in MCG, where is returns
% only RB and EA for NBK network b/z JB is always zeros vector and not used in MCG.
% --------------------------------------------------------------------------------

% ----------------------------- written on : Mar 13, 2018 ------------------------- 
% ----------------------------- Modified on : Apr 17, 2018 ------------------------- 

     nal_nbk_A_and_B_part = nal_nbk_partition(cktnetlist) ;
     N = length(cktnetlist.elements);
     dimension_of_matrix_A = length(find((nal_nbk_A_and_B_part)));
     dimension_of_matrix_B = N - dimension_of_matrix_A;
     temp_RB  = sparse(zeros(dimension_of_matrix_B,1)); %sparse(zeros(N));
     temp_EB  = sparse(zeros(dimension_of_matrix_B,1));
     temp_JB  = sparse(zeros(dimension_of_matrix_B,1));
    % temp_RB  = sparse(zeros(dimension_of_matrix_B,1)); %sparse(zeros(N));
    % temp_EB  = sparse(zeros(dimension_of_matrix_B,1));
    % temp_JB  = sparse(zeros(dimension_of_matrix_B,1));
    % max_iter = length(RB); 
     index_for_B= 1;
     for i = 1:N %min(find(not(nal_nbk_A_and_B_part))) : max(find(not(nal_nbk_A_and_B_part)))
     if (nal_nbk_A_and_B_part(i) == 0)
         if (strcmp(cktnetlist.elements{i}.name(1),'R'))
             resistance_value = cell2mat(cktnetlist.elements{i}.parms);
             temp_RB(index_for_B) = resistance_value;
         end

         if (strcmp(cktnetlist.elements{i}.name(1),'V'))
             voltage_souce_value = cktnetlist.elements{i}.udata{1}.QSSval;
             temp_EB(index_for_B) = voltage_souce_value;
         end

         if (strcmp(cktnetlist.elements{i}.name(1),'I'))
             current_souce_value = cktnetlist.elements{i}.udata{1}.QSSval;
             temp_JB(index_for_B) = current_souce_value;
         end
         index_for_B = index_for_B + 1; %index_for_matrix = index_for_matrix + 1; 
     end
     end
     RB = diag(temp_RB);
     JB = temp_JB;
     EB = temp_EB;
end
