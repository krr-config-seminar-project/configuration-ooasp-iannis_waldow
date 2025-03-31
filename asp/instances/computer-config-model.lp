% computer configuration model "PCv1"
% classes
ooasp_class("PCv1","ComputerPart").
ooasp_class("PCv1","Case").
ooasp_class("PCv1","Motherboard"). 
ooasp_class("PCv1","CPU").
ooasp_class("PCv1","GPU"). 
ooasp_class("PCv1","RAM"). 


% class inheritance
ooasp_subclass("PCv1","Case","ComputerPart").
ooasp_subclass("PCv1","Motherboard","ComputerPart").
ooasp_subclass("PCv1","CPU","ComputerPart").
ooasp_subclass("PCv1","RAM","ComputerPart").
ooasp_subclass("PCv1","GPU","ComputerPart").


% associations
ooasp_assoc("PCv1","Case_Motherboard","Case",1,1,"Motherboard",1,1).
ooasp_assoc("PCv1","Motherboard_CPU","Motherboard",1,1,"CPU",1,1).
ooasp_assoc("PCv1","Motherboard_RAM","Motherboard",1,1,"RAM",1,1).
ooasp_assoc("PCv1","Motherboard_GPU","Motherboard",1,1,"GPU",1,1).


% attributes
%% Case
%% Case form factor
ooasp_attribute("PCv1", "Case", "form_factor", "string").
ooasp_attribute_enum("PCv1", "Case", "form_factor", "ATX").
ooasp_attribute_enum("PCv1", "Case", "form_factor", "Micro-ATX").
ooasp_attribute_enum("PCv1", "Case", "form_factor", "Mini-ATX").

%% Mobo
%% Mobo form factor
ooasp_attribute("PCv1", "Motherboard", "form_factor", "string").
ooasp_attribute_enum("PCv1", "Motherboard", "form_factor", "ATX").
ooasp_attribute_enum("PCv1", "Motherboard", "form_factor", "Micro-ATX").
ooasp_attribute_enum("PCv1", "Motherboard", "form_factor", "Mini-ATX").

%% Mobo socket types
ooasp_attribute("PCv1", "Motherboard", "socket", "string").
ooasp_attribute_enum("PCv1", "Motherboard", "socket", "LGA 1700").
ooasp_attribute_enum("PCv1", "Motherboard", "socket", "LGA 1200").
ooasp_attribute_enum("PCv1", "Motherboard", "socket", "AM5").
ooasp_attribute_enum("PCv1", "Motherboard", "socket", "AM4").

%% Mobo RAM type
ooasp_attribute("PCv1", "Motherboard", "ram_type", "string").
ooasp_attribute_enum("PCv1", "Motherboard", "ram_type", "DDR3").
ooasp_attribute_enum("PCv1", "Motherboard", "ram_type", "DDR4").
ooasp_attribute_enum("PCv1", "Motherboard", "ram_type", "DDR5").

%% Mobo PCIe type
ooasp_attribute("PCv1", "Motherboard", "pcie_type", "string").
ooasp_attribute_enum("PCv1", "Motherboard", "pcie_type", "3.0").
ooasp_attribute_enum("PCv1", "Motherboard", "pcie_type", "4.0").
ooasp_attribute_enum("PCv1", "Motherboard", "pcie_type", "5.0").

%% CPU
%% CPU socket types
ooasp_attribute("PCv1", "CPU", "socket", "string").
ooasp_attribute_enum("PCv1", "CPU", "socket", "LGA 1700").
ooasp_attribute_enum("PCv1", "CPU", "socket", "LGA 1200").
ooasp_attribute_enum("PCv1", "CPU", "socket", "AM5").
ooasp_attribute_enum("PCv1", "CPU", "socket", "AM4").

%% RAM
%% RAM type
ooasp_attribute("PCv1", "RAM", "ram_type", "string").
ooasp_attribute_enum("PCv1", "RAM", "ram_type", "DDR3").
ooasp_attribute_enum("PCv1", "RAM", "ram_type", "DDR4").
ooasp_attribute_enum("PCv1", "RAM", "ram_type", "DDR5").

%% GPU
%% GPU pcie type
ooasp_attribute("PCv1", "GPU", "pcie_type", "string").
ooasp_attribute_enum("PCv1", "GPU", "pcie_type", "3.0").
ooasp_attribute_enum("PCv1", "GPU", "pcie_type", "4.0").
ooasp_attribute_enum("PCv1", "GPU", "pcie_type", "5.0").


