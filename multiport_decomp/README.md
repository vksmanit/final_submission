# final_submission
-----------------------------------------------------------------------------------
This code is written by Vipin Kumar Soni (Indian Institute of Technology, Bombay).
I would like to express my deepest gratitude to Prof. Sachin Patkar and Prof. H.
Narayanan (IIT Bombay).
Also I would like to thank Mandar Sir and Vinay Sir for thier guidance. 
-----------------------------------------------------------------------------------

These code written for multiport decomposition idea for network consisting of RJ circuit using Two-Graph Method (Gaurav Trivedi).

This code is compatibe to Berkeley Model and Algorithm Prototyping Platform (MAPP). 
github source -> https://github.com/jaijeet/MAPP

Prerequisite : Some basic knowledge of MAPP (i.e. How to Start, How to set PATHs etc.)

To run these code, I am giving a example;

-- Set the current directory in MAPP, where all these codes are present.

Now onwards in MATLAB/OCTAVE promp -> 

>> cktnetlist = multiport_decomp_ckt_01();

The multiport_decomp_partition_simple.m file return the partition of network N into multiports. 
This is hardcoded partition. Hence just edit it and enable only partition of ckt-01. 
After that run the file in MATLAB

>> [vg, ig] = multiport_decomp_solution_of_network(cktnetlist)

After running this matlab function, we will get the solution of network;

Also to get more deep information - That what individual function is doing, just type 


>> help function_name

For example; what multiport_decomp_G_and_b_of_network_01.m is doing ??

>> help multiport_decomp_G_and_b_of_network_01

MATLAB command window will show -> 

 --------------------------------------------------------------------------------
  Syntax: [i_p1, G_p1] =  multiport_decomp_G_and_b_of_network_01(cktnetlist)
   
    This function will return the short circuit current and conductance matrix
     of multiport network 01.
      --------------------------------------------------------------------------------





