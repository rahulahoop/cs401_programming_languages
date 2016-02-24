class TokenType

EMPTY_TOKEN = 0

TOKEN = 1

INDENTIFIER = 2

INTEGER_LITERAL = 3

STRING_LITERAL = 4

BOOLEAN_OPERATOR = 6

ASSIGNMENT = 7

KEYWORD = 8

COMMENT = 9

public
def get_readable_type(int)

  if int == 0
    return "EMPTY_TOKEN"
  elsif int == 1
    return "TOKEN"
  elsif int == 2
    return "INDENTIFIER"
  elsif int == 3
    return "INTEGER_LITERAL"
  elsif int == 6
    return "BOOLEAN_OPERATOR"
  elsif int == 7
    return "ASSIGNMENT"
  elsif int == 8
    return "KEYWORD"
  elsif int == 9
    return "COMMENT"
  else
    return "STRING_LITERAL"
  end

end

end
