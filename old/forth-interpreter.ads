With
Forth.Dictionary.Word_List,
Forth.Types;

Use
Forth.Types;

Package Forth.Interpreter is

    -- The type "Interpreter" is the publicly visible access/interface to the
    -- Forth interpreter-engine.
    Type Interpreter(<>) is private;

    -- Create returns the default instance.
    Function  Create Return Interpreter;

    -- Adds a word to the dictionary of the given Interpreter.
    Procedure Define( Machine : Interpreter; Input : String );

    -- Returns the dictionary of the given interpreter.
    Function Get_Dictionary( Item : Interpreter )
			    	Return Forth.Dictionary.Word_List.Map;

Private

    -- Interpreter_Implementation is a "Taft Type", meaning it is privately
    -- declared, but defined in the body. The consequence of this is that the
    -- modifications to this type do not require recompilation of everything
    -- dependant on this spec-file... which would be the entire Forth hierarchy.
    --
    -- The Forth interpreter contains a dictionary and two stacks; the stacks
    -- are the Return and Data stacks.
    Type Interpreter_Implementation;


    -- Interpreter is almost an "opaque pointer" to the implementation-type,
    -- it is insted a discriminateed null record with such a pointer, so that
    -- the Implicit_Dereference aspect might possibly be used... at this point
    -- in time that is of no real impact.
    Type Interpreter( Handle : not null access Interpreter_Implementation ) is
      null record with Implicit_Dereference => Handle;

End Forth.Interpreter;
