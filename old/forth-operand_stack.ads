With Forth.Stack;

private package Forth.Operand_stack is new Forth.Stack(
		Element => Integer,
		Image   => Integer'Image
	);
