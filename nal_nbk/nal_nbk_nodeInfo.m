function nodeInfo = nal_nbk_nodeInfo(circuitdata)
% --------------------------------------------------------------------------------
% Syntax : nodeInfo = nal_nbk_nodeInfo(cktnetlist)
%
% function nodeInfo return node connection information along with name,
% elements,connection
% 
% Enter 'nodeInfo{:}' to see the conncetion, without 'colon'
% --------------------------------------------------------------------------------

%%%%%%%%%%%%%%%%%%%%%%%% August 24, 2017 %%%%%%%%%%%%%%%%%%%%%%%%%%%

    for i = 1:length(circuitdata.nodenames)

        nodeInfo{i}.name = circuitdata.nodenames(i);
        for j = 1 : length(circuitdata.elements)
            nodeInfo{i}.connection{j} = strcmp (nodeInfo{i}.name, circuitdata.elements{j}.nodes); 
            nodeInfo{i}.elements{j}   = circuitdata.elements{j}.name ; %% can we optimize here
        end
    end
        
    % modifing it to add 'gnd' node connection 
    % modified by (21/09/2017)

    nodeInfo{i+1}.name = circuitdata.groundnodename;
    for j = 1 : length(circuitdata.elements)
        nodeInfo{i+1}.connection{j} = strcmp (nodeInfo{i+1}.name, circuitdata.elements{j}.nodes);
        nodeInfo{i+1}.elements{j} = circuitdata.elements{j}.name;
    end


end 
