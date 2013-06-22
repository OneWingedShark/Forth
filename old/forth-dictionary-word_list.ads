With
Forth.Types,
Ada.Containers.Indefinite_Ordered_Maps;

Private With
Forth.Internal_Types;

Package Forth.Dictionary.Word_List is new
	Ada.Containers.Indefinite_Ordered_Maps(
		Key_Type	=> Forth.Internal_Types.Definition_String,
		Element_Type	=> Integer
	);
