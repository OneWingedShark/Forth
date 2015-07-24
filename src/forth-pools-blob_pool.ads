-- BLOB_Pool is merely a package defining a derivation of User_Pool
-- in order to create a pre-elaborable instance... this cannot be
-- done with a type which is not tagged with the pragma
-- "Preelaborable_Initialization" (not the aspect) in the public
-- portion of the specification, while omitting the aspect, not the
-- pragma in the private portion results in complaints that the full-
-- view "does not have Preelaborable_Initialization".
Generic
Package Forth.Pools.BLOB_Pool with Preelaborate is
   Pragma Preelaborate( Forth.Pools.BLOB_Pool );

    Type User_Pool is New Forth.Pools.User_Pool with private;
    pragma Preelaborable_Initialization( User_Pool );

private
    Type User_Pool is New Forth.Pools.User_Pool with null record
      with Preelaborable_Initialization;
End Forth.Pools.BLOB_Pool;
