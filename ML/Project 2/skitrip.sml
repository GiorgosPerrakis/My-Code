
fun read filename = let

    fun inlist (infile : string) = let
      val ins = TextIO.openIn infile
      fun buz(NONE) = 0
        | buz(SOME a) = a;
      fun loop ins =
       case TextIO.inputLine ins of
          SOME line => map (fn x => buz (Int.fromString x)) (String.tokens (fn x => if x = #" " orelse x = #"\n" then true else false) line) @ loop ins
        | NONE      => []
    in
      loop ins before TextIO.closeIn ins
    end

    val InList = inlist filename;
	in
		InList
	end;


fun createlist intlist = let
	val lst2 = foldl (fn(int_,lst2_) => [(int_, 1 + #2(hd lst2_))] @ lst2_) [(hd(intlist), 0)] intlist;
in
	lst2
end;


fun first (w, _) = w;
fun second (_, z) = z;


fun left_list ([], k) = ([], k)
  | left_list ((a::t), k) = 
  
		if ( first a ) < ( first(hd k) ) then left_list(t, a::k)
		
		else left_list(t, k);
		

fun right_list ([], k) = ([], k)
  | right_list ((a::t), k) = 
  
		if ( first a ) > ( first(hd k) ) then right_list(t, a::k)
		
		else right_list(t, k);


fun calculate (l, r) = let
	
	fun check ([], (c::d), g, s, distance) = distance
	  | check ((a::b), [], g, s, distance) = distance	    
	  | check ((a::b), (c::d), g, s, distance) = 
	  
			if ( first a ) <= ( first c ) then check(g, d, g, d, (second(c) - second(a))::distance)
			
			else check(b, s, b, s, 0::distance);		
			
	fun max_distance ([], max) = max 
	  | max_distance ((x::y), max) =
	  
		if (max < x) then max_distance(y, x)
		
		else max_distance(y, max);
		
	val distances = check(l, r, l, r, []);
	val find_max = max_distance(distances, 0); 
in
	find_max
end;


fun descending ([], acc, ls, i) = (true, ls)
  | descending ([x], acc, ls, i) = (true, i::ls)
  | descending (hightlist, acc, ls, i) =  
  
	if ( first(hd hightlist) >= first(hd (tl hightlist)) ) then 
	
		if ( first(hd hightlist) = first(hd (tl hightlist)) ) then descending (tl hightlist, acc + 1, 0::ls, i + 1) 
		
		else descending (tl hightlist, 0, i::ls, 0)
	
	else (false, []);
	
	
fun max_element ([], max) = max 
  | max_element (max_list, max) = 
	
	if ( hd max_list > max ) then max_element (tl max_list, hd max_list)
	
	else max_element (tl max_list, max);


fun skitrip file = let
	val x = tl (read file);	 	
	val left = tl( rev(createlist x));	
	val flag = descending(left, 0, [], 0);
	val new_left_node = [hd left];
	val temp = createlist x;                           
	val right = List.take(temp, List.length(temp)-1);
	val new_right_node = [hd right];
	
	fun func tp = 
	
		if ( #1(flag) = true ) then max_element(#2(flag), 0)
		
		else calculate(rev (second(left_list(left, new_left_node))), second(right_list(right, new_right_node)));	
in  
	func 0
end;		