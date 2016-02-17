## Reference: https://www.youtube.com/watch?v=_EQ5jdrgOlU

require "TokenType.rb"
require "TokenData.rb"
require "Token.rb"

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
    @token_datas.push(TokenData.new(/^([a-zA-Z][a-zA-Z0-90]*)/), TokenType::INDENTIFIER)
    @token_datas.push(TokenData.new(/^((-)?[0-9]+))/, TokenType::INTEGER_LITERAL)
    @token_data.push(TokenData.new(/^(".*")/, TokenType::STRING_LITERAL)

    tokens = [ /^(:=)/, /^(\\()/ , /^(\\))/, /^(\\.)/, /^(\\,)/]

    tokens.each do |regex|
      @token_datas.push(TokenData.new("^(" << regex << ")", TokenType::TOKEN))
    end
  end

  public
  def get_token
    return @last_token
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

    @token_datas.each do |data|
      if matches = data.get_pattern().match(@str)
        token = matches.captures
        token[0] = ""
        token = token.join()

        @str = token

        if data.get_type() == TokenType::STRING_LITERAL
          @last_token = Token.new(token[1..token.length-1], TokenType::STRING_LITERAL )
          return @last_token
        else
          @last_token = Token.new(token, data.get_type)
          return @last_token
        end #if data
      end#if matches
    end #each

    raise Exception.new("Could not parse #{@str}")

  end #def

  public
  def has_next_token?
    return !(str.empty?)
  end

  public
  def push_back
    if @last_token != nil
      @push_back = true
    end
  end

end #class
