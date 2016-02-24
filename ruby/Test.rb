require_relative "Tokenizer.rb"

def main
  test_code = "var := 9238493;test:=666;

    string := \"I am a test\";

                  //I am a comment;;;

    value1 > value2;
    value2 < value3;
    value4 <= value5;
    value6 >= value7;
    value8 == value9;
    value10 != value11;
    "

  tokenizer = Tokenizer.new(test_code)

  while(tokenizer.has_next_token?)
    puts "testing"
    tokenizer.next_token
  end

puts tokenizer.get_stored_tokens

end

main
