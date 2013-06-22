With
Ada.Containers.Indefinite_Vectors;

Package Forth.String_Vector is new
	Ada.Containers.Indefinite_Vectors(
		Index_Type	=> Positive,
		Element_Type	=> String
	) with Preelaborate;

Pragma Preelaborate( Forth.String_Vector );
