## Reference: https://www.youtube.com/watch?v=_EQ5jdrgOlU

require_relative "TokenType.rb"
require_relative "TokenData.rb"
require_relative "Token.rb"

class Tokenizer

  def initialize(str)
    puts "init Tokenizer\n"
    @token_datas = Array.new
    @str = str
    @last_token = nil
    @push_back = false
    @matches_for_testing = Array.new

    define_language()

  end

  private
  def define_language
    puts "defining language\n"
    @token_datas.push(TokenData.new(/^([a-zA-Z][a-zA-Z0-90]*)/, TokenType::INDENTIFIER))
    @token_datas.push(TokenData.new(/^((-)?[0-9]+)/, TokenType::INTEGER_LITERAL))
    @token_datas.push(TokenData.new(/^(".*")/, TokenType::STRING_LITERAL))

    tokens = [ /^(:=)/, /^(\()/ , /^(\))/, /^(\.)/, /^(\,)/]

    tokens.each do |regex|
      @token_datas.push(TokenData.new(regex, TokenType::TOKEN))
    end
  end

  public
  def next_token
    puts "next token\n"
    @str.strip!
    puts "str is #{@str}"

    if @push_back
      puts "push back\n"
      @push_back = false
      return @last_token
    end

    if @str.empty?
      puts "empty input\n"
      @last_token = Token.new("", TokenType::EMPTY_TOKEN)
      return @last_token
    end

    @token_datas.each do |data|
      if matches = data.get_pattern().match(@str)
        token = matches.captures

        puts "matches = #{matches.to_s}"

        token_string = matches.to_s

        @matches_for_testing.push(token_string)

        @str = @str.sub(/^#{token_string}/, '')
        puts "token string: #{token_string}"
        puts "str : #{@str}"
        puts "last token: #{@last_token}"

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
    return !@str.empty?
  end

  public
  def push_back
    if @last_token != nil
      @push_back = true
    end
  end

end #class
