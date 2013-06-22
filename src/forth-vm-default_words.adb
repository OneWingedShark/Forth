With
Forth.Types,
Forth.VM.Functions;

Use
Forth.Types,
Forth.VM.Functions;

Function Forth.VM.Default_Words Return Forth.Dictionary.Word_List.Map is

    Procedure Define(
		     Container	: in out Forth.Dictionary.Word_List.Map;
		     Name	: Definition_String;
		     Callback	: Routine
		    ) is
    begin
	Container.Insert(Key => Name, New_Item => Create(Callback) );
    end Define;

    Pragma Inline (Define);

begin
    Return Result : Forth.Dictionary.Word_List.Map do
	Define( Result, "CLR",		Clear_Data'Access		);

	Define( Result, "MAX",		Max'Access			);
	Define( Result, "MIN",		Min'Access			);
	Define( Result, "PICK",		Cell_PICK'Access		);
	Define( Result, "OVER",		Cell_OVER'Access		);
	Define( Result, "ROLL",		Cell_ROLL'Access		);
	Define( Result, "ROT",		Cell_ROT'Access			);
	Define( Result, "SWAP",		Cell_SWAP'Access		);

	Define( Result, ".""",		Dot_Quote'Access		);
	Define( Result, "s""",		Ess_Quote'Access		);
	Define( Result, ":",		Define'Access			);
	Define( Result, ";",		End_Define'Access		);
	Define( Result, "WORDS",	Words'Access			);


	Define( Result, "BYE",		Terminate_Execution'Access	);
    end return;
End Forth.VM.Default_Words;

Pragma Preelaborate(Default_Words);
