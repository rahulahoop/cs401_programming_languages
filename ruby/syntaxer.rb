require './Tokenizer.rb'
require './TokenType.rb'

## parses through all the stored tokens in the Tokenizer class to double check the syntax rules.
#  while the Tokenizers assigns values to each input, this class validates them.
class Syntaxer
  def initialize(tokenizer)
    @tokenizer = tokenizer
    @last_token
    @token_input

  end

  public
  def parse_tokens
    while !@tokenizer.has_next_token?
      current = @tokenizer.next_token

      if @last_token == nil
        @last_token = current
      else

        if @last_token.get_type == TokenType::IDENTIFIER
          check_identifier_rules(current)
        end
        @last_token = current
      end #if last_token
    end #while
    puts "program syntactically correct!!!!!!! (: "
  end #def

  private
  def check_identifier_rules(current)
    case current.get_type
      #valid: op, asignment,boolean,
      #invalid:
      when TokenType::IDENTIFIER
        raise_syntax_error(current)

      when TokenType::INTEGER_LITERAL
        raise_syntax_error(current)

      when TokenType::BOOLEAN_KEYWORD
        raise_syntax_error(current)

      else
        # do nothing b/c its valid
    end

  end

  private
  def raise_syntax_error(current)
    raise Exception.new("Invalid Syntax => #{@last_token.get_token} #{current.get_token}")
  end


end