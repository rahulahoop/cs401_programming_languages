start_conversation :-
	write('Hello'),nl,
	write('What is your problem?'),nl,
	read_input.

read_input :-
	read_line_to_codes(user_input,Current_string),
	atom_codes(A,Current_string),
	atomic_list_concat(List,' ', A),
	match(List).

match(['I',will,pass|_]) :-
	write('Okay, I understand.'),nl,
	read_input.

match(['I',am,X|_]) :-
	write('Yes, I see. Why is that? '),nl,
	read_input.

match(['This',is|Rest]) :-
	write('What else do you regard as '),
	swritef(s,'%s',Rest), write('?'),nl,
	read_input.

match(['Also',washing,my,X,car|_]) :-
	write('Tell me more about your family.'),nl,
	read_input.

match(['Writing'|_]) :-
	write('I see. Please continue.'),nl,
	read_input.

match(['Why'|_]) :-
	write('Why should you what?'),nl,
	read_input.

match(['Tell'|_]) :-
	write('So that you can see how I operate.'),nl,
	read_input.

match([bye|_]) :-
	write('end_conversation'),nl.

match(List) :-
	member('Ok.',List) -> write('Wouldst thou like to live deliciously?'), nl, read_input;
	member('crazy',List) -> write('What do you mean by crazy.'), nl, read_input;
	member('tired',List) -> write('Tell me what makes you feel this way.'),nl,read_input;
	member('work',List) -> write('too much work?'),nl,read_input;
	member('mom',List) -> write('Tell me about your mother.'),nl,read_input;
	member('mother',List) -> write('Did she give birth to you?'),nl,read_input;
	member('kind',List) -> write('She sounds like a very nice woman.'),nl,read_input;
	member('loving',List) -> write('Well, she did give birth to you.'),nl,read_input;
	member('dad',List) -> write('Tell me about your father.'),nl,read_input;
	member('father',List) -> write('At least you have a dad ....'),nl,read_input;
	member('home',List) -> write('What types of problems are you having at home?'),nl,read_input;
	member('touched',List) -> write('Show me on the doll where he touched you.'),nl,read_input;
	write('Well lets move on.'),nl,read_input.
