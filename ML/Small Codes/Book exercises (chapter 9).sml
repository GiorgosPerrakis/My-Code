
fun add a = map (fn x => x+2) a;              (* exercise 1 *)

fun square a = map (fn x => x*x)a ;           (* exercise 3 *)

fun mult a = map (fn (x,y) => x*y) a;         (* exercise 4 *)

fun inc a = (fn b => map (fn x => x+b) a);    (* exercise 5 *)

fun sum a =
  let
      val x = map (fn y => y*y) a              (* exercise 6 *)
  in
      foldl (op+) 0 x
  end;
  
fun or_list nil = false
  | or_list a = foldl (fn (x,y) => x orelse y) false a;     (* exercise 7 *)

fun and_list nil = true
  | and_list a = foldl (fn (x,y) => x andalso y) true a;     (* exercise 8 *)
  
  
  