fun till_table_is_updated table l end_i end_j =
	let 
		fifo = (update_distances_up table M N () () l) @ (update_distances_down table M N () () l) @ (update_distances_left table M N () () l) @ (update_distances_right table M N () () l)
	in
		if fifo = nil then #2 Array2.sub(table,end_i,end_j)
		else till_table_is_updated table fifo end_i end_j
	end