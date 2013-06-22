With
Forth.Stack,
Forth.Types;

Use
Forth.Types;

Package Forth.Return_Stack	is new Forth.Stack( Element => Return_Record )
with Preelaborate;

Pragma Preelaborate( Forth.Return_Stack );
