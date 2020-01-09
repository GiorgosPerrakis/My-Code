

fun loop file count =
        let
		      if count < 0 then (print"end\n")
			  else
			  (
			       fun next_int input = 
			         Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) input)
			       val stream = TextIO.openIn file
                   val n = next_int stream
			
		          print(Int.toString(n));
	              print("\n");
	              loop(count-1)				  
			   )
         in 
		    print("\n")
         end;			
	
	
