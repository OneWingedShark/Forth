With
Ada.Text_IO,
Forth.VM,
Forth.Data_Stack,
Forth.Types,
Forth.Tokenize,
Forth.String_Vector,
Forth.Handle_Strings;

Procedure Forth.Interpreter is

    Use Forth.String_Vector;
    Function Handle_Strings( Input : in Vector ) Return Vector is
    begin
	Return Result : Vector := Input.Copy(Input.Length) do
	    Handle_Strings(Result);
	End return;
    end Handle_Strings;

    Type Debugging_Style is (None, Minimal, Medium, Full);
    -- None:    	Supress all debugging messages.
    -- Minimal: 	Display the Data-stack.
    -- Medium:  	Display the Data & Return Stacks.
    -- Full:    	Display the Stacks as well as the tokenized text.

    DEBUGGING : Constant Debugging_Style := Minimal;

    Interpreter : Forth.VM.Interpreter;

begin

--      REPL:
--      -- Read-eval-print loop
--      loop
--  	READ:
--  	declare
--  	    Input : String := Ada.Text_IO.Get_Line;
--  	begin
--  	    For S of Forth.Tokenize(Input) loop
--  		EVAL:
--  		begin
--  		    Put_Line( '#' & S & '#');
--  		    Interpreter.Execute( S );
--  		exception
--  		    When UNDEFINED_ENTRY => Put_Line( S & " is undefined." );
--  		end EVAL;
--  	    end loop;
--  	end READ;
--      end loop REPL;


    REPL:
    -- Read-eval-print loop
    loop
	READ:
	declare
	    Input : String := Ada.Text_IO.Get_Line;
	begin
	    Interpreter.Input:= Handle_Strings(Forth.Tokenize(Input));
	    for S of Interpreter.Input loop
		Ada.Text_IO.Put_Line("Read: [" & S & ']' );
	    end loop;
	end READ;

	EVAL:
	declare
	    Use All Type Forth.Data_Stack.Stack;
	    Use Ada.Text_IO;
	    subtype Index_Range is Positive Range
	      Interpreter.Input.First_Index..Interpreter.Input.Last_Index;

	    Package SV renames Forth.String_Vector;
	    Cursor : SV.Cursor renames Interpreter.Cursor;
	begin
	    Cursor:= Interpreter.Input.To_Cursor(Interpreter.Input.First_Index);
	    loop
		exit when Cursor = SV.No_Element;

		Execute:
		declare
		    S    : Constant String:= SV.Element(Cursor);
		begin
		    if DEBUGGING = FULL then
			Put_Line( '#' & S & '#');
		    end if;

		    PARSE:
			    -- If we cannot parse the given string as a number
			    -- then we try to execute the word.
		    begin
			declare
			    Use All Type Forth.Types.Cell;
			    Item : Forth.Types.Cell := Parse_Cell(Number => S);
			begin
			    Push( Item => Item, Stack => Interpreter.Data );
			end;
		    exception
			when OPERAND_ERROR =>
			    if S in Forth.Types.Definition_String then
			      Interpreter.Execute( S );
			    else
				Put_Line("---- In Execute ----");
				    Push( Item  => Forth.Types.Create_Cell(S),
					  Stack => Interpreter.Data );
			    end if;
		    end PARSE;

		exception
		    When UNDEFINED_ENTRY => Put_Line( S & " is undefined." );
		end Execute;

		Cursor:= SV.Next(Cursor);
	    end loop;
	end EVAL;

	PRINT:
	declare
	    Use Forth.VM;
	    subtype stack_range is stack_type range stack_type'First..
	      ( if DEBUGGING /= Minimal then stack_type'Last
		else stack_type'pred(stack_type'Last));
	begin
	    if DEBUGGING /= None then
		for stack in stack_range loop
		    Ada.Text_IO.Put_Line( stack_type'Image(stack)& ':' &
				ASCII.HT & Interpreter.Print_Stack(stack) );
		end loop;
	    end if;
	end PRINT;

    end loop REPL;


exception
    When EXITUS =>	Ada.Text_IO.Put_Line( "Goodbye." );
end Forth.Interpreter;
