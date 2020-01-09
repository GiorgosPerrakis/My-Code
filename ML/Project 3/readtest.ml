fun readlist (infile : string) = 
	let
		val ins = TextIO.openIn infile 
		fun update_elements l =
			if (hd l) = #"." orelse (hd l) = #"W" orelse (hd l) = #"X" orelse (hd l) = #"E" then (hd l, ~1, ~1) :: update_elements (tl l)
			else if (hd l) = #"S" then (hd l, 0, ~1) :: update_elements (tl l)
			else if (hd l) = #"\n" then nil
			else []
		fun loop ins =
			case TextIO.inputLine ins of
				SOME line => (update_elements (explode line)) :: loop ins
				| NONE      => []
	in
		loop ins before TextIO.closeIn ins
	end

fun find [] i j = []
	|	find l i j = 
			if (hd l) = (#"E", ~1, ~1) then (i, j, #"E") :: find (tl l) i (j + 1)
			else if (hd l) = (#"S", 0, ~1) then (i, j, #"S") :: find (tl l) i (j + 1)
			else find l i (j + 1)

			
			
(*	if (hd lst) <> nil then (find (hd lst) (x + 1) y) :: find_start_end_bounds (tl lst) x y
		else nil
	end
	*)
	