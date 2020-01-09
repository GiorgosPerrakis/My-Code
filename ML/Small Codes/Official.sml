fun revsum file =
    let
	    fun next_int input =
	       Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) input)

        val stream = TextIO.openIn file
        val n = next_int stream
		val y = Int.toString n
		val s = explode(y)
		val x = length(s)
		
        fun function x = 
           let
   		      val N = [];
		
		      if(x=0) then (print("No input number found"))
		      else if (x=1)
		      ( 
                if((hd(s))%2=0)
                (
			       hd(N) = hd(s)/2		   
			    )
                else print""			
		      );		
		
	       in
              print(Int.toString(N)); print"\n"
	       end;	
		
	in
        print"end\n"	
	end;
	
	

	
	
 