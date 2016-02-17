require "Tokenizer.rb"

def main
  test_code = " var := 1"

  tokenizer = Tokenizer.new(code)

  while(tokenizer.has_next_token())
    puts tokenizer.next_token.get_token()
  end
end

main
