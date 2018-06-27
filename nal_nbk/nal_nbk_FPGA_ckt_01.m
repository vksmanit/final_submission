function cktnetlist = nal_nbk_FPGA_ckt_01()
% --------------------------------------------------------------------------------
% Syntax : cktnetlist = nal_nbk_FPGA_ckt_01()
%
% This will result an example ckt which we will use to illustrate the FPGA NALNBK 
% solution method for solving a circuit in real time.
% --------------------------------------------------------------------------------

% ------------------------------ written : Mar 05, 2018 --------------------------

    clear cktnetlist ;
    cktnetlist.cktname = 'nal_nbk_FPGA_ckt_01';
    cktnetlist.nodenames = {'1','2','3','4','5','6'};
    cktnetlist.groundnodename = 'gnd';  
    rM = resModSpec();
    iM = isrcModSpec();
    vM = vsrcModSpec();
    % -----------------------------------------------------------------------
    cktnetlist = add_element(cktnetlist, iM, 'I1', {'1','2'}, {}, {{'DC', 0.001}});
    cktnetlist = add_element(cktnetlist, rM, 'R2', {'1','3'}, {{'R', 100}});
    cktnetlist = add_element(cktnetlist, rM, 'R3', {'2','3'}, {{'R', 100}});
    cktnetlist = add_element(cktnetlist, rM, 'R4', {'2','4'}, {{'R', 100}});
    cktnetlist = add_element(cktnetlist, rM, 'R5', {'3','4'}, {{'R', 100}});
    % -----------------------------------------------------------------------
    cktnetlist = add_element(cktnetlist, rM, 'R6', {'3','gnd'}, {{'R', 10000}});    
    cktnetlist = add_element(cktnetlist, rM, 'R7', {'2','5'}, {{'R', 10000}});    
    cktnetlist = add_element(cktnetlist, rM, 'R8', {'4','5'}, {{'R', 10000}}) ;   
    cktnetlist = add_element(cktnetlist, rM, 'R9', {'4','gnd'}, {{'R', 10000}}); 
    cktnetlist = add_element(cktnetlist, vM, 'V10', {'5', 'gnd'},{},{{'DC', 10}});
    cktnetlist = add_element(cktnetlist, rM, 'R11', {'5','6'}, {{'R', 10000}});    
    cktnetlist = add_element(cktnetlist, rM, 'R12', {'6','gnd'}, {{'R', 10000}});
    cktnetlist ;

end 
