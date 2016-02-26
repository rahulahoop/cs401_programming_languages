
#Stores token types as constants. Closest thing to Enums in Ruby.
class TokenType

EMPTY_TOKEN = 0

TOKEN = 1

IDENTIFIER = 2

INTEGER_LITERAL = 3

OPERATOR = 5

BOOLEAN_OPERATOR = 6

ASSIGNMENT = 7

IF_WHILE_KEYWORD = 8

THEN_ELSE_DO_KEYWORD = 9

AND_KEYWORD = 10

NOT_KEYWORD = 11

BOOLEAN_KEYWORD = 12

COMMENT = 13

#returns a human readable string for debugging.
public
def get_readable_type(int)

  if int == 0
    return 'EMPTY_TOKEN'
  elsif int == 1
    return 'TOKEN'
  elsif int == 2
    return 'IDENTIFIER'
  elsif int == 3
    return 'INTEGER_LITERAL'
  elsif int == 5
    return 'OPERATOR'
  elsif int == 6
    return 'BOOLEAN_OPERATOR'
  elsif int == 7
    return 'ASSIGNMENT'
  elsif int == 8
    return 'KEYWORD'
  elsif int == 9
    return 'COMMENT'
  else
    return 'STRING_LITERAL'
  end

end

end
