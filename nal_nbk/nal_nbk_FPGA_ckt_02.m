function cktnetlist = nal_nbk_FPGA_ckt_02()
% --------------------------------------------------------------------------------
% Syntax : cktnetlist = nal_nbk_FPGA_ckt_02()
% 
% this will return cktnetlist of non disconnected simple ckt for FPGA 
% --------------------------------------------------------------------------------

% ------------------ written on : Mar 31, 2018 ------------------------
 
    clear cktnetlist;
    cktnetlist.cktname = 'nal_nbk_FPGA_ckt_02';
 
    cktnetlist.nodenames = {'1','2','3','4','5','6','7','8','9','10','11','12', ...
    						 '13','14','15','16','17','18','19','20'};
    cktnetlist.groundnodename = 'gnd'; % 
    rM = resModSpec();
   % cM = capModSpec();
    iM = isrcModSpec();
    vM = vsrcModSpec();

    cktnetlist = add_element(cktnetlist, rM, 'R1', {'1','2'}, {{'R', 100}});
    cktnetlist = add_element(cktnetlist, rM, 'R2', {'1','3'}, {{'R', 100}});
    cktnetlist = add_element(cktnetlist, rM, 'R3', {'2','3'}, {{'R', 100}});
    cktnetlist = add_element(cktnetlist, rM, 'R4', {'2','4'}, {{'R', 100}});
    cktnetlist = add_element(cktnetlist, rM, 'R5', {'3','4'}, {{'R', 100}});
    cktnetlist = add_element(cktnetlist, iM, 'I6', {'3','6'}, {}, {{'DC', 0.002}});
    cktnetlist = add_element(cktnetlist, iM, 'I7', {'2','5'}, {}, {{'DC', 0.001}});
    cktnetlist = add_element(cktnetlist, rM, 'R8', {'4','5'}, {{'R', 100}}) ;   
    cktnetlist = add_element(cktnetlist, rM, 'R9', {'4','6'}, {{'R', 100}}); 
    cktnetlist = add_element(cktnetlist, rM, 'R10', {'5','6'}, {{'R', 100}}); 
    cktnetlist = add_element(cktnetlist, rM, 'R11', {'5','7'}, {{'R', 100}});    
    cktnetlist = add_element(cktnetlist, rM, 'R12', {'6','7'}, {{'R', 100}});

    cktnetlist = add_element(cktnetlist, rM, 'R13', {'3','9'}, {{'R', 10000}});
    cktnetlist = add_element(cktnetlist, rM, 'R14', {'6','11'}, {{'R', 10000}});
    cktnetlist = add_element(cktnetlist, rM, 'R15', {'8','9'}, {{'R', 10000}});
    cktnetlist = add_element(cktnetlist, rM, 'R16', {'8','10'}, {{'R', 10000}});
    cktnetlist = add_element(cktnetlist, rM, 'R17', {'9','10'}, {{'R', 10000}});
    cktnetlist = add_element(cktnetlist, vM, 'V18', {'9', '11'},{},{{'DC', 10}});
    cktnetlist = add_element(cktnetlist, rM, 'R19', {'10','12'}, {{'R', 10000}});
    cktnetlist = add_element(cktnetlist, rM, 'R20', {'11','12'}, {{'R', 10000}});
    cktnetlist = add_element(cktnetlist, rM, 'R21', {'11','13'}, {{'R', 10000}});
    cktnetlist = add_element(cktnetlist, rM, 'R22', {'12','13'}, {{'R', 10000}});
    cktnetlist = add_element(cktnetlist, rM, 'R23', {'10','15'}, {{'R', 10000}});
    cktnetlist = add_element(cktnetlist, rM, 'R24', {'12','17'}, {{'R', 10000}});

    cktnetlist = add_element(cktnetlist, rM, 'R25', {'14','15'}, {{'R', 100}}); 
    cktnetlist = add_element(cktnetlist, rM, 'R26', {'14','16'}, {{'R', 100}}); 
    cktnetlist = add_element(cktnetlist, rM, 'R27', {'15','16'}, {{'R', 100}}); 
    cktnetlist = add_element(cktnetlist, rM, 'R28', {'15','17'}, {{'R', 100}}); 
    cktnetlist = add_element(cktnetlist, iM, 'I29', {'16','18'}, {}, {{'DC', 0.002}});
    cktnetlist = add_element(cktnetlist, rM, 'R30', {'17','18'}, {{'R', 100}}); 
    cktnetlist = add_element(cktnetlist, rM, 'R31', {'17','19'}, {{'R', 100}}); 
    cktnetlist = add_element(cktnetlist, rM, 'R32', {'18','19'}, {{'R', 100}}); 

    cktnetlist = add_element(cktnetlist, rM, 'R33', {'16','20'}, {{'R', 10000}});
    cktnetlist = add_element(cktnetlist, rM, 'R34', {'18','gnd'}, {{'R', 10000}});
    cktnetlist = add_element(cktnetlist, vM, 'V35', {'20', 'gnd'},{},{{'DC', 20}});
    cktnetlist ;

end
