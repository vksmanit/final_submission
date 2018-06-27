function [partition_simple, number_of_partition]  = multiport_decomp_partition_simple(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax : partition_simple = multiport_decomp_partition_simple(cktnetlist)
% 
% This function return the partition of network;
% This is very simple hardcoded partition.
%
% It is modified to return number of partition. (can be hardcoded also);
% Syntax : [partition_simple, number_of_partition]  = multiport_decomp_partition_simple(cktnetlist);
% --------------------------------------------------------------------------------

% -------------------------------- written on : May 23, 2018 ---------------------
    
   %%% partition_simple can be patition in more general or can be hardcoded %%%%%
    partition_simple =  [0 0 0 0 0 1 1 1 1 1 1 1]; % for ckt-01
   % partition_simple =  [0 0 0 0 0 1 1 1 1 1 1 1 1]; % for ckt-03
   % partition_simple =  [0 0 0 0 0 1 1 1 1 2 2 2 2]; % for ckt-03
   % partition_simple =  [0 0 0 0 0 1 1 1 1 1 2 2 2 3 3 3 3]; % for ckt-04
   % partition_simple =  [0 0 0 0 0 0 0 0 0 1 1 1 1 2 2 2 2]; % for ckt-04
   % partition_simple =  [0 0 0 0 0 0 0 0 0 1 1 1 1 2 2 2 2 2 2 2 2]; % for ckt-05
   % partition_simple =  [0 0 0 0 0 0 0 0 0 1 1 1 1 2 2 2 2 3 3 3 3]; % for ckt-05

     %%%%%%%%% number of partition can also be hardcoded %%%%%%%%%%%%
     number_of_partition = length(unique(partition_simple));
    
end 
