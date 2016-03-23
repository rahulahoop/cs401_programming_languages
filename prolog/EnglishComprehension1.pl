start_comprehension :- write('-------------------------'),nl,
	read_line_to_codes(user_input,Current_string),
	atom_codes(A,Current_string),
	atomic_list_concat(List,' ',A),
	parse(List).

parse([X,is,a,Y|_]) :-
	assert(connect(X,Y)),
	write('ok'),nl,
	start_comprehension.

parse(['A',X,is,a,Y|_]):-
	assert(connect(X,Y)),
	write('ok'),nl,
	start_comprehension.

parse(['Is',X,a,Y|_]) :-
	connected(X,Y).

parse(['Is',a,X,a,Y|_]) :-
	connected(X,Y).

parse([bye|_]) :-
	write('end_comprehension'),nl.

connected(X,Y) :-
        connect(X,Y) -> write('yes'),nl,
	start_comprehension;
	connect(Y,X) -> write('yes'),nl,
	start_comprehension;
        connect(X,Z),
        connect(Z,Y) -> write('yes'),nl,
        start_comprehension;
        \+ connect(Z,Y) -> write('no'),nl,
        start_comprehension;
        write('unknown'),nl,
        start_comprehension.
