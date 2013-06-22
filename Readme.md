**Forth** *in Ada*
==================

Here are my attempts to write a *Forth* interpreter in Ada. I am not using the straight method, instead opting to give a few types to the system (Integers and Strings, most notably).

------------------------------------------------------

Parsing/Interpretive Oddities
-----------------------------
* Input strings are parsed as space-delimited [tabs are not handled, currently] words by `Forth.Tokenize`.
* This list of words is then processed (`Forth.Handle_Strings`) such that ." and s" trigger a routine to merge the trailing strings in the list [and add the missing spaces] which is terminated by a string in the list which ends with the double-quote and is **_not_** two consecutive double-quotes.
* A word of two consecutive double-quotes is translated to a single double-quote.
* Everything so far has not used the return-stack.


To Do:
------
0. Continue adding the core words.
0. Implement sane operators for the base types, especially BLOB.
0. Profit?