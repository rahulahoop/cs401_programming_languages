start :- write('~$~'),nl,
	read_line_to_codes(user_input,Current_string),
	atom_codes(A,Current_string),
	atomic_list_concat(List,' ', A),
	/*atomic_list_concat(L,'.', A),
	atomic_list-concat(L,'?', A),*/
	parse(List).

parse([X,is,a,Y|_]) :-
	assert(connect(X,Y)),
	write('ok'),nl,
	start.

parse(['A',Y,is,a,Z|_]) :-
	assert(connect(Y,Z)),
	write('ok'),nl,
	start.

parse(['Is',X,a,Z|_]) :-
	is_connected(X,Z).

parse(['Is',a,Y,a,Z|_]) :-
	is_connected(Y,Z).

parse([bye|_]) :-
	write('goodbye'),nl.

is_connected(X,Z) :-
	connect(X,Y) -> write('yes'),nl,start;
	connect(Y,Z),
	connect(X,Z) -> write('yes'),nl,start;
	write('unknown'),nl,
	start.
