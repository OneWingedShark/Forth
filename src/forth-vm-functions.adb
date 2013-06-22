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
	null;
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


End Forth.VM.Functions;
