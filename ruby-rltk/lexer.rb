require 'rltk/lexer'

module Stoicos
	class Lexer < RLTK::Lexer
		# Skip whitespace.
		rule(/\s/)

		# Operators and delimiters.
		rule(/\(/)	{ :LPAREN }
		rule(/\)/)	{ :RPAREN }
		rule(/\{/)	{ :LBRACKET }
		rule(/\}/)	{ :RBRACKET }
		rule(/\[/)	{ :LCROCH }
		rule(/\]/)	{ :RCROCH }
		rule(/"/)	{ :DQUOTE }
		rule(/;/)	{ :SEMI }

		# Numeric rules.
		rule(/\d+/)		{ |t| [:NUMBER, t.to_f] }
		rule(/\.\d+/)		{ |t| [:NUMBER, t.to_f] }
		rule(/\d+\.\d+/)	{ |t| [:NUMBER, t.to_f] }

    # Identifier rule.
		rule(/[A-Za-z0-9\+\*\/\-%_&\|=<>\.]+/) { |t| [:IDENT, t] }

		# Comment rules.
		rule(/#/)				{ push_state :comment }
		rule(/\n/, :comment)	{ pop_state }
		rule(/./, :comment)
	end
end
