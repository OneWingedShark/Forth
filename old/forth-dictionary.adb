With
Forth.Interpreter,
Forth.Dictionary.Word_List,
Ada.Text_IO;

-- Note:
--	As you can see the full WITH above allows us to depend on packages that
--	depend on this package (Forth.Interpreter & Forth.Dictionary.Word_List).
--	This is acheived by the separation between specifications and bodies:
--	what seems like a circular dependancy is not. See the diagram below:
--
--  SPEC			DEPENDENCY			TYPE
--	Forth.Interpreter		Forth.Dictionary.Word_List	Explicit
--	Forth.Dictionary.Word_List	Forth.Interpreter		Explicit
--
--  BODY			DEPENDENCY			TYPE

Package Body Forth.Dictionary is

    Procedure Print( List : Word_List.Map ) is
	Use Ada.Text_IO;
	procedure Iterate(Position : Word_List.Cursor) is
	    Key		: String   renames Word_List.Key(Position);
	    Element	: Integer  renames Word_List.Element(Position);
	begin
	    Put_Line( Key &": "& Element'Img );
	End Iterate;
    begin
	List.Iterate(Process => Iterate'Access);
    end Print;

    Procedure Print( List : Forth.Interpreter.Interpreter ) is
    begin
	Print( Forth.Interpreter.Get_Dictionary(List) );
    End Print;

End Forth.Dictionary;
