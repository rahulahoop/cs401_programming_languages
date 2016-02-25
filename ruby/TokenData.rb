
# Stores the regex pattern and the token type it should be matched with.
class TokenData

  def initialize(pattern, token_type)
    @pattern = pattern
    @type = token_type
  end

  public
  def get_pattern
    @pattern
  end

  public
  def get_type
    @type
  end

end
