function nal_nbk_A_and_B_part = nal_nbk_partition(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax : nal_nbk_A_and_B_part = nal_nbk_partition(cktnetlist) 
%
% This function will return the nal_nbl_A_and_B_part matrix 
% representing each element with the row index value equal to '1', if 
% it is belongs to the A-part otherwise it is in B-parts.
%
% I-source and Low resistances are kept in part A
% V-source and High resistances are kept in part B
% --------------------------------------------------------------------------------

% ------------------------ written on : Sep 21, 2017 -----------------------------
    
    number_of_element = length(cktnetlist.elements);
    nal_nbk_A_and_B_part = zeros(1,number_of_element);
    for i = 1:number_of_element %iterating through all the elements of cktnetlist
        %if (strcmp(cktnetlist.elements{i}.name(1), 'V')) %compare it if it is V-source
        if (strcmp(cktnetlist.elements{i}.name(1), 'I')) %compare it if it is I-source
            nal_nbk_A_and_B_part(i) = 1;
        end
        if (strcmp(cktnetlist.elements{i}.name(1), 'R')) %compare it if it is Resistance 
            if(cell2mat(cktnetlist.elements{i}.parms) <= 1000) 
                nal_nbk_A_and_B_part(i) = 1;
            end
        end
    end 
end
