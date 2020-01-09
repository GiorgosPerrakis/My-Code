open IntInf;

fun a^0 = 1
| a^b = a*(a^(b - 1));

fun createlistweights 0 = nil
	| createlistweights N = N::createlistweights (N-1);
	
fun sumlist [] = 0
	| sumlist (h::t) = 3^(h - 1) + sumlist t;


fun choose_scale([],left_scale,right_scale,sum_left,sum_right) = 
	if sum_left = sum_right then
		(left_scale,right_scale)
	else
		([],[])
|	choose_scale((h::t),left_scale,right_scale,sum_left,sum_right) =
		if sum_left > sum_right then
			if abs(sum_right + (3^(h - 1)) - sum_left) <= (sumlist t) then
				choose_scale(t,left_scale,h::right_scale,sum_left,sum_right + (3^(h - 1)))
			else
				choose_scale(t,left_scale,right_scale,sum_left,sum_right)
		else
			if abs(sum_left + (3^(h - 1)) - sum_right) <= (sumlist t) then
				choose_scale(t,h::left_scale,right_scale,sum_left + (3^(h - 1)),sum_right)
			else
				choose_scale(t,left_scale,right_scale,sum_left,sum_right);
					
fun balance N W = choose_scale(createlistweights N,[],[],W,0);