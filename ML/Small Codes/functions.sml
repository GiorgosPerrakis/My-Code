fun sum nil = 0
  | sum (h::t) = h+sum t;
  
fun halve nil = (nil,nil)
  | halve [a] = ([a],nil)
  | halve (a::b::cs) =
     let
        val (x,y) = halve cs
     in
        (a::x,b::y)
     end;

fun merge (nil,ys) = ys
  | merge (xs,nil) = xs
  | merge (x::xs,y::ys) = 
     if x < y then x::merge(xs,y::ys)
     else y::merge(x::xs,ys);

fun mergeSort nil = nil  
  | mergeSort [a] = [a]
  | mergeSort theList = 
     let   
        val (x,y) = halve theList   
     in   
        merge(mergeSort x,mergeSort y)
     end;


fun h1 nil = [nil,nil]
  | h1 [a] = [[a],nil]
  | h1 (a::b::cs) =
     let
        val [x,y] = h1 cs
     in
        [a::x,b::y]
     end;	 
	 
	 
	 
fun powerset [] = [[]]
  | powerset (h::t) =
    let
       fun cons h t = h :: t
       val pst = powerset t
    in
       (map (cons h) pst) @ pst
    end;	 
	 
	 
	 
	 
	 
fun valemiki lista = map ( fn l => (l,length l,0) ) lista 

fun fores [] lista = lista
|fores ((l,m,d)::t) lista =
let
val newL = map ( fn (li,mikos,dd) => if mikos = m then (li,m,dd+1) 
else (li,mikos,dd) ) lista
in
fores t newL
end;

fun lenfreqsort [] = []
| lenfreqsort lista =
let
val Lmemiki = valemiki lista
val Lmefores = fores Lmemiki Lmemiki
in
ListMergeSort.sort ( fn((i1,i2,i),(j1,j2,j)) => i>j ) Lmefores
end;




fun combinations 0 _ = [[]]
| combinations k (l::ls) =
if k > (length (l::ls)) then []
else if k = (length (l::ls)) then [l::ls]
else (map (fn x => (l::x)) (combinations (k-1) ls))@(combinations k ls)	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 
	 