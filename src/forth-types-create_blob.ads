Function Forth.Types.Create_BLOB( Data : System.Address; Length : Natural:= Cell_Size/System.Storage_Elements.Storage_Element'Size )
				  Return BLOB with Preelaborate => True;
Pragma Preelaborate( Create_BLOB );
