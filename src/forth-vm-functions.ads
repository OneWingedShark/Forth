Package Forth.VM.Functions with Preelaborate is

    -- Terminate the execution of the interpreter; ALWAYS RAISE EXITUS.
    Procedure Terminate_Execution(State : not null access Forth.VM.Interpreter);

    -- Clear the Data-stack of all entries.
    Procedure Clear_Data( State : not null access Forth.VM.Interpreter );

--------------------------------------------------------------------------------
--			R E Q U I R E D   W O R D S			      --
--------------------------------------------------------------------------------



----[	Nucleus layer		]-----------------------------------------------



   -- !		(n1 -- )
   Procedure Store( State : not null access Forth.VM.Interpreter );
   --*  */

--*/MOD  +  +!  -  /  /MOD  0<  0=  0>  1+  1-  2+
--  2-  2/  <  =  >  >R  ?DUP  @  ABS  AND  C!  C@  CMOVE
--  CMOVE>  COUNT  D+  D<  DEPTH  DNEGATE  DROP  DUP  EXECUTE
--  EXIT  FILL  I  J

    -- MAX	(n1 n2 -- n3)
    --	n3 is the greater of n1 and n2 according to the operation of ">" .
    Procedure Max( State : not null access Forth.VM.Interpreter );

    -- MIN	(n1 n2 -- n3)
    --	n3 is the lesser of n1 and n2 according to the operation of "<" .
    Procedure Min( State : not null access Forth.VM.Interpreter );

    -- MOD  NEGATE

    -- NOT	(n1 -- n2)
    Procedure Cell_NOT ( State : not null access Forth.VM.Interpreter );

    -- OR	(n1 -- n2)
    Procedure Cell_OR  ( State : not null access Forth.VM.Interpreter );

    -- OVER	(n1 n2 n3 -- n2 n1 n2 n3)
    -- Pushes a copy of the next-on-stack.
    Procedure Cell_OVER( State : not null access Forth.VM.Interpreter );

    -- PICK	(n n0 n1 n2 n3 .. nx -- n[n] n0 n1 n2 n3 .. nx)
    -- Pushes a copy of the nth element of the stack; 0-based offset.
    Procedure Cell_PICK( State : not null access Forth.VM.Interpreter );

    --  R>  R@

    -- ROLL
    Procedure Cell_ROLL( State : not null access Forth.VM.Interpreter );

    -- ROT
    Procedure Cell_ROT( State : not null access Forth.VM.Interpreter );

    -- SWAP
    Procedure Cell_SWAP( State : not null access Forth.VM.Interpreter );


    --_  U<  UM*  UM/MOD  XOR


----[	Device layer		]-----------------------------------------------


--  BLOCK  BUFFER  CR  EMIT  EXPECT  FLUSH  KEY  SAVE-BUFFERS
--  SPACE  SPACES  TYPE  UPDATE
--


----[	Interpreter layer	]-----------------------------------------------

--  #  #>  #S  #TIB  '  (  -TRAILING  .  .(  <#  >BODY  >IN
--  ABORT  BASE  BLK  CONVERT  DECIMAL  DEFINITIONS  FIND
--  FORGET  FORTH  FORTH-83  HERE  HOLD  LOAD  PAD  QUIT  SIGN
--  SPAN  TIB  U.  WORD


----[	Compiler layer		]-----------------------------------------------


    --  +LOOP  ,

    -- ."
    Procedure Dot_Quote( State : not null access Forth.VM.Interpreter );

    -- :
    Procedure Define( State : not null access Forth.VM.Interpreter );

    -- ;
    Procedure End_Define( State : not null access Forth.VM.Interpreter );

--ABORT"  ALLOT  BEGIN  COMPILE  CONSTANT
--  CREATE  DO  DOES>  ELSE  IF  IMMEDIATE  LEAVE  LITERAL  LOOP
--  REPEAT  STATE  THEN  UNTIL  VARIABLE  VOCABULARY  WHILE

----[	Misc functions		]-----------------------------------------------

    -- s"
    --	Takes the next input-string as a string and pushes it on the stack.
    Procedure Ess_Quote( State : not null access Forth.VM.Interpreter );

    -- WORDS
    --	Displays the words contained in the dictionary,
    Procedure Words( State : not null access Forth.VM.Interpreter );

    -- SEE
    --	Displays the definition of the word following.
    Procedure See( State : not null access Forth.VM.Interpreter );

End Forth.VM.Functions;

Pragma Preelaborate(Forth.VM.Functions);
