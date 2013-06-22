Pragma Ada_2012;

Limited With
Forth.Interpreter;

-- Purpose:
--	The purpose of Forth.Dictionary is to provide auxilary functions to the
--	actual dictionary, which is an instance of the MAP type of its own
--	child-package (Forth.Dictionary.Worrd_List); the reason for this
--	slight convolution is that Word_List is an instantiation of the generic
--	package Indefinite_Ordered_Maps and child-packages of generic instances
--	"must be an instance or renaming" thus severly limiting the usefulness.
--
-- Notes:
--	Due to the above restrictions, operations in the specification will act
--	upon the Interpreter type contained in Forth.Interpreter; dependence on
--	Word_List is therefore constrained to the body of the package.
Package Forth.Dictionary is


    Procedure Print( List : Forth.Interpreter.Interpreter   );

End Forth.Dictionary;
