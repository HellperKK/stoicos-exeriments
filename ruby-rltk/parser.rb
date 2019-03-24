# RLTK Files
require 'rltk/parser'

# Tutorial Files
require_relative './ast'

module Stoicos
	class Parser < RLTK::Parser
		production(:input, 'statement SEMI') { |s, _| s }

		production(:statement) do
			clause('LPAREN RPAREN')		{ |_, _| [] }
			clause('LPAREN e_list RPAREN')		{ |_, e, _| e }
		end

    production(:e_list) do
      clause('e') {|e| [e]}
      clause('e e_list') {|e, list| [e] + list}
    end

		production(:e) do
			clause('NUMBER')	{ |n| Number.new(n) }
			clause('IDENT')	{ |i| Variable.new(i) }
		end

=begin
		list(:args, :e, :COMMA)

		production(:ex, 'EXTERN p_body')	{ |_, p| p }
		production(:p, 'DEF p_body')		{ |_, p| p }
		production(:f, 'p e')			{ |p, e| Function.new(p, e) }

		production(:p_body, 'IDENT LPAREN arg_defs RPAREN') { |name, _, arg_names, _| Prototype.new(name, arg_names) }

		list(:arg_defs, :IDENT, :COMMA)
=end
		finalize use: 'stoparser.tbl'
	end
end
