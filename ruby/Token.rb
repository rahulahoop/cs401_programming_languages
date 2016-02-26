require './TokenType.rb'

# a parsed input is stored as a Token object with its type.
class Token
  def initialize(token, type)
    @token = token
    @type = type
    @token_type = TokenType.new
  end

  public
  def get_token
    @token
  end

  public
  def get_type
    @type
  end

  # returns a human readable string with input and type for debugging.
  public
  def to_s
    type = @token_type.get_readable_type(@type)
    "{ #{@token}, #{type} }"
  end

end
