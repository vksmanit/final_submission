function cktnetlist = multiport_decomp_ckt_04()
% --------------------------------------------------------------------------------
% Syntax : cktnetlist = multiport_decomp_ckt_04()
%
% This function will return an example ckt which we will use to illustrate 
% multiport decomposition method.
% --------------------------------------------------------------------------------

% ----------------------------- written on : May 22, 2018 ------------------------

    clear cktnetlist;
    cktnetlist.cktname= 'multiport_decomp_ckt_04';
    cktnetlist.nodenames = {'1','2','3','4','5','6','7','8','9','10'};
    cktnetlist.groundnodename = 'gnd';
    rM = resModSpec();
    iM = isrcModSpec();
    vM = vsrcModSpec();
    % ------------------------------- A-PART --------------------------------
    cktnetlist = add_element(cktnetlist, rM, 'R1', {'1','2'}, {{'R', 2000}});
    %cktnetlist = add_element(cktnetlist, iM, 'I1', {'1','2'}, {}, {{'DC', 0.01}});
    cktnetlist = add_element(cktnetlist, rM, 'R2', {'1','3'}, {{'R', 2000}});
    cktnetlist = add_element(cktnetlist, rM, 'R3', {'2','3'}, {{'R', 2000}});
    cktnetlist = add_element(cktnetlist, rM, 'R4', {'2','4'}, {{'R', 2000}});
    %cktnetlist = add_element(cktnetlist, rM, 'R5', {'3','4'}, {{'R', 2000}});
    cktnetlist = add_element(cktnetlist, iM, 'I5', {'3','4'}, {}, {{'DC', 0.002}});
    cktnetlist = add_element(cktnetlist, rM, 'R6', {'1','5'}, {{'R', 2000}});
    cktnetlist = add_element(cktnetlist, rM, 'R7', {'2','6'}, {{'R', 2000}});
    cktnetlist = add_element(cktnetlist, rM, 'R8', {'4','10'}, {{'R', 2000}});
    cktnetlist = add_element(cktnetlist, rM, 'R9', {'3','9'}, {{'R', 2000}});
    % ------------------------------- B-PART --------------------------------
    cktnetlist = add_element(cktnetlist, rM, 'R10', {'5','6'}, {{'R', 1000}});
    cktnetlist = add_element(cktnetlist, iM, 'I11', {'5','7'}, {}, {{'DC', 0.001}});
    cktnetlist = add_element(cktnetlist, rM, 'R12', {'6','8'}, {{'R', 1000}});
    cktnetlist = add_element(cktnetlist, rM, 'R13', {'7','8'}, {{'R', 1000}});
    % ------------------------------- C-PART --------------------------------
    cktnetlist = add_element(cktnetlist, rM, 'R14', {'9','10'}, {{'R', 3000}});
    cktnetlist = add_element(cktnetlist, rM, 'R15', {'9','gnd'}, {{'R', 3000}});
    cktnetlist = add_element(cktnetlist, rM, 'R16', {'10','gnd'}, {{'R', 3000}});
    cktnetlist = add_element(cktnetlist, iM, 'I17', {'gnd','7'}, {}, {{'DC', 0.003}});
    cktnetlist;
end 
