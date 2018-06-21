function graph_of_A = nal_nbk_graph_of_A(cktnetlist)
% --------------------------------------------------------------------------------
% Syntax : graph_of_A = nal_nbk_graph_of_A(cktnetlist)
%
% This function will return the graph_of_A, which is the graph of A_part
% Also it will plot the Graph of G.A 
% 
% This function used the graph class (availabe in R2015b) of MATLAB may not run in
% lower version of matlab and octave.
% --------------------------------------------------------------------------------

    
%-----------------------------written on : Sep 22, 2017---------------------------

    nal_nbk_A_and_B_part = nal_nbk_partition(cktnetlist);
    nodeInfo = nal_nbk_nodeInfo(cktnetlist); 
    s = [];
    t = [];
    G_dot_A = nal_nbk_A_and_B_part; 


    for i = 1:length(cktnetlist.elements) %iterating through each elements of cktnetlist
        if (G_dot_A(i) == 1)  %% this says that if it belongs to G.A then enter in the loop 
            s = [s , cktnetlist.elements{i}.nodes(1)];
            t = [t , cktnetlist.elements{i}.nodes(2)];
        end
    
    end
        graph_of_A = graph(s,t);
        plot(graph_of_A)
end

