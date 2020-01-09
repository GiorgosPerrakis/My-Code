fun readlist (infile : string) = 							(* read input file and store it in a list of lists of touples*)
	let
		val ins = TextIO.openIn infile 
		fun update_elements [] = nil 
			| update_elements (h::t) =
				if h = #"S" then (#"S", 0) :: update_elements t
				else if h = #"\n" then nil
				else (h, ~1) :: update_elements t
		fun loop ins =
			case TextIO.inputLine ins of
				SOME line => (update_elements (explode line)) :: loop ins
				| NONE      => []
	in
		loop ins before TextIO.closeIn ins
	end;

fun check_row [] i j = nil																
	| check_row (h::t) i j = 
		if h = (#"S", 0) then (#"S",i,j) :: check_row t i (j + 1) 
		else if h = (#"E", ~1) then (#"E",i,j) :: check_row t i (j + 1) 
		else check_row t i (j + 1) 

fun find_start_end [] i j = nil 							(* find coordinates of S and E and store them in a list of 2 touples as [(#"S",is,js),(#"E",ie,je)] or [(#"E",ie,je),(#"S",is,js)] depending on which we find first*)
	| find_start_end (h::t) i j = check_row h i j @ find_start_end t (i + 1) j
	
fun first (x, _) = x

fun second (_, y) = y

fun Nfirst (x,_,_,_) = x

fun Nsecond (_,y,_,_) = y

fun Nthird (_,_,z,_) = z

fun Nfourth (_,_,_,w) = w

fun firstA (x, _, _) = x

fun secondA (_, y, _) = y

fun thirdA (_, _, z) = z

fun addk (x1, y1) (x2, y2) k = (x1, y2 + k)		(* d' = d + k where (x2, y2) is current and (x1, y1) in neighbour *) 

fun update_distances_up table M N [] = nil																														(* check upper box*)																											
	| update_distances_up table M N ((i,j)::t) =
		if (i - 1) < 0 orelse (first (Array2.sub(table,i - 1,j))) = #"X" then update_distances_up table M N t 																
		else 
			let
				val a1 = Array2.sub(table,i - 1,j)
				val a2 = Array2.sub(table,i,j)
				val a = addk a1 a2 3
			in
				if (((second (Array2.sub(table,i - 1,j))) > (second (Array2.sub(table,i,j)) + 3)) orelse (second (Array2.sub(table,i - 1,j))) = ~1)
					then ((Array2.update (table,i - 1,j,a)); (i - 1,j) :: update_distances_up table M N t)
				else update_distances_up table M N t
			end

fun update_distances_down table M N [] = nil																													(* check lower box*)																												
	| update_distances_down table M N ((i,j)::t) =
		if (i + 1) >= M orelse (first (Array2.sub(table,i + 1,j))) = #"X" then update_distances_down table M N t 													
		else 
			let
				val b1 = Array2.sub(table,i + 1,j)
				val b2 = Array2.sub(table,i,j)
				val b = addk b1 b2 1
			in
				if (((second (Array2.sub(table,i + 1,j))) > (second (Array2.sub(table,i,j)) + 1)) orelse (second (Array2.sub(table,i + 1,j))) = ~1)
					then ((Array2.update (table,i + 1,j,b)); (i + 1,j) :: update_distances_down table M N t)
				else update_distances_down table M N t	
			end

fun update_distances_left table M N [] = nil																													(* check left box*)																					
	| update_distances_left table M N ((i,j)::t) =
		if (j - 1) < 0 orelse (first (Array2.sub(table,i,j - 1))) = #"X" then update_distances_left table M N t 													
		else 
			let
				val c1 = Array2.sub(table,i,j - 1)
				val c2 = Array2.sub(table,i,j)
				val c = addk c1 c2 2
			in
				if (((second (Array2.sub(table,i,j - 1))) > (second (Array2.sub(table,i,j)) + 2)) orelse (second (Array2.sub(table,i,j - 1))) = ~1)
					then ((Array2.update (table,i,j - 1,c)); (i,j - 1) :: update_distances_left table M N t)
				else update_distances_left table M N t
			end

fun update_distances_right table M N [] = nil																													(* check right box*)																												
	| update_distances_right table M N ((i,j)::t) =
		if (j + 1) >= N orelse (first (Array2.sub(table,i,j + 1))) = #"X" then update_distances_right table M N t 													
		else 
			let
				val e1 = Array2.sub(table,i,j + 1)
				val e2 = Array2.sub(table,i,j)
				val e = addk e1 e2 1
			in
				if (((second (Array2.sub(table,i,j + 1))) > (second (Array2.sub(table,i,j)) + 1)) orelse (second (Array2.sub(table,i,j + 1))) = ~1) 
					then ((Array2.update (table,i,j + 1,e)); (i,j + 1) :: update_distances_right table M N t)
				else update_distances_right table M N t		
			end
	
fun shortest_distance table l end_i end_j M N =																													(* this function gets a list of boxes in the array and returns a new list with their neighbours *)
	let 
		val fifo = (update_distances_up table M N l) @ (update_distances_down table M N l) @ (update_distances_left table M N l) @ (update_distances_right table M N l)
	in
		if fifo = nil then second (Array2.sub(table,end_i,end_j))
		else shortest_distance table fifo end_i end_j M N 
	end;

fun find_distance table M N a = 
	if a = nil then 0
	else if tl a = nil then 0
	else            
		if (firstA (hd a)) = #"S" then shortest_distance table [((secondA (hd a)), (thirdA (hd a)))] (secondA (hd (tl a))) (thirdA (hd (tl a))) M N  
		else shortest_distance table [((secondA (hd (tl a))), (thirdA (hd (tl a))))] (secondA (hd a)) (thirdA (hd a)) M N	
		
fun change_list [] = nil
	| change_list (h::t) = 
		if h = nil then change_list t
			else h :: change_list t	

fun check_up table d i j M N =  
		if (i - 1) >= 0 then
			if ((first (Array2.sub (table,i - 1,j))) <> #"X") then
				if ((second (Array2.sub (table,i - 1,j))) = (second (Array2.sub (table,i,j))) - 1) then ("D", d - 1, i - 1, j)
				else ("", d, i - 1, j)
			else ("", d, i - 1, j)
		else ("", d, i - 1, j)

fun check_down table d i j M N =  
		if (i + 1) < M then
			if ((first (Array2.sub (table,i + 1,j))) <> #"X") then
				if ((second (Array2.sub (table,i + 1,j))) = (second (Array2.sub (table,i,j))) - 3) then ("U", d - 3, i + 1, j)
				else ("", d, i + 1, j)
			else ("", d, i + 1, j)
		else ("", d, i + 1, j)	

fun check_right table d i j M N =  
		if (j - 1) >= 0 then
			if ((first (Array2.sub (table,i,j - 1))) <> #"X") then
				if ((second (Array2.sub (table,i,j - 1))) = (second (Array2.sub (table,i,j))) - 1) then ("R", d - 1, i, j - 1)
				else ("", d, i, j - 1)
			else ("", d, i, j - 1)
		else ("", d, i, j - 1)	

fun check_left table d i j M N =  
		if (j + 1) < N then
			if ((first (Array2.sub (table,i,j + 1))) <> #"X") then
				if ((second (Array2.sub (table,i,j + 1))) = (second (Array2.sub (table,i,j))) - 2) then ("L", d - 2, i, j + 1)
				else ("", d, i, j + 1)
			else ("", d, i, j + 1)
		else ("", d, i, j + 1)		
			
fun find_path table d i j M N = 
	let
		val a = (check_up table d i j M N)
		val b = (check_down table d i j M N)
		val c = (check_right table d i j M N)
		val e = (check_left table d i j M N)
	in
		if (d <= 0) then ""
		else
			if (Nfirst a) <> "" then (Nfirst a) ^ (find_path table (Nsecond a) (Nthird a) (Nfourth a) M N) 
			else if (Nfirst b) <> "" then (Nfirst b) ^ (find_path table (Nsecond b) (Nthird b) (Nfourth b) M N)
			else if (Nfirst c) <> "" then (Nfirst c) ^ (find_path table (Nsecond c) (Nthird c) (Nfourth c) M N)
			else (Nfirst e) ^ (find_path table (Nsecond e) (Nthird e) (Nfourth e) M N)
	end;

fun helper [] = []
	| helper [x] = [x]
	| helper (l::ls) = (helper ls) @ [l];

fun reverse s = implode (helper (explode s));
			
fun moredeli file =
	let
		val l = change_list (readlist file)
		val M = length l
		val N = length (hd l)
		val a = find_start_end l 0 0
		val table = Array2.fromList l
		val d = find_distance table M N a
	in	
		if a = nil then (0,"")
		else if tl a = nil then (0,"")
		else
			if (firstA (hd a)) = #"S" then (d, reverse(find_path table d (secondA (hd (tl a))) (thirdA (hd (tl a))) M N))   
			else (d, reverse (find_path table d (secondA (hd a)) (thirdA (hd a)) M N))
	end;