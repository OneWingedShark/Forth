with
Ada.Containers.Vectors, GNAT.IO;

Procedure Forth.Handle_Strings( Strings : in out Vector ) is

    Input : Vector renames Strings;

    Type Meta_String is record
	Start, Length : Natural;
    end record;

    Package Meta_List is New Ada.Containers.Vectors(
		Index_Type	=> Positive,
		Element_Type	=> Meta_String
	);

    Quote		: Constant String:= """";	-- Alias for "
    Double_Quote	: Constant String:= """""";	-- Alias for ""
    Dot_Quote		: Constant String:= ".""";	-- Alias for ."
    S_Quote		: Constant String:= "s""";	-- Alias for s"

    Function Merge(Start, Stop : Positive) Return String
    with Pre => Start <= Stop;

    Function Merge(Start, Stop : Positive) Return String is
	Element	: String Renames Input(Start);
	Item	: Constant String :=
		  (if Element = Double_Quote then Quote else Element);
    begin
	if Start = Stop then
	    declare
		Last : Character Renames Item(Item'Last);
		subtype Fore is Positive Range
		  Item'First..Positive'Pred(Item'Last);
	    begin
		Return (if Last = '"' then Item(Fore) else Item);
	    end;
	else
	    Return Item & ' ' & Merge(Positive'Succ(Start), Stop);
	end if;
    end merge;

    String_List : Meta_List.Vector;
    type state_type is ( Normal, Inside );
begin
    GNAT.IO.Put_Line( "Searching for Strings." );
    SEARCH:
    declare
	State : state_type:= Normal;
	Data  : Meta_String;

	procedure Scan(Position : Cursor) is
	    Current	: Constant String:=	Element(Position);
	    Index	: Constant Positive:=	To_Index(Position);
	begin
	    if State = Normal then
		if Current = Double_Quote then
		    raise Forth.OPERAND_ERROR;
		elsif Current(Current'Last) = '"' then
		    State:= Inside;
		    Data.Length:= 0;
		end if;
	    else
		if Current = Dot_Quote or Current = S_Quote then
		    Data.Start:= Index+1;
		    String_List.Append( Data );
		else
		    Data.Length:= Data.Length + 1;
		end if;
	    end if;
	end Scan;

    begin
	Input.Reverse_Iterate( Scan'Access );
    end SEARCH;

    REPLACE:
    for Data : Meta_String of String_List loop
	declare
	    Use Ada.Containers;

	    Item : Constant String := Merge(Data.Start, Data.Start+Data.Length);
	    Count: Constant Count_Type := Count_Type(1+Data.Length);

	    procedure Del
		     (Container : in out Vector;
		      Index     : Extended_Index;
		      Count     : Ada.Containers.Count_Type := 1)
		renames Forth.String_Vector.Delete;

	begin
	    Input.Delete( Index => Data.Start, Count => Count );
	    Input.Insert( New_Item => Item, Before   => Data.Start );
	end;
    end loop REPLACE;


End Forth.Handle_Strings;
