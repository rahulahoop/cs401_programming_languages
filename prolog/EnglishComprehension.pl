start :- write('~$~'),nl,
        read_line_to_codes(user_input,Cs),
        atom_codes(A,Cs),
        atomic_list_concat(L,' ', A),
        parse(L).

parse([X,is,a,Y|_]) :-
        assert(connect(X,Y)),
        write('ok'),nl,
        start.

parse([A,X,is,a,Y|_]) :-
        assert(connect(X,Y)),
        write('ok'),nl,
        start.

parse([Is,X,a,Y|_]) :-
        connected(X,Y).

parse([Is,a,X,a,Y|_]) :-
        connected(X,Y).

parse([bye|_]) :-
        write('goodbye'),nl.

connected(X,Y) :-
        connect(X,Y) -> write('true'),nl,start;
        connect(X,Z),
        connect(Z,Y) -> write('true'),nl,start;
        write('yes'),nl,start.
