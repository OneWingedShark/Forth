With
Ada.Unchecked_Deallocate_Subpool;

Separate(Forth.Pools)
procedure Release (Subpool : in out Subpool_Handle) is
begin
    Ada.Unchecked_Deallocate_Subpool(Subpool);
End Release;
