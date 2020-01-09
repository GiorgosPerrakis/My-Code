fun f [] = 0
  | f (h::t) = 1 + f t
	
fun f' [] acc = acc                               //βοηθητικη συναρτηση
  | f' (h::t) acc = f' t (acc + 1)
	
fun length l = f' l 0                             //τελικη συναρτηση που καλει την βοηθητικη


//function that finds the minimum number that don't exist in the list

fun exists [] i = false                                            
  | exists (h::t) (i : int) = if i = h then true else exists t i
	
fun f l cnt = if exists l cnt then f l (cnt + 1) else cnt

fun f' l = f l 0

// better solution

fun sort l = ListMergeSort.sort (op > ) l

fun f [] i = i
  | f (h::t) i = if h = i then f t (i+1) else 
	if h < i then f t i else i                    //οταν εχει δυο φορες το ιδιο στοιχειο

// other solution
fun f [] i = i
  | f (h::t) i = if h = i then f t (i+1) else 
    f t i

fun f' l = 
let 
	val l' = sort l
in
	f l' 0
end		
	
	
// other solution -> delete duplicates
fun f [] i = i
  | f (h::t) i = if h = i then f t (i+1) else i	

  
fun f' l = 
let 
	val l' = sort l
	fun g [] acc = List.rev acc
	  | g [x] acc = List.rev (x :: acc)
	  | g (x :: y :: t) acc = 
		if x = y 
		then g (x :: t) acc 
		else g (y :: t) (x :: acc)
	val l'' = g l' []	
in
	f l'' 0
end	

//example

g [1,4,4] []
g [4,4] [1]
g [4] [1]
rev [4,1]





// best solution
// we have a boolean table and we set true all the elements of the list and 
// then we ask the table for each element


fun exists [] i = false                                            
  | exists (h::t) (i : int) = if i = h then true else exists t i
	
fun f a cnt = if Array.sub(a, cnt) then f a (cnt + 1) else cnt

fun f' l = 
let 
	val n = List.length l
	val a = Array.array(n, false)
	fun g [] a = ()
	 |  g (h::t) a = 
		if (h >= n then () 
	    else Array.update(a, h, true);
				g t a) 
in
	g l a;
	f a 0
end	
	

  
  
  
  
  
  
  
  
  
  