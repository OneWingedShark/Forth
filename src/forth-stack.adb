with
GNAT.IO,
Ada.Strings.Unbounded;

Package Body Forth.Stack is

    Function Top ( Stack : in Forth.Stack.Stack ) Return Element
		  renames Last_Element;

    Function Next_on_Stack( Stack : in Forth.Stack.Stack ) Return Element is
      ( Implementation.Element(Implementation.Previous(Stack.Last)) );

    Function Peek_Next	( Stack : Forth.Stack.Stack ) Return Element renames
      Next_on_Stack;

    Function Peek( Stack : Forth.Stack.Stack; Index : Natural ) Return Element is
	Data : Implementation.Vector Renames Implementation.Vector( Stack );
	Items : Natural := Natural(Data.Length);
    begin
	Return Data( Items-Index );
    end Peek;


    Procedure Push( Stack : in out Forth.Stack.Stack; Item : Element ) is
    begin
	Stack.Append( Item );
    End Push;

    Procedure Pop( Stack : in out Forth.Stack.Stack; Item : out Element ) is
    begin
	Item:= Stack.Pop;
    End Pop;

    Procedure Pop   ( Stack : in out Forth.Stack.Stack ) is
    begin
	Stack.Delete_Last;
    end Pop;

    Function Pop( Stack : in out Forth.Stack.Stack ) Return Element is
    begin
	Return Result : Element := Stack.Last_Element do
	    Stack.Delete_Last;
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

    Procedure Rot ( Stack : in out Forth.Stack.Stack ) is
	S   : Implementation.Vector Renames Implementation.Vector(Stack);
	Top : Positive := Positive( S.Length );
    begin
	S.Swap(I => Top-1,	J => Top-2);	-- ( n1 n2 n3 -- n1 n3 n2 )
	S.Swap(I => Top,	J => Top-2);	-- ( n1 n3 n2 -- n2 n3 n1 )
    End Rot;

    Procedure Roll ( Stack : in out Forth.Stack.Stack; Depth : Natural ) is
    begin
	if Stack.Empty then return; end if;

	declare
	    -- Offset to compensate for 1-based indexing w/ 0-based calculation.
	    Index : Constant Positive:= Natural(Stack.Length) - Depth + 2;
	    Item  : Constant Forth.Stack.Element:= Stack.Peek(Index);
	begin
	    Stack.Delete( Index-2 );
	    Stack.Push(Item => Item);
	end;
    end Roll;

    Procedure Clear( Stack : in out Forth.Stack.Stack ) is
    begin
	Implementation.Clear( Container => Implementation.Vector(Stack) );
    end Clear;

    Procedure Over( Stack : in out Forth.Stack.Stack ) is
	-- Renaming for berevity...
	Vector : Implementation.Vector Renames Implementation.Vector(Stack);

	Use Implementation;
	Second_Element	: Forth.Stack.Element renames
			   Implementation.Element(Previous(Vector.Last));
    begin
	Stack.Push( Second_Element );
    end Over;

    Function Image	( Stack : Forth.Stack.Stack ) Return String is
	Use Ada.Strings.Unbounded;
	Working : Unbounded_String;

    begin
	for Item of reverse Stack loop
	    Append( Source => Working, New_Item => Image(Item) & ' ' );
	end loop;

	Return  '[' & To_String(Trim(Working, Ada.Strings.Both)) & ']';
    end Image;

    Function Contains	( Stack : Forth.Stack.Stack; Item : Element; Depth : Positive:= 1 ) Return Boolean is
    begin
	Return Natural(Stack.Reverse_Find_Index(Item => Item)) >= Depth;
    end;


End Forth.Stack;
