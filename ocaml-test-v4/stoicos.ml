(* old verison token

type valeur =
	|Number of float
	|Caractere of char
	|Chaine of string
  |Symbol of string
	|Var of name
	|Booleen of bool
	|Proc of valeur list
	|Bloc of valeur list
	|Liste of valeur list
  |ListParse of valeur list
	|Fonction of func
  |Struct of ((string, valeur) Hashtbl.t)
	|Vide

and name =
  |Variable of string
  |NSpace of (string * string)

and func =
  |NativeFun of (valeur list -> valeur)
  |CustomFun of (string list) * (valeur list)
  *)

let _ = print_endline "Hello world !"

(*
|Entier(int)
 |Flottant(float)
 |Carac(char)
 |Chaine(string)
 |Symbol(string)
 |Nom(string)
 |NSpace(string, string)
 |Booleen(bool)
 |Proce(list(token))
 |Bloc(list(token))
 |TableauLex(list(token))
 |Tableau(list(token))
 |Fonction(fonction)
 |Struct(ImutHash.t(string, token))
 |Unit
 |Undef
*)
