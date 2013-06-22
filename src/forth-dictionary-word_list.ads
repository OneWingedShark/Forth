With
Forth.Types,
Ada.Strings.Less_Case_Insensitive,
Ada.Containers.Indefinite_Ordered_Maps;

Use All Type
Forth.Types.Word;

Package Forth.Dictionary.Word_List is new
	Ada.Containers.Indefinite_Ordered_Maps(
		Key_Type	=> Forth.Types.Definition_String,
		Element_Type	=> Forth.Types.Word,
		"<"		=> Ada.Strings.Less_Case_Insensitive
	) with Preelaborate;

pragma Preelaborate( Forth.Dictionary.Word_List );
