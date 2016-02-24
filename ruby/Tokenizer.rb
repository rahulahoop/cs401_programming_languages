## Reference: https://www.youtube.com/watch?v=_EQ5jdrgOlU

require_relative "TokenType.rb"
require_relative "TokenData.rb"
require_relative "Token.rb"

class Tokenizer
  def initialize(str)
    @token_datas = Array.new
    @str = str
    @last_token = nil
    @push_back = false
    @stored_tokens = Array.new

    define_language()
  end

  private
  def define_language
    @token_datas.push(TokenData.new(/^(\/\/.*$)/, TokenType::COMMENT))
    @token_datas.push(TokenData.new(/^([a-zA-Z][a-zA-Z0-90]*)/, TokenType::INDENTIFIER))
    @token_datas.push(TokenData.new(/^((-)?[0-9]+)/, TokenType::INTEGER_LITERAL))
    @token_datas.push(TokenData.new(/^(".*")/, TokenType::STRING_LITERAL))
    @token_datas.push(TokenData.new(/^(:=)/, TokenType::ASSIGNMENT))



    tokens = [/^(\()/ , /^(\))/, /^(\.)/, /^(\,)/, /^(;)/]

    tokens.each do |regex|
      @token_datas.push(TokenData.new(regex, TokenType::TOKEN))
    end
  end

  public
  def get_stored_tokens()
    return @stored_tokens
  end

  public
  def next_token
    @str.strip!
    puts "input is:  #{@str}"

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

        puts "matches = #{matches.to_s}"

        token_string = matches.to_s

        @str = @str.sub(/^#{token_string}/, '')
        puts "token string: #{token_string}"
        puts "str : #{@str}"
        puts "last token: #{@last_token.to_s}"
        puts "\n"

        @last_token = Token.new(token_string, data.get_type)
        @stored_tokens.push(@last_token)
        return @last_token
      end#if matches
    end #each

    raise Exception.new("Could not parse #{@str}")

  end #def


  public
  def has_next_token?
    return !@str.empty?
  end


  def push_back
    if @last_token != nil
      @push_back = true
    end
  end

end #class
