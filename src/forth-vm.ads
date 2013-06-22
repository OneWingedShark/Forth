With
Forth.Data_Stack,
Forth.Return_Stack,
Forth.String_Vector,
Forth.Dictionary.Word_List;

With
Forth.Types;

Package Forth.VM is


    type stack_type is ( Data_Stack, Return_Stack );

    type Mode is (Execute, Compile);
    Function "NOT"( Right : Mode ) Return Mode;


    type Interpreter is tagged; -- limited private;

    Function Print_Stack(
		    State : in out	Forth.VM.Interpreter;
		    Stack : Stack_Type
		  ) return String;

    Procedure Execute(
		      State : in out	Forth.VM.Interpreter;
		      Item  : 		Forth.Types.Definition_String
		     );

--    Procedure Execute( State : in out	Forth.VM.Interpreter );


    function Get_Dictionary(State : in	Forth.VM.Interpreter)
      return Forth.Dictionary.Word_List.Map;


    -- Default_Words returns the default definitions for our FORTH
    -- virtual machine; they are usually basic stack manipulators.
    --Function Default_Words return Forth.Dictionary.Word_List.Map;
    Function Defaults return Forth.Dictionary.Word_List.Map;


    type Interpreter is tagged limited record
	-- Mode indicates whether or not we are compiling.
	Mode		: Forth.VM.Mode:= Execute;

	-- Dictionary contains the current Interpreter's words.
	Dictionary	: Forth.Dictionary.Word_List.Map:= Defaults;

	-- Input & Cursor
	Input		: Forth.String_Vector.Vector;
	Cursor		: Forth.String_Vector.Cursor;

	-- The various stacks for the interpreter.
	Data		: Forth.Data_Stack.Stack;
	Returns		: Forth.Return_Stack.Stack;
    End Record;

private
    Function "NOT"( Right : Mode ) Return Mode is
      (if Right = Execute then Compile else Execute);
    Function "+"( Right : Mode ) Return Mode is
      ( Execute );
    Function "-"( Right : Mode ) Return Mode is
      ( Compile );

End Forth.VM;

Pragma Preelaborate(Forth.VM);