%%%%%%%%%%%%%%%%%%%%
%%% Sample Parts %%%
%%%%%%%%%%%%%%%%%%%%
% We define subclasses for different computer parts. If the part is in the config, we "initialize" its attribute values

% CPU subclasses
ooasp_class("PCv1", "Intel_i9_14900K").
ooasp_subclass("PCv1", "Intel_i9_14900K", "CPU").
ooasp_attribute_value(I, "socket", O, "LGA 1700") :- ooasp_isa(I, "Intel_i9_14900K", O).

ooasp_class("PCv1", "AMD_Ryzen_9_5950X").
ooasp_subclass("PCv1", "AMD_Ryzen_9_5950X", "CPU").
ooasp_attribute_value(I, "socket", O, "AM4") :- ooasp_isa(I, "AMD_Ryzen_9_5950X", O).

ooasp_class("PCv1", "AMD_Ryzen_7_7700X").
ooasp_subclass("PCv1", "AMD_Ryzen_7_7700X", "CPU").
ooasp_attribute_value(I, "socket", O, "AM5") :- ooasp_isa(I, "AMD_Ryzen_7_7700X", O).

% Motherboard subclasses
ooasp_class("PCv1", "ASUS_Z690").
ooasp_subclass("PCv1", "ASUS_Z690", "Motherboard").
ooasp_attribute_value(I, "form_factor", O, "ATX") :- ooasp_isa(I, "ASUS_Z690", O).
ooasp_attribute_value(I, "socket", O, "LGA 1700") :- ooasp_isa(I, "ASUS_Z690", O).
ooasp_attribute_value(I, "ram_type", O, "DDR5") :- ooasp_isa(I, "ASUS_Z690", O).
ooasp_attribute_value(I, "pcie_type", O, "5.0") :- ooasp_isa(I, "ASUS_Z690", O).

ooasp_class("PCv1", "MSI_B550M").
ooasp_subclass("PCv1", "MSI_B550M", "Motherboard").
ooasp_attribute_value(I, "form_factor", O, "Micro-ATX") :- ooasp_isa(I, "MSI_B550M", O).
ooasp_attribute_value(I, "socket", O, "AM4") :- ooasp_isa(I, "MSI_B550M", O).
ooasp_attribute_value(I, "ram_type", O, "DDR4") :- ooasp_isa(I, "MSI_B550M", O).
ooasp_attribute_value(I, "pcie_type", O, "4.0") :- ooasp_isa(I, "MSI_B550M", O).

% Case subclasses
ooasp_class("PCv1", "Corsair_4000D").
ooasp_subclass("PCv1", "Corsair_4000D", "Case").
ooasp_attribute_value(I, "form_factor", O, "ATX") :- ooasp_isa(I, "Corsair_4000D", O).

ooasp_class("PCv1", "NZXT_H210").
ooasp_subclass("PCv1", "NZXT_H210", "Case").
ooasp_attribute_value(I, "form_factor", O, "Mini-ATX") :- ooasp_isa(I, "NZXT_H210", O).

% RAM subclasses
ooasp_class("PCv1", "Corsair_Vengeance_DDR5").
ooasp_subclass("PCv1", "Corsair_Vengeance_DDR5", "RAM").
ooasp_attribute_value(I, "ram_type", O, "DDR5") :- ooasp_isa(I, "Corsair_Vengeance_DDR5", O).

ooasp_class("PCv1", "GSkill_Ripjaws_DDR4").
ooasp_subclass("PCv1", "GSkill_Ripjaws_DDR4", "RAM").
ooasp_attribute_value(I, "ram_type", O, "DDR4") :- ooasp_isa(I, "GSkill_Ripjaws_DDR4", O).

% GPU subclasses
ooasp_class("PCv1", "NVIDIA_RTX_4090").
ooasp_subclass("PCv1", "NVIDIA_RTX_4090", "GPU").
ooasp_attribute_value(I, "pcie_type", O, "5.0") :- ooasp_isa(I, "NVIDIA_RTX_4090", O).

ooasp_class("PCv1", "AMD_RX_6800XT").
ooasp_subclass("PCv1", "AMD_RX_6800XT", "GPU").
ooasp_attribute_value(I, "pcie_type", O, "4.0") :- ooasp_isa(I, "AMD_RX_6800XT", O).