% Please insert the names and email addresses of the group members:
%   Name: Iannis Waldow
% E-Mail: waldow2@uni-potsdam.de

#const max_instance_per_leaf_class = 10.
#const int_domain_max = 20.

possible_instance_id(1..max_instance_per_leaf_class).

% generate attribute values
int_value(1..int_domain_max).
bool_value("TRUE").
bool_value("FALSE").

% input handling
ooasp_instantiation(M,I) :- partial(ooasp_instantiation(M,I)).
ooasp_isa(I,C,O) :- partial(ooasp_isa(I,C,O)).
ooasp_associated(I,A,O1,O2) :- partial(ooasp_associated(I,A,O1,O2)).
ooasp_attribute_value(I,AT,O,V) :- partial(ooasp_attribute_value(I,AT,O,V)).


% generate instantiation 
ooasp_instantiation(M, I) :- ooasp_isa(I, C, O), ooasp_class(M, C).

% instantiate objects using possible instance ids. Object name as tuple "(C,O)" is a pseudo-name to make sure we have different object names
{ ooasp_isa(I, C, (C,O)) } :-
	ooasp_instantiation(M, I), ooasp_class(M, C), not ooasp_subclass(M, _, C), possible_instance_id(O).

%
% Your encoding goes here...
%

% Infer superclass properties from subclasses
ooasp_isalso(I,C,O) :- ooasp_isa(I,C,O).
ooasp_isalso(I,SC,O) :- ooasp_isa(I,C,O), ooasp_subclass(M,C,SC).

% Generate attributes for all objects
%% String
1{ooasp_attribute_value(I,AT,O,Val) : ooasp_attribute_enum(M,_,AT,Val)}1 :- ooasp_attribute(M,C,AT,"string"), ooasp_isalso(I,C,O).

%% Integer
1{ooasp_attribute_value(I,AT,O,V) : V = MinV..MaxV, ooasp_attribute_minInclusive(M,_,AT,MinV), ooasp_attribute_maxInclusive(M,_,AT,MaxV)}1 :- 
	ooasp_attribute(M,C,AT,"integer"), ooasp_isalso(I,C,O).

%% Boolean
1{ooasp_attribute_value(I,AT,O,Val) : bool_value(Val)}1 :- ooasp_attribute(M,C,AT,"boolean"), ooasp_isalso(I,C,O).

% Generate associations
{ooasp_associated(I,A,O1,O2)} :- ooasp_assoc(M,A,C1,_,_,C2,_,_), ooasp_isalso(I,C1,O1), ooasp_isalso(I,C2,O2).


% Constrict instantiation based on associations (completely ignore "min1" and "max1")
% ooasp_assoc_count counts the number of connections of type "A" going TO "O1"
ooasp_assoc_count(I,A,O1,N) :-
	ooasp_isalso(I,C1,O1),
    ooasp_assoc(_,A,C1,_,_,C2,_,_), 
    N = #count{O2 : ooasp_associated(I,A,O1,O2)}.
%% min
:- ooasp_assoc_count(I,A,O,N), ooasp_assoc(_,A,_,_,_,_,MinCount,_), N < MinCount.
%% max
:- ooasp_assoc_count(I,A,O,N), ooasp_assoc(_,A,_,_,_,_,_,MaxCount), N > MaxCount.

% Disallow one object targeting multiple other objects in same association
:- ooasp_associated(_,A,O1,O2), ooasp_associated(_,A,O1',O2), O1 != O1'.

% Disallow models with object not in association defined for their class
:- ooasp_isalso(I,C,O), ooasp_assoc(_,A,C,_,_,_,_,_), not ooasp_associated(I,A,O,_).
:- ooasp_isalso(I,C,O), ooasp_assoc(_,A,_,_,_,C,_,_), not ooasp_associated(I,A,_,O).

% symmetry breaking and minimization

% instantiation of objects must be done in ascending order with no
% gaps, unless the objects is given as part of the input partial
% instantiation
:- ooasp_isa(I, C, (C,ID1)), not partial(ooasp_isa(I, C, (C,ID1))),
	 possible_instance_id(ID2), ID2 < ID1, not ooasp_isa(I, C, (C,ID2)).

% for each association, the mapping from the first object to the
% second must be monotonic, unless the association is given as part of
% the input partial instantiation
:- ooasp_associated(I,A,O1,O2), not partial(ooasp_associated(I,A,O1,O2)),
	 ooasp_associated(I,A,O3,O4),  not partial(ooasp_associated(I,A,O3,O4)),
	 O1 < O3, O4 < O2.

% minimize number of instantiated objects
#minimize { 1, I, C, O : ooasp_isa(I, C, O) }.

#show ooasp_instantiation/2.
#show ooasp_isa/3.
#show ooasp_associated/4.
#show ooasp_attribute_value/4.

#defined ooasp_attribute_enum/4.
#defined partial/1.

% DEBUG
%#show ooasp_assoc_count/4.