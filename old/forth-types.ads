With
Interfaces,
System.Storage_Elements,
Ada.Strings.Unbounded;

Private With
Forth.Pools;

Package Forth.Types is -- with Preelaborate is

    -- Boolien is a Boolean-type with True = -1 and False = 0; the French
    -- spelling is used to prevent name-clashing with Standard.Boolean AND
    -- because of the French heritage of the Ada programming language.
    --
    -- Note:
    --		The value of -1 for truth is so that flags for
    --		not-zero, or odd, may be used as TRUE for opcodes.
    Type Boolien is (True, False) with Size => 64;
    For Boolien Use ( True => -1, False => 0 );

    -- Boolean Operators.
    Function "AND"(Left, Right : Boolien) Return Boolien with Inline, Pure_Function;
    Function "OR" (Left, Right : Boolien) Return Boolien with Inline, Pure_Function;
    Function "XOR"(Left, Right : Boolien) Return Boolien with Inline, Pure_Function;
    Function "NOT"(	 Right : Boolien) Return Boolien with Inline, Pure_Function;


    -- Conversions to- and from- System.Boolean and Boolien.
    Function Convert( Input : Boolean ) Return Boolien is
      (if Input then True else False) with Inline, Pure_Function;
    Function Convert( Input : Boolien ) Return Boolean is
      (if Input = True then True else False) with Inline, Pure_Function;


    -- This is a renaming for convienience & berivity.
    Package US renames Ada.Strings.Unbounded;


    -- Definitions for the basic data-types.
    Type Element_Type is ( ftBoolean, ftInteger, ftFloat, ftString, ftBLOB );


    -- BLOB defines a collection of variable-length, untyped data.
    Type BLOB is private;


    -- Cell defines the items which are pushed and popped on the data-stack.
    Type Cell( Data_Type : Element_Type:= ftBLOB ) is record
	Case Data_Type is
	When ftBoolean	=> Boolean_Value : Boolien;
	When ftInteger	=> Integer_Value : Interfaces.Integer_64;
	When ftFloat	=> Float_Value	 : Interfaces.IEEE_Float_64;
	When ftString	=> String_Value	 : US.Unbounded_String;
	When ftBLOB	=> BLOB_Value	 : BLOB;
	End case;
    end record;


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



    -- The items which are pushed on the return-stack.
    Type Return_Record( Address : Boolean:= True ) is record
	case Address is
	when true  => Return_Address	: System.Address;
	when false => Temp_Variable	: not null access Cell;
	end case;
    end record;


Private
    T_Val : Constant:= -1;
    F_Val : Constant:=  0;

    -- BLOB is actually an access to a storage-array [of Storage-Elements].
    Type BLOB is Not Null Access All System.Storage_Elements.Storage_Array
    with Storage_Pool => Forth.Pools.Forth_Memory;

End Forth.Types;
