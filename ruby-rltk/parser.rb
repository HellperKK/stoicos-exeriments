# RLTK Files
require 'rltk/parser'

# Tutorial Files
require_relative './ast'

module Stoicos
	class Parser < RLTK::Parser
		production(:input, 'statement') { |s| s }

		production(:statement) do
			clause('LPAREN RPAREN')		{ |_, _| FunCall.new([]) }
			clause('LPAREN e_list RPAREN')		{ |_, e, _| FunCall.new(e) }
		end

    production(:e_list) do
      clause('e') {|e| [e]}
      clause('e e_list') {|e, list| [e] + list}
    end

		production(:e) do
			clause('NUMBER')	{ |n| Number.new(n) }
			clause('IDENT')	{ |i| Variable.new(i) }
		end

	end
end
