with
Forth.VM.Default_Words;

Package body Forth.VM is

    -- Renaming to allow (a) shorter return name in Default_Words,
    -- and (b) berevity in accessing functions within its body.
    Package Dict renames Forth.Dictionary.Word_List;

    Function Defaults return Forth.Dictionary.Word_List.Map
      renames Forth.VM.Default_Words;


    Procedure Execute (	State : in out	Forth.VM.Interpreter;
			Item  :		Forth.Types.Definition_String
		      ) is
	Use Forth.Types;
    Begin
	Execute( Item =>
	   Dict.Element(
		  Container	=> State.Dictionary,
		  Key		=> Item
	    ),	  State		=> State
	 );
    Exception
	-- CONSTRAINT_ERROR is raised when Key is not found, we need an
	-- UNDEFINED_ENTRY to propigate in its stead though.
	When CONSTRAINT_ERROR => Raise UNDEFINED_ENTRY;
    End Execute;


    function Get_Dictionary(State : in	Forth.VM.Interpreter)
			    return Forth.Dictionary.Word_List.Map is
    begin
	Return State.Dictionary;
    end Get_Dictionary;

    Function Print_Stack(
		    State : in out	Forth.VM.Interpreter;
		    Stack : Stack_Type
		  ) return String is
      (case Stack is
       when Data_Stack		=> Forth.Data_Stack.Image( State.Data ),
       when Return_Stack	=> Forth.Return_Stack.Image( State.Returns )
      );

End Forth.VM;
