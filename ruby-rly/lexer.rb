require "rly"

class StoLex < Rly::Lex
  literals '(){}[]'
  ignore " \t\n"

  token :NUMBER, /\d+/ do |t|
    t.value = t.value.to_i
    t
  end
  token :IDEDNT, /[A-Za-z0-9\+\*\/\-%_&\|=<>\.]+/

  on_error do |t|
    puts "Illegal character #{t.value} on #{t.lexer.pos}"
    t.lexer.pos += 1
    nil
  end
end

lex = StoLex.new("(+ 1 $2)")
puts lex.next
puts lex.next
puts lex.next
puts lex.next
puts lex.next
