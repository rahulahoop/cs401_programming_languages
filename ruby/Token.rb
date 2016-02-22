require_relative "TokenType.rb"
class Token
  def initialize(token, type)
    @token = token
    @type = type
    @token_type = TokenType.new
  end

  public
  def get_token
    return @token
  end

  public
  def get_type
    puts "Token: #{@token}"
  end

  public
  def to_s
    type = @token_type.get_readable_type(@type)
    return "< #{@token}, #{type} >"
  end

end
