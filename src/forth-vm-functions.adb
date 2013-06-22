With
Ada.Strings.Unbounded,
Interfaces,
Forth.Data_Stack,
Forth.Types;

Use
Forth.Data_Stack,
Forth.Types;

with
GNAT.IO;

Use All Type
Forth.Types.Cell;

Package Body Forth.VM.Functions is
    subtype Integer_range is Interfaces.Integer_64 range
      Interfaces.Integer_64(Integer'First)..Interfaces.Integer_64(Integer'Last);

    Procedure Put_Line( Input : String ) renames GNAT.IO.Put_Line;

    Function Advance( State : not null access Forth.VM.Interpreter ) return Cell is
    begin
	declare
	    Use Forth.String_Vector;
	    Data : Cursor := Next(State.Cursor);
	    String_Data : Constant String:= Element(Data);
	begin
	    State.Input.Delete( Data );
	    -- Creates a numeric cell if the value is numeric.
	    Return Parse_Cell( String_Data );
	Exception
	    -- Otherwise, creates a cell of the string.
	    When OPERAND_ERROR => Return Create_Cell( String_Data );
	end;
    end Advance;

    Procedure Advance(	State : not null access Forth.VM.Interpreter;
			Items : Natural:= 1 ) is
    begin
	For Count in 1..Items loop
	    Advance( State );
	end loop;
    end Advance;

    Procedure Advance(	State	: not null access Forth.VM.Interpreter;
			Data	: Type_Array;
			Strict	: Boolean := True ) is
    begin
	For Item of Data loop
	    declare
		Result : Cell:= Advance( State );
	    begin
		if Result.Data_Type = Item then
		    Push( Stack => State.Data, Item => Result );
		elsif not Strict then
		    declare
			Conversion : Cell( Data_Type => Item ):=
			  Convert(Result, Item);
		    begin
			Push( Stack => State.Data, Item => Conversion );
		    end;
		else
		    Raise OPERAND_ERROR;
		end if;
	    end;
	end loop;
    end Advance;

    --Procedure Advance( State : not null access Forth.VM.Interpreter; Items : Natural:= 1 );


    Procedure Terminate_Execution( State : not null access Forth.VM.Interpreter ) is
	Pragma Unreferenced( State );
    Begin
	Raise EXITUS;
    End Terminate_Execution;

    Procedure Clear_Data( State : not null access Forth.VM.Interpreter ) is
    begin
	Forth.Data_Stack.Clear(State.Data);
    End Clear_Data;

    -- Get Parameters
    Function Left( State : not null access Forth.VM.Interpreter) return Cell is
	( Peek(State.Data) );

    Function Right( State : not null access Forth.VM.Interpreter) return Cell is
	( Peek_Next(State.Data) );

    Function Index( State : not null access Forth.VM.Interpreter) return Integer is
	Use Interfaces;
    begin
	declare
	    Ct    : Cell( Data_Type => ftInteger):= Pop(State.Data);
	    Index : Integer_64 renames Ct.Integer_Value;
	begin
	    if Index not in Integer_range or else Index < 0 then
		Raise Forth.OPERAND_ERROR;
	    end if;

	    Return Integer(Index);
	end;
    end Index;

    Procedure Max( State : not null access Forth.VM.Interpreter ) is
    begin
	if Left(State) > Right(State) then
	    Swap(State.Data);
	end if;

	Pop(State.Data);
    end Max;


    Procedure Min( State : not null access Forth.VM.Interpreter ) is
    begin
	if Left(State) < Right(State) then
	    Swap(State.All.Data);
	end if;

	Pop(State.All.Data);
    end Min;

    Procedure Cell_NOT ( State : not null access Forth.VM.Interpreter ) is
    begin
	null;
    End Cell_NOT;

    Procedure Cell_OR  ( State : not null access Forth.VM.Interpreter ) is
    begin
	null;
    End Cell_OR;

    Procedure Cell_OVER( State : not null access Forth.VM.Interpreter ) is
    begin
	Forth.Data_Stack.Over( State.Data );
    End Cell_OVER;

    Procedure Cell_PICK( State : not null access Forth.VM.Interpreter ) is
    begin
	Push(
	      Stack => State.Data,
	      Item  => Peek( State.Data, Index(State) )
	    );
    End Cell_PICK;

    Procedure Cell_ROLL( State : not null access Forth.VM.Interpreter ) is
    begin
	Roll( Stack => State.Data, Depth => Index(State) );
    End Cell_ROLL;

    Procedure Cell_ROT( State : not null access Forth.VM.Interpreter ) is
    begin
	Forth.Data_Stack.Roll(Stack => State.Data, Depth => Index(State));
    End Cell_ROT;

    Procedure Cell_SWAP( State : not null access Forth.VM.Interpreter ) is
    begin
	Forth.Data_Stack.Swap(Stack => State.Data);
    End Cell_SWAP;

    Procedure Dot_Quote( State : not null access Forth.VM.Interpreter ) is
    begin
	declare
	    Use Forth.String_Vector;
	    Data : Cursor := Next(State.Cursor);
	    String_Data : Constant String:= Element(Data);
	begin
	    Put_Line( String_Data );
	    State.Input.Delete( Data );
	end;
    exception
	When others => Put_Line( "ERROR!" );
    End Dot_Quote;

    Procedure Ess_Quote( State : not null access Forth.VM.Interpreter ) is
    begin
	declare
	    Use Forth.String_Vector;
	    Data : Cursor := Next(State.Cursor);
	    String_Data : Constant String:= Element(Data);
	begin
	    Forth.Data_Stack.Push(
			   Stack => State.Data,
			   Item => Forth.Types.Create_Cell(String_Data)
			  );
	    State.Input.Delete( Data );
	end;
    exception
	When others => Put_Line( "ERROR!" );
    End Ess_Quote;

    Procedure Define( State : not null access Forth.VM.Interpreter ) is
    begin
	State.Mode:= Compile;
	declare
	    Use Forth.String_Vector;
	    Data  : Cursor := Next(State.Cursor);
	    Name  : Constant Definition_String:= Element(Data);
	    Value : Vector;
	begin

	    Data:= Next(Data);
	    while Element(Data) /= ";" loop
		Value.Append( New_Item => Element(Data) );
		Data:= Next(Data);
	    end loop;

	    while Data /= State.Cursor loop
		declare
		    Temp : Cursor:= Data;
		begin
		    Data:= Previous(Data);
		    State.Input.Delete( Temp );
		end;
	    end loop;

	    For S of Value loop
		gnat.IO.put( S & ',' );
	    end loop;
	    gnat.io.Put_Line("");

	    Put_Line("Adding '"& Name &"', which contains" & Value.Length'Img & " elements.");
	    State.Dictionary.Include(Name, Create(Value) );
	end;
    End Define;

    Procedure End_Define( State : not null access Forth.VM.Interpreter ) is
    begin
	State.Mode:= not Compile;
    End End_Define;

    Procedure Words( State : not null access Forth.VM.Interpreter ) is
	Use Forth.Dictionary.Word_List;

	procedure Print_Item(Position : Cursor) is
	begin
	    Put_Line( Key(Position) );
	end Print_Item;
    begin
	State.Dictionary.Iterate( Print_Item'Access );
    end Words;

    Procedure See( State : not null access Forth.VM.Interpreter ) is
	Use US, Forth.Dictionary.Word_List;
    begin
	declare
	    Name_Cell	: Constant Cell(ftString):= Advance(State);
	    Name	: Constant String := To_String(Name_Cell.String_Value);
	    Item	: Constant Cursor:= State.Dictionary.Find(Key => Name);
	begin
	    if Item = No_Element then
		Put_Line( Name & " is undefined." );
	    else
		Put_Line( Key(Item) & ASCII.HT & Image(Element(Item)) );
	    end if;
	end;
    end See;


End Forth.VM.Functions;
