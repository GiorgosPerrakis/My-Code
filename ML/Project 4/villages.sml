fun readlist filename = let

    fun inlist (infile : string) = let
      val ins = TextIO.openIn infile
      fun buz(NONE) = 0
        | buz(SOME a) = a;
      fun loop ins =
       case TextIO.inputLine ins of
          SOME line => map (fn x => buz (Int.fromString x)) (String.tokens (fn x => if x = #" " orelse x = #"\n" then true else false) line) :: loop ins
        | NONE      => []
    in
      loop ins before TextIO.closeIn ins
    end

    val InList = inlist filename;
	in
		InList
	end;

fun find_N [] = 0
	| find_N (h::t) = h
	
fun find_M [] = 0
	| find_M [a] = 0
	| find_M (a::b::t) = b
	
fun find_K [] = 0
	| find_K [a] = 0
	| find_K [a,b] = 0
	| find_K (a::b::c::t) = c

fun find_and_update_parent table a b k =
	if ((a = b) andalso (Array.sub (table, a) < 0) andalso k = 0)
		then Array.update (table, b, ((Array.sub (table, b)) - 1))
	else if ((a = b) andalso (Array.sub (table, a) < 0) andalso k = 1)
		then ()
	else if ((Array.sub (table, a) >= 0) andalso (Array.sub (table, b) >= 0))
		then find_and_update_parent table (Array.sub (table, a)) (Array.sub (table, b)) k
	else if (Array.sub (table, a) >= 0)
		then find_and_update_parent table (Array.sub (table, a)) b k
	else if (Array.sub (table, b) >= 0)
		then find_and_update_parent table a (Array.sub (table, b)) k
	else if ((Array.sub (table, a)) >= (Array.sub (table, b)))
		then (Array.update (table, b, ((Array.sub (table, b)) + (Array.sub (table, a)) + 1)); Array.update (table, a, b))  
	else (Array.update (table, a, ((Array.sub (table, a)) + (Array.sub (table, b)) + 1)); Array.update (table, b, a))
			
fun update_table table [] = 0
	| update_table table ([p, q]::t) =
		let
			val a = p - 1
			val b = q - 1
		in
			if ((Array.sub (table, a) = ~1) andalso (Array.sub (table, b) = ~1)) 																		(* new nodes *)
				then (Array.update (table, a, ~2) ; Array.update (table, b, a) ; update_table table t)
			else if ((Array.sub (table, a) = ~1) andalso (Array.sub (table, b) < 0))																	(* father and new node *)
				then (Array.update (table, a, b) ; Array.update (table, b, ((Array.sub (table, b)) - 1)) ; update_table table t)
			else if ((Array.sub (table, a) < 0) andalso (Array.sub (table, b) = ~1))
				then (Array.update (table, b, a) ; Array.update (table, a, ((Array.sub (table, a)) - 1)) ; update_table table t)		
			else if ((Array.sub (table, a) = ~1) andalso (Array.sub (table, b) >= 0))																	(* child and new node *)
				then (Array.update (table, a, b) ; find_and_update_parent table b b 0; update_table table t)
			else if ((Array.sub (table, a) >= 0) andalso (Array.sub (table, b) = ~1))
				then (Array.update (table, b, a) ; find_and_update_parent table a a 0; update_table table t)
			else if ((Array.sub (table, a) < 0) andalso (Array.sub (table, b) < 0) andalso (Array.sub (table, a) >= Array.sub (table, b)))				(* father and father case 1 *)
				then (Array.update (table, b, (Array.sub (table, a) + Array.sub (table, b))) ; Array.update (table, a, b) ; update_table table t)
			else if ((Array.sub (table, a) < 0) andalso (Array.sub (table, b) < 0) andalso (Array.sub (table, a) < Array.sub (table, b)))		
				then (Array.update (table, a, (Array.sub (table, a) + Array.sub (table, b))) ; Array.update (table, b, a) ; update_table table t)	
			else if ((Array.sub (table, a) < 0) andalso (Array.sub (table, b) >= 0))																	(* father and child *)
				then (find_and_update_parent table a b 1; update_table table t)
			else (find_and_update_parent table a b 1; update_table table t)
		end;	

fun return_result table N K counter =
	if (N > 0 andalso (Array.sub (table, (N - 1))) < 0 andalso K >= 0)
		then return_result table (N - 1) (K - 1) counter
	else if (N > 0 andalso (Array.sub (table, (N - 1))) >= 0)
		then return_result table (N - 1) K counter
	else if (N > 0 andalso (Array.sub (table, (N - 1))) < 0 andalso K < 0)
		then return_result table (N - 1) K (counter + 1)
	else if (N <= 0)
		then counter
	else counter
		
fun villages file =
	let
		val lst = readlist file
		val l = tl lst
		val N = find_N (hd lst)
		val M = find_M (hd lst)
		val K = find_K (hd lst)
		val table = Array.array (N , ~1)
		val temp = update_table table l
	in
		return_result table N K 1
	end;
		
