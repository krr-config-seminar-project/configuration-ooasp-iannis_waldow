#include "./ooasp.lp".
% domain specific constraints below

% The motherboard and CPU must have compatible sockets
:- ooasp_isalso(I,"Motherboard",MB), ooasp_isalso(I,"CPU",CPU), 
   ooasp_attribute_value(I,"socket",MB,MBSocket), 
   ooasp_attribute_value(I,"socket",CPU,CPUSocket),
   MBSocket != CPUSocket.

% The motherboard and RAM must have compatible types
:- ooasp_isalso(I,"Motherboard",MB), ooasp_isalso(I,"RAM",RAM), 
   ooasp_attribute_value(I,"ram_type",MB,MBRamType), 
   ooasp_attribute_value(I,"ram_type",RAM,RAMType),
   MBRamType != RAMType.

% The case must support the motherboard form factor
:- ooasp_isalso(I,"Case",Case), ooasp_isalso(I,"Motherboard",MB), 
   ooasp_attribute_value(I,"form_factor",Case,CaseForm), 
   ooasp_attribute_value(I,"form_factor",MB,MBForm),
   CaseForm != MBForm.