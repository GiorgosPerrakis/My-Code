read_input(File, N, K) :-
    open(File, read, Stream),
    read_line(Stream, N),
    read_line(Stream, K).

read_line(Stream, List) :-
    read_line_to_codes(Stream, Line),
    ( Line = [] -> List = []
    ; atom_codes(A, Line),
      atomic_list_concat(As, ' ', A),
      maplist(atom_number, As, List)
    ).
