#include "./ooasp.lp".

% domain specific constraints below

% The front and back wheels associated with a frame must be of the
% same size.
:- ooasp_isalso(I,"WheelFront",O1), ooasp_isalso(I,"WheelBack",O2), 
    ooasp_attribute_value(I,"wheel_size",O1,Size1), ooasp_attribute_value(I,"wheel_size",O2,Size2),
    Size1 != Size2.


% If child_model is selected for a frame, both wheels associated with
% said frame cannot be larger than 16.
:- ooasp_attribute_value(I,"child_model",O1,"TRUE"), ooasp_isalso(I,"WheelFront",O2), ooasp_attribute_value(I,"wheel_size",O2,Size),
    Size > 16.
		
% If child_model is selected for a frame, the selected gears for said
% frame must be derailleur.
:- ooasp_attribute_value(I,"child_model",O,"TRUE"), ooasp_attribute_value(I,"gears",O,Gears),
    Gears != "Derailleur".
