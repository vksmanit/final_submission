function [GA, JA, RB, EB] = nal_nbk_matrix_for_NAL_and_NBK(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax :- [GA, JA, RB, EB] = nal_nbk_matrix_for_NAL_and_NBK(cktnetlist)
%
% This function will return Conductance Matrix (GA), Voltage Matrix (EA) and 
% Current Matrix (JA) for network NAL i.e. graph Gx(AUL).
% 
% Later this funciton is modified to eliminate the variable EA and JB for NAL and NBK
% network, because they are not used in calculation in modified Conjugate gradient.
% To get [GA, EA, JA] and [RB, EB, JB] goto function nal_nbk_matrix_for_NAL and 
% nal_nbk_matrix_for_NBK respectively.
% --------------------------------------------------------------------------------

% ----------------------------- written on : Apr 18, 2018 ------------------------- 
% ----------------------------- Modified on : Apr 22, 2018 ------------------------- 

     nal_nbk_A_and_B_part = nal_nbk_partition(cktnetlist) ;
     N = length(cktnetlist.elements);
     dimension_of_matrix_A = length(find((nal_nbk_A_and_B_part))); 
     dimension_of_matrix_B = N - dimension_of_matrix_A;
     temp_GA  = sparse([]);%sparse(zeros(dimension_of_matrix_A,1)); 
     temp_RB  = sparse([]); %sparse(zeros(dimension_of_matrix_B,1)); 
     %temp_EA  = sparse(zeros(dimension_of_matrix_A,1));
     temp_EB  = sparse(zeros(dimension_of_matrix_B,1));
     temp_JA  = sparse(zeros(dimension_of_matrix_A,1));
     %temp_JB  = sparse(zeros(dimension_of_matrix_B,1));
     %temp_GA  = ([]);%sparse(zeros(dimension_of_matrix_A,1)); 
     %temp_RB  = ([]); %sparse(zeros(dimension_of_matrix_B,1)); 
     %temp_EA  = (zeros(dimension_of_matrix_A,1));
     %temp_EB  = (zeros(dimension_of_matrix_B,1));
     %temp_JA  = (zeros(dimension_of_matrix_A,1));
     %temp_JB  = (zeros(dimension_of_matrix_B,1));
     index_for_A = 1; 
     index_for_GA = 1;
     index_for_B = 1; 
     index_for_RB = 1; % consider it to make GA and RA as non singular
     for i = 1:N %length(cktnetlist.elements)
        if (nal_nbk_A_and_B_part(i) == 1) 
            if (strcmp(cktnetlist.elements{i}.name(1),'R'))
                resistance_value = cell2mat(cktnetlist.elements{i}.parms);
                temp_GA(index_for_GA) = 1/resistance_value;
                index_for_GA = index_for_GA + 1;
            end

            % we can eliminate this part, b/z we know that we are not gonna have any voltage source in NAL
           %if (strcmp(cktnetlist.elements{i}.name(1),'V'))
           %    voltage_souce_value = cktnetlist.elements{i}.udata{1}.QSSval;
           %    temp_EA(index_for_A) = voltage_souce_value;
           %end

            if (strcmp(cktnetlist.elements{i}.name(1),'I'))
                current_souce_value = cktnetlist.elements{i}.udata{1}.QSSval;
                temp_JA(index_for_A) = current_souce_value;
            end
               index_for_A = index_for_A + 1;
        else 
            if (strcmp(cktnetlist.elements{i}.name(1),'R'))
                resistance_value = cell2mat(cktnetlist.elements{i}.parms);
                temp_RB(index_for_RB) = resistance_value;
                index_for_RB = index_for_RB + 1;
            end
            if (strcmp(cktnetlist.elements{i}.name(1),'V'))
                voltage_souce_value = cktnetlist.elements{i}.udata{1}.QSSval;
                temp_EB(index_for_B) = voltage_souce_value;
            end

            % we can eliminate this part, b/z we know that we are not gonna have any current source in NBK
           %if (strcmp(cktnetlist.elements{i}.name(1),'I'))
           %    current_souce_value = cktnetlist.elements{i}.udata{1}.QSSval;
           %    temp_JB(index_for_B) = current_souce_value;
           %end
                index_for_B = index_for_B + 1; %
        end
     end

     GA = diag(temp_GA);
    % EA = temp_EA;
     JA = temp_JA;
     RB = diag(temp_RB);
     EB = temp_EB;
    % JB = temp_JB;
end
