function [GA, EA, JA] = nal_nbk_matrix_for_NAL(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax :- [GA,EA,JA] = nal_nbk_matrix_for_NAL(cktnetlist)
%
% This function will return Conductance Matrix (GA), Voltage Matrix (EA) and 
% Current Matrix (JA) for network NAL i.e. graph Gx(AUL).
% 
% This function and nal_nbk_matrix_for_NBK is combined and written on funciton 
% nal_nbk_matrix_for_NAL_and_NBK to eliminate number of loop iteration.
% The function nal_nbk_matrix_for_NAL_and_NBK, used in MCG, where it returns only 
% GA and JA for NAL network b/z EA is always zeros vector and not used in MCG.
% --------------------------------------------------------------------------------

% ----------------------------- written on : Mar 13, 2018 ------------------------- 
% ----------------------------- Modified on : Apr 17, 2018 ------------------------- 

     nal_nbk_A_and_B_part = nal_nbk_partition(cktnetlist) ;
     dimension_of_matrix = length(find((nal_nbk_A_and_B_part)));% this is working fine for only this type of model but if we are having disconnected model then it won't work 
     N = length(cktnetlist.elements);
     temp_GA  = sparse(zeros(dimension_of_matrix,1));%sparse(zeros(N));
     temp_EA  = sparse(zeros(dimension_of_matrix,1));
     temp_JA  = sparse(zeros(dimension_of_matrix,1));
    % temp_GA  = (zeros(dimension_of_matrix,1));%sparse(zeros(N));
    % temp_EA  = (zeros(dimension_of_matrix,1));
    % temp_JA  = (zeros(dimension_of_matrix,1));
     index_for_A = 1; 
     for i = 1:N %length(cktnetlist.elements)
        if (nal_nbk_A_and_B_part(i) == 1) 
            if (strcmp(cktnetlist.elements{i}.name(1),'R'))
                resistance_value = cell2mat(cktnetlist.elements{i}.parms);
                temp_GA(index_for_A) = 1/resistance_value;
            end

            if (strcmp(cktnetlist.elements{i}.name(1),'V'))
                voltage_souce_value = cktnetlist.elements{i}.udata{1}.QSSval;
                temp_EA(index_for_A) = voltage_souce_value;
            end

            if (strcmp(cktnetlist.elements{i}.name(1),'I'))
                current_souce_value = cktnetlist.elements{i}.udata{1}.QSSval;
                temp_JA(index_for_A) = current_souce_value;
            end
               index_for_A = index_for_A + 1;
        end

     end

     GA = diag(temp_GA);
     EA = temp_EA;
     JA = temp_JA;
end
