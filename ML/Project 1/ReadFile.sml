
fun read file =
    let
        fun next_int input =
	    Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) input)

        val stream = TextIO.openIn file
        val n = next_int stream
        val l = next_int stream
    in
        print"first number is: ";  print(Int.toString (n)); print"\n";
		print"second number is: "; print(Int.toString(l));  print"\n" 
    end;