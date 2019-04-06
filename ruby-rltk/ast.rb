require 'rltk/ast'

module Stoicos
	class Expression < RLTK::ASTNode; end

	class Number < Expression
		value :value, Float
	end

	class Variable < Expression
		value :name, String
	end

	class FunCall < Expression
		value :elems, Array
	end
end
