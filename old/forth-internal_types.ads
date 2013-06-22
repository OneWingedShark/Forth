With
Ada.Characters.Handling;

Use
Ada.Characters.Handling;

Private Package Forth.Internal_Types is

    Type Stack_Type is ( Data_Stack, Control_Stack, Return_Stack );

    SubType Definition_String is String
    with Static_Predicate => Definition_String'Length in 1..31 AND
			     (For All C of Definition_String => Is_Graphic(C) );

End Forth.Internal_Types;
