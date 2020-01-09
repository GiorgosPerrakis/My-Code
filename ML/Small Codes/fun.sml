fun loop k =
   if k < 0 then (print"Zero\n")
   else 
   (
      print(Int.toString(k * k));
	  print("\n");
	  loop(k-1)
   );
   