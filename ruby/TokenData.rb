class TokenData

  def initialize(pattern, token_type)
    @pattern = pattern
    @type = token_type
  end

  public
  def get_pattern
    return @pattern
  end

  public
  def get_type
    return @type
  end

end
