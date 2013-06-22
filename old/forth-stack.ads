With
Ada.Containers.Indefinite_Vectors;

Generic
    Maximum : Positive := 2048;
    Type Element is private;
    With Function Image( Item : Element ) Return String is <>;
Package Forth.Stack is

    --Pragma Pure(Forth.Stack);

    Type Stack is limited private;

    Procedure Push ( Stack : in out Forth.Stack.Stack; Item : Element )
    with pre => not Full( Stack );

    Procedure Pop  ( Stack : in out Forth.Stack.Stack; Item : out Element )
    with pre => not Empty( Stack );

    Procedure Swap( Stack : in out Forth.Stack.Stack )
    with pre => not Empty( Stack ) AND Minimum( Stack, 2 );

    Procedure Dup ( Stack : in out Forth.Stack.Stack );

    Procedure Rot ( Stack : in out Forth.Stack.Stack; Item : out Element )
    with pre => not Empty( Stack );

    Procedure Clear( Stack : in out Forth.Stack.Stack )
    with post => Empty( Stack );


    Function Full	( Stack : Forth.Stack.Stack ) Return Boolean;
    Function Empty	( Stack : Forth.Stack.Stack ) Return Boolean;
    Function Minimum	( Stack : Forth.Stack.Stack;
			  Value : Positive ) Return Boolean;

Private
    Use  Ada.Containers;

    Package Implementation is new Indefinite_Vectors(
		Index_Type	=> Positive,
		Element_Type	=> Element
	);

    Type Stack is new Implementation.Vector with null record;

    Function Top ( Stack : in Forth.Stack.Stack ) Return Element
    with pre => not Empty( Stack );

    Function Pop ( Stack : in out Forth.Stack.Stack ) Return Element;

    Function Full( Stack : Forth.Stack.Stack ) Return Boolean is
	( Stack.Length >= Count_type(Maximum) );

    Function Empty( Stack : Forth.Stack.Stack ) Return Boolean is
	( Stack.Length = 0 );

    Function Minimum	( Stack : Forth.Stack.Stack;
			  Value : Positive ) Return Boolean is
      ( Stack.Length >= Count_Type(Value) );

End Forth.Stack;
