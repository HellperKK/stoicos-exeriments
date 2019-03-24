type token =
  |OPar
  |CPar
  |SQuote
  |DQuote
  |OBra
  |CBra
  |OCurl
  |CCurl
  |Number of float
  |Boolean of bool
  |Ident of string

let reg = Str.regexp "[A-Za-z0-9]"
let chaine = "coucou c'est moi"
let test = Str.string_match "[A-Za-z0-9]" chaine 0
let matche = Str.matched_string chaine
let _ = print_endline matche
(* let lex stream =
  let rec aux acc = function
    |x when x ->*)

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
