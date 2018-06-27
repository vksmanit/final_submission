function cktnetlist = multiport_decomp_ckt_01()
% --------------------------------------------------------------------------------
% Syntax : cktnetlist = multiport_decomp_ckt_01()
%
% This function will return an example ckt which we will use to illustrate 
% multiport decomposition method.
% --------------------------------------------------------------------------------

% ----------------------------- written on : May 22, 2018 ------------------------

    clear cktnetlist;
    cktnetlist.cktname= 'multiport_decomp_ckt_01';
    cktnetlist.nodenames = {'1','2','3','4','5','6','7'};
    cktnetlist.groundnodename = 'gnd';
    rM = resModSpec();
    iM = isrcModSpec();
    vM = vsrcModSpec();
    % ------------------------------- A-PART --------------------------------
    cktnetlist = add_element(cktnetlist, iM, 'I1', {'1','2'}, {}, {{'DC', 0.001}});
    cktnetlist = add_element(cktnetlist, rM, 'R2', {'1','3'}, {{'R', 1000}});
    cktnetlist = add_element(cktnetlist, rM, 'R3', {'2','3'}, {{'R', 1000}});
    cktnetlist = add_element(cktnetlist, rM, 'R4', {'2','4'}, {{'R', 1000}});
    cktnetlist = add_element(cktnetlist, rM, 'R5', {'3','4'}, {{'R', 1000}});
    % ------------------------------- B-PART --------------------------------
    cktnetlist = add_element(cktnetlist, rM, 'R6', {'1','5'}, {{'R', 2000}});
    cktnetlist = add_element(cktnetlist, rM, 'R7', {'4','gnd'}, {{'R', 2000}});
    cktnetlist = add_element(cktnetlist, rM, 'R8', {'5','6'}, {{'R', 2000}});
    cktnetlist = add_element(cktnetlist, rM, 'R9', {'5','7'}, {{'R', 2000}});
    cktnetlist = add_element(cktnetlist, rM, 'R10', {'6','7'}, {{'R', 2000}});
    cktnetlist = add_element(cktnetlist, rM, 'R11', {'6','gnd'}, {{'R', 2000}});
    cktnetlist = add_element(cktnetlist, rM, 'R12', {'7','gnd'}, {{'R', 2000}});
    cktnetlist;
end 
