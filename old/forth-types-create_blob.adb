Pragma Ada_2012;
with System.Storage_Elements;

Function Forth.Types.Create_BLOB( Data : System.Address; Length : Natural )
				  Return BLOB is

    Use System.Storage_Elements;

    -- To set up the proper constraints we need the proper indices; in the case
    -- of a length of 0 we need a null-range, where a type's 'First > its 'Last.
    Len   : constant Storage_Offset := Storage_Offset( Length );
    Start : Constant Storage_Offset := (if Length = 0 then 2 else 1);
    Stop  : Constant Storage_Offset := Storage_Offset'Max(1, Len);

    -- Constrain Storage_Array to the proper size.
    subtype Data_Length	is Storage_Offset range Start..Stop;
    subtype Data_Array	is Storage_Array(Data_Length);

    Pragma Warnings(Off);
    -- Create a constrained aliased variable, and overlay it on the data.
    Data_Items : Data_Array
      with Address => Data, Import, Convention => Ada;
    Pragma Warnings(On);

begin
    -- Return the result, which is a 'pointer' to a copy of the given Data.
    Return New Storage_Array'( Data_Items );
end Forth.Types.Create_BLOB;
