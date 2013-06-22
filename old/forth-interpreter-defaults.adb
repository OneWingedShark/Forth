separate (Forth.Interpreter)
Package Body Defaults is

    Function Words Return Word_Maps.Map is
    begin
	Return Result : Word_Maps.Map:= Word_Maps.Empty_Map do

	    Result.Include( "TEST", 128 );
	    null;
	End Return;
    end Words;
end Defaults;
