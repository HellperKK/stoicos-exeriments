require_relative './lexer'
require_relative './parser'

puts Stoicos::Parser.parse(Stoicos::Lexer.lex("(+ 1 2)"))

# loop do
# 	print('Stoicos > ')
# 	line = ''
#
# 	begin
# 		line += ' ' if not line.empty?
# 		line += $stdin.gets.chomp
# 	end while line[-1,1] != ';'
#
# 	break if line == 'quit;' or line == 'exit;'
#
# 	begin
# 		ast = Stoicos::Parser.parse(Stoicos::Lexer.lex(line))
#
# 		case ast
# 		when Stoicos::Expression	then puts 'Parsed an expression.'
# 		end
#
# 	rescue RLTK::LexingError, RLTK::NotInLanguage
# 		puts 'Line was not in language.'
# 	end
# end
