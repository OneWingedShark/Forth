With
Forth.Operand_stack,
Ada.Containers.Indefinite_Ordered_Maps;

Package Body Forth.Interpreter is

    -- Package renaming for convenience.
    Package Word_Maps renames Forth.Dictionary.Word_List;

    -- Package for defining the default words entered in the dictionary.
    Package Defaults is
	Function Words Return Word_Maps.Map;
    End Defaults;
    Package Body Defaults is Separate;


    Type Interpreter_Implementation is record
	Return_Stack	: Aliased Integer;
	Data_Stack	: Aliased Forth.Operand_stack.Stack;
	Dictionary	: Aliased Word_Maps.Map:= Defaults.Words;
    end record;


    Function  Create Return not null access Interpreter_Implementation is
      (New Interpreter_Implementation'( others => <> ));
	--  The above is shorthand for:
	--      begin
	--  	Return New Interpreter_Implementation'( others => <> );
	--      end Create;

    Function  Create Return Interpreter is
	( Interpreter'( Handle => Create ) );

    Procedure Define( Machine : Interpreter; Input : String ) is
    begin
	null;
    End Define;


    Function Get_Dictionary( Item : Interpreter )
			    Return Forth.Dictionary.Word_List.Map is
	( Item.Handle.All.Dictionary );

End Forth.Interpreter;
