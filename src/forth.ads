With
System;

Package Forth with Pure, Elaborate_Body is

    -- STACK_UNDERFLOW is raised when the attepmt is made to push onto a full stack.
    STACK_UNDERFLOW,

    -- STACK_OVERFLOW is raised when the attepmt is made to pop off of a full stack.
    STACK_OVERFLOW,

    -- UNDEFINED_ENTRY is raised when an attempt to use an undefined word is made.
    UNDEFINED_ENTRY,

    -- OPERAND_ERROR is raised when a word expects the data-type is different than expected.
    OPERAND_ERROR,

    -- EXITUS (because exit & teminate are keywords) is the normal termination method.
    EXITUS

			: Exception;


--      Function Get_Dictionary( Environment : Interpreter )
--  			     Return Forth.Dictionary.Word_List.Map;

Private


End Forth;
