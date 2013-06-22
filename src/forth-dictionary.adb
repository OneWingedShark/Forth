With
  GNAT.IO,
  Forth.VM,
  Forth.Types,
  Forth.Dictionary.Word_List;

--Ada.Text_IO;

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

	Procedure Put_Line( S: String ) renames GNAT.IO.Put_Line;

	procedure Iterate(Position : Word_List.Cursor) is
	    Key		: String   renames Word_List.Key(Position);
	    Element	: Integer  := 3; --renames Word_List.Element(Position);
	begin
	    Put_Line( Key &": "& Element'Img );
	End Iterate;
    begin
	List.Iterate(Process => Iterate'Access);
    end Print;

    Procedure Print( List : Forth.VM.Interpreter ) is
    begin
	Print( List.Get_Dictionary );
    End Print;

    procedure stub is begin null; end stub;

End Forth.Dictionary;
