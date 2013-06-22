With
Forth.String_Vector,
Ada.Strings.Fixed,
Ada.Strings;

Use
Forth.String_Vector;

Function Forth.Tokenize ( Item : String ) Return Vector is
    Use Ada.Strings.Fixed, Ada.Strings;
    Input	: String:= Trim(Source => Item, Side => Both);
    Position	: Natural;
Begin
    Return Result : Vector do
	Position := Index(
		   Source  => Input,
		   Pattern => " ",
		   Going   => Forward
		  );
	If Position in Positive then
	    Append( Result, Input(Input'First..Position-1) );
	    Append( Result, Tokenize(Input(Position..Input'Last)) );
	else
	    Result.Append( Input );
	end if;
    End Return;
End Forth.Tokenize;
