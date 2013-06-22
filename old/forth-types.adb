With
Ada.Unchecked_Conversion,
Forth.Types.Create_BLOB;

Package Body Forth.Types is
    Use System;

    Function Create_Cell( Addr : Address; Length : Natural ) Return Cell is
      ( Data_Type => ftBLOB, BLOB_Value => Create_BLOB(Addr, Length) );

    -- The value-function exists to allow arithmatic expression/manipulation
    -- of Boolien values; this exists for the reducing operations.
    Function Value is new Ada.Unchecked_Conversion(
		Source => Boolien,
		Target => Interfaces.Integer_64
	);

    Function "AND"(Left, Right : Boolien) Return Boolien is
	-- (if Left = True and Right = True then True else False)
	-- Adding Abs to the addition and checking equality with 2 would
	-- be portable, however this is optimizing for fewer operations.
      (if Value(Left) + Value(Right) = -2 then True else False);

    Function "OR" (Left, Right : Boolien) Return Boolien is
	-- (if Left = True or Right = True then True else False)
      (if Value(Left) + Value(Right) /= 0 then True else False);

    Function "XOR"(Left, Right : Boolien) Return Boolien is
      (if Left /= Right then True else False);

    Function "NOT"(	 Right : Boolien) Return Boolien is
    begin
	Return Boolien'Succ( Right );
    Exception
	When Constraint_Error => Return Boolien'First;
    end "NOT";

End Forth.Types;
