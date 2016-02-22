class TokenType

EMPTY_TOKEN = 0

TOKEN = 1

INDENTIFIER = 2

INTEGER_LITERAL = 3

STRING_LITERAL = 4

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
  else
    return "STRING_LITERAL"
  end

end

end
