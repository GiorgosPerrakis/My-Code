fun create_list a b =
    if a < 0 then b
	else create_list (a-1) ((a * a)::b);