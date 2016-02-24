#!/usr/bin/ruby
require_relative "Tokenizer.rb"

def main()
  source_file = ARGV[0]
  source_code = open(source_file).read

  lexer = Tokenizer.new(source_code)

  while lexer.has_next_token?
    puts lexer.next_token
  end

  puts lexer.get_stored_tokens

end

main
