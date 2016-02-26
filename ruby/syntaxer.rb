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

        elsif @last_token.get_type == TokenType::INTEGER_LITERAL
          check_integer_literal_rules(current)

        elsif @last_token.get_type == TokenType::OPERATOR
          check_operator_rules(current)

        elsif @last_token.get_type == TokenType::BOOLEAN_OPERATOR
          check_boolean_operator_rules(current)

        elsif @last_token.get_type == TokenType::ASSIGNMENT
          check_assigment_rules(current)

        elsif @last_token.get_type == TokenType::IF_WHILE_KEYWORD
          check_if_while_keyword_rules(current)

        elsif @last_token.get_type == TokenType::THEN_ELSE_DO_KEYWORD
          check_then_else_do_keyword_rules(current)

        elsif @last_token.get_type == TokenType::AND_KEYWORD
          check_and_keyword_rules(current)

        elsif @last_token.get_type == TokenType::NOT_KEYWORD
          check_not_keyword_rules(current)

        elsif @last_token.get_type == TokenType::END_KEYWORD
          check_end_keyword_rules(current)

        elsif @last_token.get_type == TokenType::BOOLEAN_KEYWORD
          check_boolean_keyword_rules(current)

        elsif @last_token.get_type == TokenType::COMMENT
          check_comment_rules(current)
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
  def check_integer_literal_rules(current)

    
  end

  private
  def check_integer_literal_rules(current)

    
  end

  private
  def check_operator_rules(current)

    
  end

  private
  def check_boolean_operator_rules(current)

    
  end

  private
  def check_assignment_rules(current)

    
  end

  private
  def check_if_while_keyword_rules(current)

    
  end

  private
  def check_then_else_do_keyword_rules(current)

    
  end

  private
  def check_and_keyword_rules(current)

    
  end

  private
  def check_not_keyword_rules(current)

    
  end

  private
  def check_end_keyword_rules(current)

    
  end

  private
  def check_boolean_keyword_rules(current)

    
  end

  private
  def check_comment_keyword_rules(current)

    
  end

  private
  def raise_syntax_error(current)
    raise Exception.new("Invalid Syntax => #{@last_token.get_token} #{current.get_token}")
  end


end