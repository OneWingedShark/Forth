With
GNAT.Debug_Utilities,
     Forth.VM,
     Forth.Dictionary.Word_List,
System.Address_Image,
Ada.Unchecked_Conversion,
Ada.Strings.Less_Case_Insensitive,
Forth.Data_Stack,
Forth.Types.Create_BLOB;

With GNAT.io;
with System.Storage_Elements;

Package Body Forth.Types is
    Use System;

--------------------------------------------------------------------------------
--	BLOB Operations							      --
--------------------------------------------------------------------------------

    Function "<" ( Left, Right : BLOB ) Return Boolean is
      ( Image(Left) < Image(Right) );

    Function "=" ( Left, Right : BLOB ) Return Boolean is
      ( Image(Left) = Image(Right) );

    Function Image( Item : BLOB ) Return String is
	Use System, System.Storage_Elements;

	Subtype Nybble	is Interfaces.Unsigned_8 Range 16#0#..16#F#;
	Subtype Byte	is Interfaces.Unsigned_8;
	Type Byte_String is Array(Positive Range <>) of Byte;

	Function Nybble_to_Hex( Input : Nybble ) Return Character is
	    subtype Decimal is Nybble range 0..9;
	    Base : Constant Interfaces.Unsigned_8:=
	      			( if Input in Decimal then Character'Pos('0')
				  else Character'Pos('A') - 10 );
	begin
	    Return Character'Val( Base + Input );
	End Nybble_To_Hex;

	Function Image( Item : Byte ) Return String is
	begin
	    Return ( 1 => Nybble_to_Hex(Item / 16), 2 => Nybble_to_Hex(Item mod 16) );
	End Image;

	Function Image( Item : Byte_String ) return String is
	begin
	    Case Item'Length is
	    when 0	=> Return "";
	    when 1	=> Return Image(Item(Item'First));
	    when others	=>
		declare
		    Head : String Renames Image(Item(Item'First));
		    subtype Tail_Range is Positive Range
		      Positive'Succ(Item'First)..Item'Last;

		    Tail : String Renames Image(Item(Tail_Range));
		begin
		    Return Head & Tail;
		end;
	    end case;
	End Image;

	Length : Constant Natural:= (Item'Length*Storage_Array'Component_Size)
					  / Byte'Object_Size;
	Pragma Warnings(Off);
	Image_String : Byte_String(1..Length)
	  with Import, Convention => Ada, Address => Item.All'Address;
	Pragma Warnings(On);
    begin
	Return Image(Image_String);
    end Image;

-- OBSOLETE?
--------------------------------------------------------------------------------
--	Return Record Operations					      --
--------------------------------------------------------------------------------

    Function Image( Item : Return_Record ) Return String is
      (if Item.Address then	System.Address_Image(Item.Return_Address)
       else			Image( Item.Temp_Variable.All )
      );

--------------------------------------------------------------------------------
--	Boolien Operations						      --
--------------------------------------------------------------------------------


    -- The value-function exists to allow arithmatic expression/manipulation
    -- of Boolien values; this exists for the reducing operations.
    Function Value is new Ada.Unchecked_Conversion(
		Source => Boolien,
		Target => Interfaces.Integer_64
	);

    Function "AND"(Left, Right : Boolien) Return Boolien is
	-- (if Left = True and Right = True then True else False)
	-- Adding Abs to the addition and checking equality with 2 would
	-- be portable, however this is optimizing for fewer operations.
      (if Value(Left) + Value(Right) = -2 then True else False);

    Function "OR" (Left, Right : Boolien) Return Boolien is
	-- (if Left = True or Right = True then True else False)
      (if Value(Left) + Value(Right) /= 0 then True else False);

    Function "XOR"(Left, Right : Boolien) Return Boolien is
      (if Left /= Right then True else False);

    Function "NOT"(	 Right : Boolien) Return Boolien is
    begin
	Return Boolien'Succ( Right );
    Exception
	When Constraint_Error => Return Boolien'First;
    end "NOT";

    Function "<"  (Left, Right : Boolien) Return Boolean is
     -- (abs Value(Left) < abs Value(Right));
      (if Left = False then Right = True else False);


--------------------------------------------------------------------------------
--	Word Operations							      --
--------------------------------------------------------------------------------

    Function Image( Item : Word ) return String is

	-- Returns the the items of the given list.
	Function Image( Item : String_Vector.Vector ) Return string is
	    Package US renames Ada.Strings.Unbounded;
	    Working : US.Unbounded_String;

	    -- Creates a listing of the items in the given vector.
	    Procedure Iterate( Cursor : String_Vector.Cursor ) is
		Element  : String renames String_Vector.Element( Cursor );
		Terminal : Constant Boolean:=
		  String_Vector.To_Index(Cursor) = Item.Last_Index;
	    begin
		US.Append(  Source   => Working,
			    New_Item => Element & (if Terminal then""else", ")
			 );
	    End Iterate;
	begin
	    Item.Iterate(Process => Iterate'Access);
	    Return US.To_String( Working );
	end Image;

	-- Returns the Address of the giiven routine [as a string].
	Function Image( Item : Routine ) return string is
	    ( GNAT.Debug_Utilities.Image( Item.All'Address ) );

    begin
	-- Returns the image as appropriate.
	Return (if Item.Leaf then Image(Item.Code) else Image(Item.List) );
    end Image;

    Procedure Execute( State : in out Forth.VM.Interpreter; Item : Word ) is
    begin
	GNAT.IO.Put_Line("--EXECUTING: " & Image(Item));
	if Item.Leaf then
	    Item.Code.All( State'Access );
	else
	    for Current_Word of Item.List loop
		begin
		    declare
			Item : Cell := Parse_Cell(Number => Current_Word);
		    begin
			Forth.Data_Stack.Push( Item => Item, Stack => State.Data );
		    end;
		exception
		    when OPERAND_ERROR =>
			Execute( Item => Current_Word, State => State );
		end;
	    end loop;
	end if;
    End Execute;

    Procedure Execute( State : in out Forth.VM.Interpreter; Item : Definition_String )
      renames Forth.VM.Execute;


--------------------------------------------------------------------------------
--	CELL Operations							      --
--------------------------------------------------------------------------------

    Function Image( Item : Cell ) Return String is
      (case Item.Data_Type is
	when ftBoolean	=> Boolien'Image( Item.Boolean_Value ),
	when ftInteger	=> Integer_64'Image( Item.Integer_Value ),
	when ftFloat	=> IEEE_Float_64'Image( Item.Float_Value ),
	when ftString	=> US.To_String( Item.String_Value ),
	when ftBLOB	=> Image(Item.Blob_Value)
      );

    Function Create_Cell( Addr : Address; Length : Natural ) Return Cell is
      ( Data_Type => ftBLOB, BLOB_Value => Create_BLOB(Addr, Length) );

    Function Parse_Cell ( Number : String; Base : Positive:= 10 ) return Cell is
	Working : Interfaces.Integer_64;
    begin
	Working:= Parse_Number(Number);
	return Create_Cell(Working);
    exception
	when OPERAND_ERROR =>
	    declare
		Working : Interfaces.IEEE_Float_64;
	    begin
		Working:= Parse_Number(Number);
		return Create_Cell(Working);
	    end;
    End Parse_Cell;

    Function Convert_Data( Item : Cell ) Return Boolien is
      (case Item.Data_Type is
       when ftBoolean	=> Item.Boolean_Value,
       when ftInteger	=> Convert( Item.Integer_Value /= 0		),
       when ftFloat	=> Convert( Item.Float_Value /= 0.0		),
       when ftString	=> Convert( Item.String_Value /= ""		),
       when ftBLOB	=> Convert( Image(Item.BLOB_Value)'Length > 0	)
      );

    Function Convert_Data( Item : Cell ) Return Integer_64 is
      (case Item.Data_Type is
       when ftBoolean	=> Abs Value( Item.Boolean_Value ),
       when ftInteger	=> Item.Integer_Value,
       when ftFloat	=> Integer_64(Item.Float_Value),
       when ftString	=> Integer_64'Value(To_String(Item.String_Value)),
       when ftBLOB	=> Integer_64'Value(Image(Item.BLOB_Value))
      );

    Function Convert_Data( Item : Cell ) Return IEEE_Float_64 is
      (case Item.Data_Type is
       when ftBoolean	=> IEEE_Float_64(Abs Value( Item.Boolean_Value )),
       when ftInteger	=> IEEE_Float_64(Item.Integer_Value),
       when ftFloat	=> Item.Float_Value,
       when ftString	=> IEEE_Float_64'Value(To_String(Item.String_Value)),
       when ftBLOB	=> IEEE_Float_64'Value(Image(Item.BLOB_Value))
      );

    Function Convert_Data( Item : Cell ) Return Unbounded_String is
      (if Item.Data_Type = ftString then Item.String_Value
       else To_Unbounded_String( Source => Image(Item) ));

    Function Convert_Data( Item : Cell ) Return BLOB is
      (case Item.Data_Type is
       when ftBoolean	=> Create_BLOB(Data => Item.Boolean_Value'Address),
       when ftInteger	=> Create_BLOB(Data => Item.Integer_Value'Address),
       when ftFloat	=> Create_BLOB(Data => Item.Float_Value'Address),
       when ftString	=> Create_BLOB(Data => Item.String_Value'Address,
					Length => Length(Item.String_Value)),
       when ftBLOB	=> Item.BLOB_Value
      );

    Function ">" ( Left, Right : Cell ) Return Boolean is
	(if Left = Right then false else not (Left < Right));

    Function "<" ( Left, Right : Cell ) Return Boolean is
	Function "<"(Left, Right : String) Return Boolean renames
	  Ada.Strings.Less_Case_Insensitive;
    begin
	if Left.Data_Type /= Right.Data_Type then
	    raise OPERAND_ERROR;
	else
	   return
	   (case Left.Data_Type is
	    when ftBoolean	=> Left.Boolean_Value < Right.Boolean_Value,
	    when ftInteger	=> Left.Integer_Value < Right.Integer_Value,
	    when ftFloat	=> Left.Float_Value   < Right.Float_Value,
	    when ftString	=> Left.String_Value  < Right.String_Value,
	    when ftBLOB		=> Left.BLOB_Value    < Right.BLOB_Value
	   );
	end if;
    end "<";

    Function "=" ( Left, Right : Cell ) Return Boolean is
	Function "="(Left, Right : String) Return Boolean renames
	  Ada.Strings.Less_Case_Insensitive;
    begin
	if Left.Data_Type /= Right.Data_Type then
	    raise OPERAND_ERROR;
	else
	   return
	   (case Left.Data_Type is
	    when ftBoolean	=> Left.Boolean_Value = Right.Boolean_Value,
	    when ftInteger	=> Left.Integer_Value = Right.Integer_Value,
	    when ftFloat	=> Left.Float_Value   = Right.Float_Value,
	    when ftString	=> Left.String_Value  = Right.String_Value,
	    when ftBLOB		=> Left.BLOB_Value    = Right.BLOB_Value
	   );
	end if;
    end "=";


--------------------------------------------------------------------------------
--	Miscelanious Operations						      --
--------------------------------------------------------------------------------

    Function Parse_Number( S : String ) Return Interfaces.Integer_64 is
    begin
	Return Integer_64'Value( S );
    exception
	When CONSTRAINT_ERROR => raise OPERAND_ERROR;
    end Parse_Number;

    Function Parse_Number( S : String ) Return Interfaces.IEEE_Float_64 is
    begin
	return IEEE_Float_64'Value( S );
    exception
	When CONSTRAINT_ERROR => raise OPERAND_ERROR;
    end Parse_Number;


End Forth.Types;
