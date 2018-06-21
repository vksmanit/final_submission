# final_submission
-----------------------------------------------------------------------------------
This code is written by Vipin Kumar Soni (Indian Institute of Technology, Bombay).
I would like to express my deepest gratitude to Prof. Sachin Patkar and Prof. H.
Narayanan (IIT Bombay).
Also I would like to thank Mandar Sir and Vinay Sir for thier guidance. 
-----------------------------------------------------------------------------------

This code contain the idea of NAL-NBK method to solve the netowrk consisting of 
linear devices (RVJ circuit) (Ref (Book) : Submodular Functions and Electrical Networks);

This code is compatibe to Berkeley Model and Algorithm Prototyping Platform (MAPP). 
github source -> https://github.com/jaijeet/MAPP

Prerequisite : Some basic knowledge of MAPP (i.e. How to Start, How to set PATHs etc.)

To run these code, I am giving a example;

-- Set the current directory in MAPP, where all these codes are present.

Now onwards in MATLAB/OCTAVE prompt ->
>> cktnetlist = nal_nbk_FPGA_ckt_01();
>> [vg, ig] = nal_nbk_solution(cktnetlist);

After running these two matlab function, we will get the solution of network;

Also to get more deep information - That what individual function is doing, just type 

>> help function_name

For example; what nal_nbk_solution.m is doing ??
>> help nal_nbk_solution

MATLAB command window will show -> 
  Syntax : [vg, ig] = nal_nbk_solution(cktnetlist)
  This function will return the final solution of cktnetlist. This solution is 
  [vg, ig] vectors, where vg is potential difference across each devices and 
  ig is current through that device.


