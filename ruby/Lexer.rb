#!/usr/bin/ruby
require './Tokenizer.rb'
require './syntaxer.rb'

def main
  source_file = ARGV[0]
  tokenizer = Tokenizer.new
  syntaxer = Syntaxer.new(tokenizer)

  puts "parsing"
  open(source_file, 'r').each_line do |line|
    tokenizer.parse_line(line)
  end

  puts tokenizer.get_stored_tokens

  puts "validating"
  syntaxer.parse_tokens

end

main
