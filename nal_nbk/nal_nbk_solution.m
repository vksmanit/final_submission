function [vg, ig] = nal_nbk_solution(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax : [vg, ig] = nal_nbk_solution(cktnetlist)
% This function will return the final solution of cktnetlist. This solution is 
% [vg, ig] vectors, where vg is potential difference across each devices and 
% ig is current through that device.
% --------------------------------------------------------------------------------

% ---------------------- Written On : Jun 21, 2017 -------------------------------

    
    [A, B, mcg_index, ArNAL, BbNBK] = nal_nbk_hybrid_analysis_equation(cktnetlist);
    [GA,EA,JA] = nal_nbk_matrix_for_NAL(cktnetlist);
    [RB,EB,JB] = nal_nbk_matrix_for_NBK(cktnetlist);
    nal_nbk_A_and_B_part = nal_nbk_partition(cktnetlist);
    %%% number of elements in network %%%
    size_of_solution = length(nal_nbk_A_and_B_part);
    vg = zeros(size_of_solution, 1);
    ig = zeros(size_of_solution, 1);

    x = nal_nbk_mcg(A,B,mcg_index);
    %% node potential vN and loop currents of NAL and NBK network respectively.
    vN = x(1:mcg_index);
    iL = x(mcg_index+1:end);
    %%% potential difference (current) across(through) each device in A-Part;
    vg_A = ArNAL' * vN;
    ig_A = GA * vg_A + JA;
    %%% potential difference (current) across(through) each device in B-Part;
    ig_B = BbNBK' * iL;
    vg_B = RB * ig_B + EB;
    %%%%%%%%%%%%%%%%%%%%%%%%%%% final solution %%%%%%%%%%%%%%%%%%%
    index_for_A = 1;
    index_for_B = 1;
    for i= 1:size_of_solution
         if nal_nbk_A_and_B_part(i) == 1
             vg(i) = vg_A(index_for_A);
             ig(i) = ig_A(index_for_A);
             index_for_A = index_for_A + 1;
         else 
             vg(i) = vg_B(index_for_B);
             ig(i) = ig_B(index_for_B);
             index_for_B = index_for_B + 1;
         end
           % vg = [vg_A;vg_B];
           % ig = [ig_A;ig_B];
    end
   % vg = [vg_temp';vg_B];
   % ig = [ig_temp';ig_B];
end
