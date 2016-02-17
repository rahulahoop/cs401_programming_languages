## https://www.youtube.com/watch?v=_EQ5jdrgOlU

class Tokenizer

  def initialize(str)
    @token_datas = []
    @str = str
    @last_token = nil
    @push_back = false

    define_language()

  end

  private
  def define_language()
    @token_datas.push(TokenData.new(/[a-zA-Z][a-zA-Z0-90]*/), TokenType::INDENTIFIER)
    @token_datas.push(TokenData.new(/(-)?[0-9]+/), TokenType::INTEGER_LITERAL)
    @token_data.push(TokenData.new(/".*"/, TokenType::STRING_LITERAL)

    tokens = [ /:=/, /\\(/ , /\\)/, /\\./, /\\,/]

    tokens.each do |regex|
      @token_datas.push(TokenData.new(regex, TokenType::TOKEN))
    end

  end

  public
  def next_token()
    @str.strip!

    if @push_back
      @push_back = false
      return @last_token
    end

    if @str.empty?
      @last_token = Token.new("", TokenType::EMPTY_TOKEN)
      return @last_token
    end

    @token_datas.each do |regex|
      if matches = |regex|.match(@str)
        token = matches.captures
        ## 19:43
        @str =
      end


    end

  end



end
