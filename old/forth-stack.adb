Package Body Forth.Stack is

    Function Top ( Stack : in Forth.Stack.Stack ) Return Element
		  renames Last_Element;

    Procedure Push( Stack : in out Forth.Stack.Stack; Item : Element ) is
    begin
	Stack.Append( Item );
    End Push;


    Procedure Pop( Stack : in out Forth.Stack.Stack; Item : out Element ) is
    begin
	Item:= Stack.Pop;
    End Pop;


    Function Pop( Stack : in out Forth.Stack.Stack ) Return Element is
    begin
	Return Result : Element := Stack.First_Element do
	    Stack.Delete_First;
	End return;
    End Pop;

    Procedure Swap( Stack : in out Forth.Stack.Stack ) is
	Top : Positive := Positive(Stack.Length);
    begin
	Implementation.Vector(Stack).Swap( I => Top, J => Top-1 );
    End Swap;

    Procedure Dup ( Stack : in out Forth.Stack.Stack ) is
    begin
	Stack.Push( Stack.Top );
    End Dup;

    Procedure Rot ( Stack : in out Forth.Stack.Stack; Item : out Element ) is
	pragma Unreferenced (Item);
	S   : Implementation.Vector Renames Implementation.Vector(Stack);
	Top : Positive := Positive( S.Length );
    begin
	-- Start:	[1 2 3]
	S.Swap(I => Top,	J => Top-2);
	-- Step-1: 	[3 2 1]
	S.Swap(I => Top,	J => Top-1);
	-- Finish:	[2 1 3]
    End Rot;

    Procedure Clear( Stack : in out Forth.Stack.Stack ) is
    begin
	Implementation.Clear( Implementation.Vector(Stack) );
    end Clear;


End Forth.Stack;
