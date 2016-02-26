#!/usr/bin/ruby
require './Tokenizer.rb'
require './syntaxer.rb'

def main
  source_file = ARGV[0]
  tokenizer = Tokenizer.new
  syntaxer = Syntaxer.new(tokenizer)

  open(source_file, 'r').each_line do |line|
    tokenizer.parse_line(line)
  end

  syntaxer.parse_tokens

end

main
