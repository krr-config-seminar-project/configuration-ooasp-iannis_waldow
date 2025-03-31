#include "./ooasp.lp".
% domain specific constraints below

% The motherboard and CPU must have compatible sockets
:- ooasp_isa(I,"Motherboard",MB), ooasp_isa(I,"CPU",CPU), 
   ooasp_attribute_value(I,"socket",MB,MBSocket), 
   ooasp_attribute_value(I,"socket",CPU,CPUSocket),
   MBSocket != CPUSocket.

% The motherboard and RAM must have compatible types
:- ooasp_isa(I,"Motherboard",MB), ooasp_isa(I,"RAM",RAM), 
   ooasp_attribute_value(I,"ram_type",MB,MBRamType), 
   ooasp_attribute_value(I,"ram_type",RAM,RAMType),
   MBRamType != RAMType.

% The case must support the motherboard form factor
:- ooasp_isa(I,"Case",Case), ooasp_isa(I,"Motherboard",MB), 
   ooasp_attribute_value(I,"form_factor",Case,CaseForm), 
   ooasp_attribute_value(I,"form_factor",MB,MBForm),
   CaseForm != MBForm.