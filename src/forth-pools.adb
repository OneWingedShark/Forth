
With
--Ada.Unchecked_Deallocate_Subpool,
System.Address_To_Access_Conversions;

Pragma Warnings(Off);
With
System.Storage_Pools.Subpools.Finalization;
Pragma Warnings(On);


Package Body Forth.Pools is

    Package Access_Conversions is
      new System.Address_To_Access_Conversions(MR_Subpool);

    use type Subpool_Handle;

    --------------------------------------------------------------
   procedure Allocate
     (Pool                     : in out User_Pool;
      Storage_Address          : out System.Address;
      Size_In_Storage_Elements : System.Storage_Elements.Storage_Count;
      Alignment                : System.Storage_Elements.Storage_Count) is
    begin
	null;
    end Allocate;

   procedure Deallocate
     (Pool                     : in out User_Pool;
      Storage_Address          : System.Address;
      Size_In_Storage_Elements : System.Storage_Elements.Storage_Count;
      Alignment                : System.Storage_Elements.Storage_Count) is
    begin
	null;
    end Deallocate;

   function Storage_Size
     (Pool : User_Pool)
      return System.Storage_Elements.Storage_Count is
    begin
	return 0;
    end Storage_Size;
    --------------------------------------------------------------


    procedure Initialize (Pool : in out Mark_Release_Pool_Type) is
	-- Initialize the first default subpool.
    begin
	Pool.Markers(1).Start := 1;
	Subpools.Set_Pool_of_Subpool
	  (Pool.Markers(1)'Unchecked_Access, Pool);
    end Initialize;

    function Create_Subpool (Pool : in out Mark_Release_Pool_Type)
			    return not null Subpool_Handle is
	-- Mark the current allocation location.
    begin
	if Pool.Current_Pool = Subpool_Indexes'Last then
	    raise Storage_Error; -- No more subpools.
	end if;
	Pool.Current_Pool := Pool.Current_Pool + 1; -- Move to the next subpool

	return Result : constant not null Subpool_Handle :=
	  Pool.Markers(Pool.Current_Pool)'Unchecked_Access
	do
	    Pool.Markers(Pool.Current_Pool).Start := Pool.Next_Allocation;
	    Subpools.Set_Pool_of_Subpool (Result, Pool);
	end return;
    end Create_Subpool;

    procedure Deallocate_Subpool (
				  Pool : in out Mark_Release_Pool_Type;
				  Subpool : in out Subpool_Handle) is
    begin
	if Subpool /= Pool.Markers(Pool.Current_Pool)'Unchecked_Access then
	    raise Program_Error; -- Only the last marked subpool can be released.
	end if;
	if Pool.Current_Pool /= 1 then
	    Pool.Next_Allocation := Pool.Markers(Pool.Current_Pool).Start;
	    Pool.Current_Pool := Pool.Current_Pool - 1; -- Move to the previous subpool
	else -- Reinitialize the default subpool:
	    Pool.Next_Allocation := 1;
	    Subpools.Set_Pool_of_Subpool
	      (Pool.Markers(1)'Unchecked_Access, Pool);
	end if;
    end Deallocate_Subpool;

    function Default_Subpool_for_Pool (Pool : in out Mark_Release_Pool_Type)
				       return not null Subpool_Handle is
	Marker	: Subpool_Array  renames Pool.Markers;
	Current	: Constant System.Address := Marker(Pool.Current_Pool)'Address;

	Use Access_Conversions;
    begin
	return Subpool_Handle( To_Pointer( Current ) );
    end Default_Subpool_for_Pool;

    procedure Allocate_From_Subpool (
				     Pool : in out Mark_Release_Pool_Type;
				     Storage_Address : out System.Address;
				     Size_In_Storage_Elements : in Storage_Count;
				     Alignment : in Storage_Count;
				     Subpool : not null Subpool_Handle) is
    begin
	if Subpool /= Pool.Markers(Pool.Current_Pool)'Unchecked_Access then
	    raise Program_Error; -- Only the last marked subpool can be used for allocations.
	end if;

	-- Correct the alignment if necessary:
	Pool.Next_Allocation := Pool.Next_Allocation +
	  ((-Pool.Next_Allocation) mod Alignment);
	if Pool.Next_Allocation + Size_In_Storage_Elements >
	  Pool.Pool_Size then
	    raise Storage_Error; -- Out of space.
	end if;
	Storage_Address := Pool.Storage (Pool.Next_Allocation)'Address;
	Pool.Next_Allocation :=
	  Pool.Next_Allocation + Size_In_Storage_Elements;
    end Allocate_From_Subpool;

    procedure Release (Subpool : in out Subpool_Handle) is
	-- renames Ada.Unchecked_Deallocate_Subpool;
	Use System.Storage_Pools.Subpools.Finalization;
    begin
	Finalize_And_Deallocate (Subpool);
    end Release;

End Forth.Pools;
