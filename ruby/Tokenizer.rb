## Reference: https://www.youtube.com/watch?v=_EQ5jdrgOlU

require "./TokenType.rb"
require "./TokenData.rb"
require "./Token.rb"

### Parses through the input line by line and regex's out the input according to
##  regex rules defined in the define_language function. These parsed inputs are
#   then stored with their type into an array to be verified later.
class Tokenizer
  def initialize()
    @stored_tokens = Array.new
    @token_datas = Array.new
    @push_back = false
    @last_token = nil
    @input = ""

    define_language()
  end

  private
  def define_language
    # begin defining language rules. (/Rule/, Type of Token)
    @token_datas.push(TokenData.new(/^([a-zA-Z][a-zA-Z0-90]*)/, TokenType::IDENTIFIER))
    @token_datas.push(TokenData.new(/^((-)?[0-9]+)/, TokenType::INTEGER_LITERAL))
    @token_datas.push(TokenData.new(/^(".*")/, TokenType::STRING_LITERAL))
    @token_datas.push(TokenData.new(/^(\/\/.*$)/, TokenType::COMMENT))
    @token_datas.push(TokenData.new(/^(:=)/, TokenType::ASSIGNMENT))

    # adds boolean operators to the language rules
    booleans =  [/^(<=)/, /^(>=)/, /^(>)/, /^(<)/, /^(==)/, /^(!=)/]
    booleans.each do |regex|
      @token_datas.push(TokenData.new(regex, TokenType::BOOLEAN_OPERATOR))
    end

    # add special characters to the language rules.
    tokens = [/^(\()/ , /^(\))/, /^(\.)/, /^(\,)/, /^(;)/]
    tokens.each do |regex|
      @token_datas.push(TokenData.new(regex, TokenType::TOKEN))
    end

    # add math operators to language rules.
    ops = [/\+/, /\-/, /\*/, /\//, /\%/]
    ops.each do |regex|
      @token_datas.push(TokenData.new(regex, TokenType::OPERATOR))
    end
  end

  public
  def get_stored_tokens()
    return @stored_tokens
  end


public
def parse_line(input)
  @input = input
  while has_next_token?
    next_token
  end
end


  # reads in input string and finds the next matching regex.
  private
  def next_token
    @input.strip!

    if @push_back
      @push_back = false
      return @last_token
    end

    if @input.empty?
      @last_token = Token.new("", TokenType::EMPTY_TOKEN)
      return @last_token
    end

    @token_datas.each do |data|
      if matches = data.get_pattern().match(@input)
        token_string = matches.to_s

        if data.get_type == TokenType::OPERATOR
          @input = @input.sub(/#{Regexp.escape(token_string)}/, '')
        else
          @input = @input.sub(/^#{token_string}/, '')
        end

        #uncomment for debugging.
        #puts "token string: #{token_string}"
        #puts "str : #{@input}"
        #puts "last token: #{@last_token.to_s}"
        #puts "\n"

        @last_token = Token.new(token_string, data.get_type)
        @stored_tokens.push(@last_token)

        return @last_token
      end#if matches
    end #each

    raise Exception.new("Could not parse #{@str}")

  end #def


  private
  def has_next_token?
    return !@input.empty?
  end

  #function to go back a step if need be.
  def push_back
    if @last_token != nil
      @push_back = true
    end
  end

end #class
