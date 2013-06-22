With
Forth.Stack,
Forth.Types;

Use
Forth.Types;

Package Forth.Data_Stack	is new Forth.Stack( Element => Cell )
with Preelaborate;

Pragma Preelaborate( Forth.Data_Stack );
