With
System.Storage_Elements,
System.Storage_Pools.Subpools;

Private Package Forth.Pools with Elaborate_Body, Preelaborate is

    use System.Storage_Pools, System.Storage_Elements;

     type User_Pool is new
	  System.Storage_Pools.Root_Storage_Pool with null record;


   procedure Allocate
     (Pool                     : in out User_Pool;
      Storage_Address          : out System.Address;
      Size_In_Storage_Elements : System.Storage_Elements.Storage_Count;
      Alignment                : System.Storage_Elements.Storage_Count);

   procedure Deallocate
     (Pool                     : in out User_Pool;
      Storage_Address          : System.Address;
      Size_In_Storage_Elements : System.Storage_Elements.Storage_Count;
      Alignment                : System.Storage_Elements.Storage_Count);

   function Storage_Size
     (Pool : User_Pool)
      return System.Storage_Elements.Storage_Count;


   -- Mark and Release work in a stack fashion, and allocations are not allowed
   -- from a subpool other than the one at the top of the stack. This is also
   -- the default pool.

   subtype Subpool_Handle is Subpools.Subpool_Handle;

   type Mark_Release_Pool_Type (Pool_Size : Storage_Count) is new
      Subpools.Root_Storage_Pool_With_Subpools with private;

   function Mark (Pool : in out Mark_Release_Pool_Type)
      return not null Subpool_Handle;

    procedure Release (Subpool : in out Subpool_Handle);

    --      type MR_Subpool is new Subpools.Root_Subpool with private;

    Use System.Storage_Pools;


private

   type MR_Subpool is new Subpools.Root_Subpool with record
      Start : Storage_Count;
   end record;
   subtype Subpool_Indexes is Positive range 1 .. 10;
   type Subpool_Array is array (Subpool_Indexes) of aliased MR_Subpool;


   type Mark_Release_Pool_Type (Pool_Size : Storage_Count) is new
      Subpools.Root_Storage_Pool_With_Subpools with record
      Storage         : Storage_Array (1..Pool_Size);
      Next_Allocation : Storage_Count := 0;
      Markers         : Subpool_Array;
      Current_Pool    : Subpool_Indexes := 1;
   end record;

   overriding
   function Create_Subpool (Pool : in out Mark_Release_Pool_Type)
      return not null Subpool_Handle;

   function Mark (Pool : in out Mark_Release_Pool_Type)
      return not null Subpool_Handle renames Create_Subpool;

   overriding
   procedure Allocate_From_Subpool (
      Pool : in out Mark_Release_Pool_Type;
      Storage_Address : out System.Address;
      Size_In_Storage_Elements : in Storage_Count;
      Alignment : in Storage_Count;
      Subpool : not null Subpool_Handle);

   overriding
   procedure Deallocate_Subpool (
      Pool : in out Mark_Release_Pool_Type;
      Subpool : in out Subpool_Handle);

   overriding
   function Default_Subpool_for_Pool (Pool : in Mark_Release_Pool_Type)
      return not null Subpool_Handle;

   overriding
   procedure Initialize (Pool : in out Mark_Release_Pool_Type);


--       type User_Pool is new
--             System.Storage_Pools.Root_Storage_Pool with null record;
End Forth.Pools;
