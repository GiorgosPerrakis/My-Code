

fun parse file =
    let
	(* a function to read an integer from an input stream *)
        fun next_int input =
	    Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) input)

	(* open input file and read the two integers in the first line *)
        val stream = TextIO.openIn file
        val n = next_int stream
        val l = next_int stream
        val k = n + l
    in
        print(Int.toString (n)); print" next one is: "; print(Int.toString(l)); print"\n"; 
		print(Int.toString(k)); print("\n")
    end;