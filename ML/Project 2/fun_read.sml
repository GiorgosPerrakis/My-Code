fun read (infile : string) = 
let   
  val ins = TextIO.openIn infile 
  fun loop ins = 
   case TextIO.inputLine ins of 

      SOME line => line :: loop ins 

    | NONE      => [] 
in 
  loop ins before TextIO.closeIn ins 
end ;

  




			

   
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  