--  With
--  System,
--  Ada.Containers.Indefinite_Ordered_Maps,
--  Ada.Containers.Indefinite_Vectors,
--  Ada.Strings.Equal_Case_Insensitive,
--  Ada.Strings.Fixed,
--  Ada.Text_IO,
--  --Forth.Dictionary,
--  --  Forth.String_List,
--  --  Forth.Interpreter,
--  Forth.Stack,
--  Forth.Types,
--  Forth.Tokenize,
--  Ada.Characters.Handling
--  ;
--
--  With Ada.Strings.Unbounded;
--
--  Procedure Test is
--  --      Subtype Interpreter is Forth.Interpreter.Interpreter;
--  --
--  --      Use Forth, Forth.Interpreter, Ada.Text_IO;
--  --      Working : Interpreter:= Create;
--  --
--  --      function Read( Input : String := Ada.Text_IO.Get_Line ) Return String is
--  --      begin
--  --  	Return Input;
--  --      end Read;
--  --
--  --      Function Eval( Input : String ) Return String is
--  --
--  --  	Subtype String_Vector is Forth.String_List.Vector;
--  --
--  --  	Function Tokens( Item : String:= Input ) Return String_Vector is
--  --  	    Use Ada.Strings.Fixed, Ada.Strings;
--  --  	    Input	: String:= Trim(Source => Item, Side => Both);
--  --  	    Position	: Natural;
--  --  	Begin
--  --  	    Return Result : String_Vector do
--  --  		Position := Index(
--  --  		    Source  => Input,
--  --  		    Pattern => " ",
--  --  		    Going   => Forward
--  --  		   );
--  --  		If Position in Positive then
--  --  		    Result.Append( Input(Input'First..Position-1) );
--  --  		    Result.Append( Tokens(Input(Position..Input'Last)) );
--  --  		else
--  --  		    Result.Append( Input );
--  --  		end if;
--  --  	    End Return;
--  --  	End Tokens;
--  --
--  --  	Items   : String_Vector := Tokens;
--  --
--  --  	Function Length Return Natural is ( Natural(Items.Length) );
--  --  	use Ada.Text_IO;
--  --      begin
--  --  	Put( "[ " );
--  --  	for Index in Positive Range 1..Length loop
--  --  	    Put( items(Index) & (if Index /= Length then "," else "") );
--  --  	end loop;
--  --  	Put_Line( " ]" );
--  --  	Return Input;
--  --      end Eval;
--  --
--  --      Procedure Print( Input : String ) is
--  --      begin
--  --  	Ada.Text_IO.Put_Line( Input );
--  --      end Print;
--  --
--  --  begin
--  --      loop
--  --  	declare
--  --  	    Input : String := Read;
--  --  	begin
--  --  	    declare
--  --  		Result : String := Eval( Input => Input );
--  --  		Use Ada.Strings;
--  --  	    begin
--  --  		Exit when Equal_Case_Insensitive( "EXIT", Result );
--  --
--  --  		if Equal_Case_Insensitive( "LIST", Result ) then
--  --  --  		    for E : Integer of Dict(Working) loop
--  --  --  		    end loop;
--  --
--  --  		    Forth.Dictionary.Print(Working);
--  --  		    null;
--  --  		end if;
--  --
--  --  		Print(Result);
--  --  	    end;
--  --  	end;
--  --      end loop;
--
--      Str  : constant String:= ": GREET         ."" Hello, I speak Forth "" ";
--      Test : String:= Str ; --"This is my input ;";
--  Begin
--
--  --      declare
--  --  	Test : Forth.Types.Cell:= Forth.Types.Create_Cell( True );
--  --  	Use Forth.Types, Ada.Text_IO;
--  --
--  --  	Size : Constant Natural:= Cell_Size+Element_Type'Object_Size;
--  --  	Tab : Constant Character:= ASCII.HT;
--  --
--  --  	Str : Ada.Strings.Unbounded.Unbounded_String;
--  --      begin
--  --  	Put_Line( "Combined:" & Size'Img );
--  --  	Put_Line( "Size:" & Test'Size'Img &" /"& Cell'Object_Size'Img);
--  --
--  --  	    New_Line;
--  --
--  --  	Put_Line( "US Size:" & Str'Size'Img );
--  --  	Put_Line( "fin.");
--  --      end;
--
--      For S of Forth.Tokenize(Test) loop
--  	Ada.Text_IO.Put_Line( S );
--      end loop;
--
--
--  end Test;

with Forth.Interpreter;
Procedure Test is Begin Forth.Interpreter; End Test;
