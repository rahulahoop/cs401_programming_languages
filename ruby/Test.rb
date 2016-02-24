require_relative "Tokenizer.rb"

def main
  test_code = "var := 9238493;test:=666;

    string := \"I am a test\";

                  //I am a comment;;;

    "

  tokenizer = Tokenizer.new(test_code)

  while(tokenizer.has_next_token?)
    puts "testing"
    tokenizer.next_token
  end

puts tokenizer.get_stored_tokens

end

main
