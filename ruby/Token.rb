class Token

  def initialize(token, type)
    @token = token
    @type = type
  end

  public
  def get_token
    return @token
  end

  public
  def get_type
    return @type
  end

end
