require_relative "Tokenizer.rb"

def main
  test_code = "var := 9238493"

  tokenizer = Tokenizer.new(test_code)

  while(tokenizer.has_next_token?)
    puts "testing"
    tokenizer.next_token
  end

puts tokenizer.get_stored_tokens

end

main
