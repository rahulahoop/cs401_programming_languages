
#Stores token types as constants. Closest thing to Enums in Ruby.
class TokenType

EMPTY_TOKEN = 0

TOKEN = 1

IDENTIFIER = 2

INTEGER_LITERAL = 3

OPERATOR = 4

BOOLEAN_OPERATOR = 5

ASSIGNMENT = 6

IF_WHILE_KEYWORD = 7

THEN_ELSE_DO_KEYWORD = 8

AND_KEYWORD = 9

NOT_KEYWORD = 10

END_KEYWORD = 11

BOOLEAN_KEYWORD = 12

COMMENT = 13

#returns a human readable string for debugging.
public
def get_readable_type(int)

  case int
    when 1
      return 'TOKEN'

    when 2
      return 'IDENTIFIER'

    when 3
      return 'INTEGER_LITERAL'

    when 4
      return 'OPERATOR'

    when 5
      return 'BOOLEAN_OPERATOR'

    when 6
      return 'ASSIGNMENT'

    when 7
      return 'IF_WHILE_KEYWORD'

    when 8
      return 'THEN_ELSE_DO_KEYWORD'

    when 9
      return 'AND_KEYWORD'

    when 10
      return 'NOT_KEYWORD'

    when 11
      return 'END_KEYWORD'

    when 12
      return 'BOOLEAN_KEYWORD'

    when 13
      return 'COMMENT'

    else
      return 'EMPTY_TOKEN'
  end

end

end
