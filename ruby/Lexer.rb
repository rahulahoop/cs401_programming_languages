#!/usr/bin/ruby
require "./Tokenizer.rb"

def main()
  source_file = ARGV[0]
  lexer = Tokenizer.new
  source_code = open(source_file, "r").each_line do |line|
    lexer.parse_line(line)
  end
  puts lexer.get_stored_tokens

end

main
