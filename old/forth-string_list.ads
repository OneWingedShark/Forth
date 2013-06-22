With Ada.Containers.Indefinite_Vectors;

Package Forth.String_List is New Ada.Containers.Indefinite_Vectors
	( Index_Type => Positive, Element_Type => String )
with pure;
