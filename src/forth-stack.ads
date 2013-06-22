With
Ada.Containers.Indefinite_Vectors;

Generic
    Maximum : Positive := 2048;
    Type Element(<>) is private;
    With Function Image( Item : Element ) Return String is <>;
Package Forth.Stack with Preelaborate is

    Type Stack is limited private;

    ----------------------------------------------------------------------------
    -- STACK OPERATIONS							      --
    --	Note:	These take Stack as a parameter-name, and so the type must be --
    --		fully-qualified; the reason for naming them as such is to     --
    --		make calls using named parameter association nicer.           --
    ----------------------------------------------------------------------------

    -- PUSH	( n1 -- n2 n1 )
    Procedure Push ( Stack : in out Forth.Stack.Stack; Item : Element )
    with pre => not Full( Stack );

    -- POP	( n1 n2 n3 -- n2 n3 )
    Procedure Pop  ( Stack : in out Forth.Stack.Stack; Item : out Element )
    with pre => not Empty( Stack );
    Function Pop   ( Stack : in out Forth.Stack.Stack ) Return Element
    with pre => not Empty( Stack );
    Procedure Pop   ( Stack : in out Forth.Stack.Stack )
    with pre => not Empty( Stack );


    -- SWAP	( n1 n2 -- n2 n1 )
    Procedure Swap( Stack : in out Forth.Stack.Stack )
    with pre => not Empty( Stack ) AND Minimum( Stack, 2 );

    -- OVER	( n1 n2 -- n2 n1 n2 )
    Procedure Over( Stack : in out Forth.Stack.Stack )
    with pre => not Empty( Stack ) AND Minimum( Stack, 2 );

    -- DUP	( n1 -- n1 n1 )
    Procedure Dup ( Stack : in out Forth.Stack.Stack )
    with pre => not Full( Stack );

    -- ROT	( n1 n2 n3 -- n2 n3 n1 )
    Procedure Rot ( Stack : in out Forth.Stack.Stack )
    with pre => not Empty( Stack );

    Procedure Roll ( Stack : in out Forth.Stack.Stack; Depth : Natural )
    with pre => Minimum( Stack, Depth );

    -- CLEAR	( n1 n2 n3 -- )
    Procedure Clear( Stack : in out Forth.Stack.Stack )
    with post => Empty( Stack );


    Function Full	( Stack : Forth.Stack.Stack ) Return Boolean;
    Function Empty	( Stack : Forth.Stack.Stack ) Return Boolean;
    Function Minimum	( Stack : Forth.Stack.Stack;
			  Value : Positive ) Return Boolean;

    -- Look at the top element w/o popping it off the stack.
    Function Peek	( Stack : Forth.Stack.Stack ) Return Element;

    -- Look at the next element w/o popping it off the stack.
    Function Peek_Next	( Stack : Forth.Stack.Stack ) Return Element;

    -- Look at an arbitrary element on the Stack.
    Function Peek	( Stack : Forth.Stack.Stack; Index : Natural ) Return Element;

    -- Contains searches theStack for the specified element, of a
    -- depth not less than that given.
    Function Contains ( Stack : Forth.Stack.Stack; Item : Element; Depth : Positive:= 1 ) Return Boolean;

    -- Returns a space-delemited string inside square-brackets.
    Function Image	( Stack : Forth.Stack.Stack ) Return String;

Private
    Use  Ada.Containers;

    Package Implementation is new Indefinite_Vectors(
		Index_Type	=> Positive,
		Element_Type	=> Element
	);

    -- Because the type is exposed to the public portion of the spec we
    -- must derive it as a new type; furthermore, Object.method notation
    -- may not work with a subtype-renaming.
    Type Stack is new Implementation.Vector with null record;

    Function Top ( Stack : in Forth.Stack.Stack ) Return Element
    with pre => not Empty( Stack );

    Function Full( Stack : Forth.Stack.Stack ) Return Boolean is
	( Stack.Length >= Count_type(Maximum) );

    Function Empty( Stack : Forth.Stack.Stack ) Return Boolean is
	( Stack.Length = 0 );

    Function Minimum	( Stack : Forth.Stack.Stack;
			  Value : Positive ) Return Boolean is
      ( Stack.Length >= Count_Type(Value) );

    Function Peek	( Stack : Forth.Stack.Stack ) Return Element
			  renames Top;

End Forth.Stack;
