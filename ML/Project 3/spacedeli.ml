fun readlist (infile : string) = 																																	(* read input file and store it in a list of lists of touples*)
	let
		val ins = TextIO.openIn infile 
		fun update_elements [] = nil 
			| update_elements (h::t) =
				if h = #"S" then (#"S", 0, ~1) :: update_elements t
				else if h = #"\n" then nil
				else (h, ~1, ~1) :: update_elements t
		fun loop ins =
			case TextIO.inputLine ins of
				SOME line => (update_elements (explode line)) :: loop ins
				| NONE      => []
	in
		loop ins before TextIO.closeIn ins
	end

fun check_row [] i j = nil																
	| check_row (h::t) i j = 
		if h = (#"S", 0, ~1) then (#"S",i,j) :: check_row t i (j + 1) 
		else if h = (#"E", ~1, ~1) then (#"E",i,j) :: check_row t i (j + 1) 
		else check_row t i (j + 1) 

fun find_start_end [] i j = nil 																																	(* find coordinates of S and E and store them in a list of 2 touples*)
	| find_start_end (h::t) i j = check_row h i j @ find_start_end t (i + 1) j

	
fun addtouples1 (x1, y1 , z1) y2 = (x1,y1 + y2,z2)
	
	
	
fun addtouples2 (x1, y1 , z1) z2 = (x1,y1,z1 + z2)	


fun check_next (a,b,c,d,e,f,g) next_i next_j =
	case (a,b,c,d,e,f,g) of
		(false,true,true,true,_,_,_) =>
		(false,true,false,_,_,_,_,) =>
		(false,false,true,true,_,_,_) =>
		(false,_,true,_,_,true,true) =>
		(false,_,true,_,_,true,false) =>
		(false,_,false,_,_,false,true) =>
		(true,true,false,_,_,_,_) =>
		(true,true,true,_,true,_,_) =>
		(true,false,true,true,true,_,_) =>
		(_,_,_,_,_,_,_) =>
	
	
fun update_distances_up table M N () () [] = nil																													(* this function gets a list of boxes in the array and returns a new list with their neighbours *)
	| update_distances_up table M N ((ch,i,j)::t) =
		if (i - 1) < 0 then update_distances_up table M N () () t 																									(* check upper box*)
		else
			if (#1 Array2.sub(table,i - 1,j)) = #"X" then update_distances_up table M N () () t
			else (check_next ((#1 Array2.sub(table,i - 1,j)) = #"W" ,(#2 Array2.sub(table,i - 1,j)) = ~1 ,(#3 Array2.sub(table,i,j)) <> ~1 ,(#3 Array2.sub(table,i - 1,j)) = ~1 ,e,f,g) (i - 1) j) :: update_distances_up table M N () () t 
				
			
			
			
			
			
			
			
				if (#1 Array2.sub(table,i - 1,j)) = #"W" then
					if (#2 Array2.sub(table,i - 1,j)) = ~1 then
						if if (#3 Array2.sub(table,i,j)) = ~1 then
					
				else
					if (#2 Array2.sub(table,i - 1,j)) = ~1 then 
						if (#3 Array2.sub(table,i,j)) = ~1 then sub(table,i - 1,j) :: update_distances_up table M N (Array2.update (table,i - 1,j,addtouples2 Array2.sub(table,i,j)) 2) () t
						else
							if (#3 Array2.sub(table,i - 1,j)) = ~1 then sub(table,i - 1,j) :: update_distances_up table M N (Array2.update (table,i - 1,j,addtouples2 Array2.sub(table,i,j)) 2) (Array2.update (table,i - 1,j,addtouples1 Array2.sub(table,i,j)) 1) t
							else sub(table,i - 1,j) :: update_distances_up table M N (Array2.update (table,i - 1,j,addtouples2 Array2.sub(table,i,j)) 2) () t
					else update_distances_up table M N () () t

					
fun shortest_distance table l end_i end_j M N =
	let 
		fifo = (update_distances_up table M N () () l) @ (update_distances_down table M N () () l) @ (update_distances_left table M N () () l) @ (update_distances_right table M N () () l)
	in
		if fifo = nil then #2 Array2.sub(table,end_i,end_j)
		else shortest_distance table fifo end_i end_j M N 
	end
	
			
fun spacedeli file =
	let
		val l = readlist file
		val M = length l
		val N = length (hd l)
		val a = find_start_end l 0 0
		val table = Array2.fromList l
	in
		if a = nil then 0
		else if a = (a1 :: t) then 0
		else if a = (a1 :: a2 :: t) then            
			if (#1 a1) = #"S" then shortest_distance table [a1] (#2 a2) (#3 a2) M N 
			else shortest_distance table [a2] (#2 a1) (#3 a1) M N
		else 0
	end
