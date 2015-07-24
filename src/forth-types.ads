With
Interfaces,
Ada.Containers.Indefinite_Vectors,
Forth.String_Vector,
System.Storage_Elements,
Ada.Strings.Unbounded;

Limited With
Forth.VM;

Private With
Forth.Pools;
--  Forth.Pools.BLOB_Pool;

Package Forth.Types  with Preelaborate is

    -- The size of the cells for this implementation are given in bits.
    -- NOTE:	This does NOT include the space for the discriminant.
    Cell_Size : Constant := 64;


    -- Boolien is a Boolean-type with True = -1 and False = 0; the French
    -- spelling is used to prevent name-clashing with Standard.Boolean AND
    -- because of the French heritage of the Ada programming language.
    --
    -- Note:
    --		The value of -1 for truth is so that flags for
    --		not-zero, or odd, may be used as TRUE for opcodes.
    Type Boolien is (True, False) with Size => 64;
    For  Boolien Use ( True => -1, False => 0 );

    -- Boolean Operators.
    Function "AND"(Left, Right : Boolien) Return Boolien with Inline, Pure_Function;
    Function "OR" (Left, Right : Boolien) Return Boolien with Inline, Pure_Function;
    Function "XOR"(Left, Right : Boolien) Return Boolien with Inline, Pure_Function;
    Function "NOT"(	 Right : Boolien) Return Boolien with Inline, Pure_Function;

    Function "<"  (Left, Right : Boolien) Return Boolean with Inline, Pure_Function;

    -- Conversions to- and from- System.Boolean and Boolien.
    Function Convert( Input : Boolean ) Return Boolien is
      (if Input then True else False) with Inline, Pure_Function;
    Function Convert( Input : Boolien ) Return Boolean is
      (if Input = True then True else False) with Inline, Pure_Function;


    -- This is a renaming for convienience & berivity.
    Package US renames Ada.Strings.Unbounded;


    -- Definitions for the basic data-types.
    Type Element_Type is ( ftBoolean, ftInteger, ftFloat, ftString, ftBLOB );
    Type Type_Array is Array( Positive Range <> ) of Element_Type;


    -- BLOB defines a collection of variable-length, untyped data.
    Type BLOB is private;
    Function Image( Item : BLOB ) Return String;
    Function "<" ( Left, Right : Blob ) Return Boolean;
    Function "=" ( Left, Right : Blob ) Return Boolean;


    -- Cell defines the items which are pushed and popped on the data-stack.
    Type Cell( Data_Type : Element_Type:= ftBLOB ) is record
	Case Data_Type is
	When ftBoolean	=> Boolean_Value : Boolien;
	When ftInteger	=> Integer_Value : Interfaces.Integer_64;
	When ftFloat	=> Float_Value	 : Interfaces.IEEE_Float_64;
	When ftString	=> String_Value	 : US.Unbounded_String;
	When ftBLOB	=> BLOB_Value	 : BLOB;
	End case;
    end record with Pack; --, Size => Cell_Size + Element_Type'Object_Size;


    -- Cell comparisions.
    Function ">" ( Left, Right : Cell ) Return Boolean;
    Function "<" ( Left, Right : Cell ) Return Boolean;
    Function "=" ( Left, Right : Cell ) Return Boolean;


    -- Cell Creation Routines; they return a Cell containing the given value.
    Use Interfaces, US;
    Function Create_Cell( Value : Boolean	) Return Cell is
	( Data_Type => ftBoolean, Boolean_Value => Convert(Value) );
    Function Create_Cell( Value : Integer_64	) Return Cell is
	( Data_Type => ftInteger, Integer_Value => Value );
    Function Create_Cell( Value : IEEE_Float_64	) Return Cell is
	( Data_Type => ftFloat, Float_Value => Value );
    Function Create_Cell( Value : String	) Return Cell is
	( Data_Type => ftString, String_Value => To_Unbounded_String(Value) );
    Function Create_Cell( Addr : System.Address; Length : Natural ) Return Cell;

    -- Parse_Cell returns a cell containing an integer or a float if it is
    -- possible to parse the given string as a number of the given base;
    -- otherwise, OPERAND_ERROR is raised.
    Function Parse_Cell( Number : String; Base : Positive:= 10 ) return Cell;

    Function Convert( Item : Cell; Target : Element_Type ) Return Cell
      with post => Convert'Result.Data_Type = Target;

    Function Image( Item : Cell ) Return String;


    -- The items which are pushed on the return-stack.
    Type Return_Record( Address : Boolean:= True ) is record
	case Address is
	when true  => Return_Address	: System.Address;
	when false => Temp_Variable	: not null access Cell;
	end case;
    end record;

    Function Image( Item : Return_Record ) Return String;



    -- Definition_Character is a
    SubType Definition_Character is Character -- range  '!'..'~';
    with Static_Predicate => Definition_Character in '!'..'~' ;

    -- A Definition_String is a string which may be defined as a word, its
    -- constrainte are as follows: it must have a length of 1..31 and cannot
    -- contain any non-graphic characters.
    SubType Definition_String is String
    with Dynamic_Predicate => Definition_String'Length in 1..31 AND
      (For All I in Definition_String'Range =>
		    Definition_String(I) in Definition_Character );

    -- Routine is an access to a procedure; this cannot be put into a
    -- subpool, sadly, and is intended only for definition of words;
    -- typically, the routines pointed to should have full view of the
    -- VM (that is the stacks) in order to manipulate them.
    Type Routine;

    -- A Word is either a list of words or a pointer to a parameterless
    -- procedure; in the latter case the value of Leaf is true, otherwise
    -- the discriminant is false.
    Type Word	( Leaf : Boolean ) is private;
    Function Create( Definition : Routine		)  return Word;
    Function Create( Definition : String_Vector.Vector  )  return Word;

    -- Execute the word.
    Procedure Execute( State : in out Forth.VM.Interpreter;
		       Item  : Word );
    Procedure Execute( State : in out Forth.VM.Interpreter;
		       Item  : Definition_String );

    -- Public visibility to ensure that procedures ay be pointed to.
    Type Routine is Access Procedure( State : not null access Forth.VM.Interpreter );

    -- Image returns the defining string.
    Function Image( Item : Word ) return String;


Private

    -- Type_Pool defines a preelaborate_initalization type of subpool
    -- which we can then specify.
--     Package Type_Pool is new Forth.Pools.BLOB_Pool;
   package Type_Pool renames Forth.Pools;


    -- Various pool definitions.
    BLOBS: Type_Pool.User_Pool;


    -- Word_Type is the definition of a word; it is either a list of words
    -- or it is a segment of code to execute.
    Type Word ( Leaf : Boolean ) is record
	case Leaf is
	when True	=> Code  : Routine;
	when False	=> List  : String_Vector.Vector;
	end case;
    end record;


    -- BLOB is actually an access to a storage-array [of Storage-Elements].
    Type BLOB is Not Null Access All System.Storage_Elements.Storage_Array
    with
  	Storage_Pool	=> BLOBS,
	Size		=> Cell_Size;

    Function Create( Definition : Routine )  return Word is
      ( Leaf => True, Code => Definition );

    Function Create( Definition : String_Vector.Vector  )  return Word is
      ( Leaf => False, List => Definition );

    -- Parse_Number returns the number of the given-type if it is possible to
    -- parse, otherwise it will raise OPERAND_ERROR.
    Function Parse_Number( S : String ) Return Interfaces.Integer_64;
    Function Parse_Number( S : String ) Return Interfaces.IEEE_Float_64;


End Forth.Types;
