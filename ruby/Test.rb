require_relative "Tokenizer.rb"

def main
  test_code = "var := 1

    1 + 2
    \"hello\""

  tokenizer = Tokenizer.new(test_code)

  while(tokenizer.has_next_token?)
    tokenizer.next_token().get_token()
  end
end

main
