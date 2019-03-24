type valeur = 
	|Entier of int
	|Flottant of float
	|Caractere of char
	|Chaine of string
	|Var of string
	|Booleen of bool
	|Proc of valeur list
	|Bloc of valeur list
	|Liste of valeur list
	|Fonction of (valeur list -> valeur)
	|Vide

let vars = Hashtbl.create 10
let _ = Hashtbl.add vars "base" (Vide)

let read_var_aux valeur = 
	try
		Hashtbl.find vars valeur
	with
		Not_found -> Vide
	
let chars_only_from str strbis = 
	let rec aux  acc = function
		|x when x = String.length str -> acc
		|x when String.contains strbis str.[x] -> aux (acc ^ (String.make 1 str.[x])) (x + 1)
		|x -> aux acc (x + 1)
	in aux "" 0

let super_int_of_string str = match chars_only_from str "0123456789" with
	|"" -> 0
	|x -> int_of_string x

let super_float_of_string str =  match chars_only_from str "0123456789." with
	|"" -> 0.
	|x -> let rec until_second_point compt str = function
		|y when compt = 2 -> String.sub str 0 (y -1)
		|y when y = String.length str -> str
		|y when str.[y] = '.' -> until_second_point (compt + 1) str (y + 1)
		|y -> until_second_point compt str (y + 1)
	in float_of_string (until_second_point 0 x 0)
	
let rec to_int = function
	|Entier x -> x
	|Flottant x -> int_of_float x
	|Caractere x -> int_of_char x
	|Chaine x ->  super_int_of_string x
	|Var x -> to_int (read_var_aux x)
	|Booleen x -> if x then 1 else 0
	|Proc x -> 0
	|Bloc x -> 0
	|Liste x -> to_int (List.nth x 0)
	|Fonction x -> 0
	|Vide -> 0
	
 let rec to_float = function
	|Entier x -> float_of_int x
	|Flottant x -> x
	|Caractere x -> float_of_int (int_of_char x)
	|Chaine x ->  super_float_of_string x
	|Var x -> to_float (read_var_aux x)
	|Booleen x -> if x then 1. else 0.
	|Proc x -> 0.
	|Bloc x -> 0.
	|Liste x -> to_float (List.nth x 0)
	|Fonction x -> 0.
	|Vide -> 0.
	
 let rec to_char = function
	|Entier x -> char_of_int x
	|Flottant x -> char_of_int (int_of_float x)
	|Caractere x -> x
	|Chaine x -> x.[0]
	|Var x -> to_char (read_var_aux x)
	|Booleen x -> if x then '1' else '0'
	|Proc x -> ' '
	|Bloc x -> ' '
	|Liste x -> to_char (List.nth x 0)
	|Fonction x ->' '
	|Vide -> ' '

 let rec to_string = function
	|Entier x -> string_of_int x
	|Flottant x -> string_of_float x
	|Caractere x -> String.make 1 x
	|Chaine x -> x
	|Var x -> to_string (read_var_aux x)
	|Booleen x -> string_of_bool x
	|Proc x -> ""
	|Bloc x -> ""
	|Liste x -> to_string (List.nth x 0)
	|Fonction x -> ""
	|Vide -> ""
	
 let rec to_var = function
	|Entier x -> string_of_int x
	|Flottant x -> string_of_float x
	|Caractere x -> String.make 1 x
	|Chaine x -> x
	|Var x -> x
	|Booleen x -> string_of_bool x
	|Proc x -> ""
	|Bloc x -> ""
	|Liste x -> to_var (List.nth x 0)
	|Fonction x -> ""
	|Vide -> ""

 let rec to_bool = function
	|Entier x -> x  <> 0
	|Flottant x -> x  <> 0.
	|Caractere x -> x  <> ' '
	|Chaine x -> x  <> ""
	|Var x -> to_bool (read_var_aux x)
	|Booleen x -> x
	|Proc x -> x  <> []
	|Bloc x -> x  <> []
	|Liste x -> to_bool (List.nth x 0)
	|Fonction x -> false
	|Vide -> false

 let rec to_proc = function
	|Entier x -> [Entier x]
	|Flottant x -> [Flottant x]
	|Caractere x -> [Caractere x]
	|Chaine x -> [Chaine x]
	|Var x -> to_proc (read_var_aux x)
	|Booleen x -> [Booleen x]
	|Proc x -> x
	|Bloc x -> x
	|Liste x -> x
	|Fonction x -> [Var "base"]
	|Vide -> [Var "base"]

 let rec to_bloc = function
	|Entier x -> [Entier x]
	|Flottant x -> [Flottant x]
	|Caractere x -> [Caractere x]
	|Chaine x -> [Chaine x]
	|Var x -> to_proc (read_var_aux x)
	|Booleen x -> [Booleen x]
	|Proc x -> x
	|Bloc x -> x
	|Liste x -> x
	|Fonction x -> [Var "base"]
	|Vide -> [Var "base"]

 let rec to_list = function
	|Entier x -> [Entier x]
	|Flottant x -> [Flottant x]
	|Caractere x -> [Caractere x]
	|Chaine x -> [Chaine x]
	|Var x -> to_list (read_var_aux x)
	|Booleen x -> [Booleen x]
	|Proc x -> x
	|Bloc x -> x
	|Liste x -> x
	|Fonction x -> []
	|Vide -> []
	
 let rec to_fonction = function
	|Fonction x -> x
	|_ -> (function x -> Vide)
	
let dyn_conv var varbis = match var with
	|Entier x -> Entier (to_int varbis)
	|Flottant x -> Flottant (to_float varbis)
	|Caractere x -> Caractere (to_char varbis)
	|Chaine x -> Chaine (to_string varbis)
	|Var x -> Var (to_var varbis)
	|Booleen x -> Booleen (to_bool varbis)
	|Proc x -> Proc (to_proc varbis)
	|Bloc x -> Bloc (to_bloc varbis)
	|Liste x -> Liste (to_list varbis)
	|Fonction x -> Fonction (to_fonction varbis)
	|Vide -> Vide

(* let equality var varbis =
	let second = dyn_conv var varbis 
	in match (var, second) with
		| (Entier x, Entier y) -> x = y *)

(* let _ = print_endline (to_string (Var "base"))
let entree = ["123"; "10.123"; "\"coucou\""; "(print \"test\")"; "base"]
let entreebis = List.map to_valeur entree
let _ = List.iter (function x -> ignore (cust_print x)) entreebis *)
