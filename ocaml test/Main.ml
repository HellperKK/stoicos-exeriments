open Conversion
open FoncsLib

exception MissingElement

(* Fonctions de lecture de fichier *)
let read_line_test chanel =
	try
		Some (input_line chanel)
	with
		|End_of_file -> None
let read_file_tab chanel = 
	let rec aux acc = match  read_line_test chanel with
		|None -> acc
		|Some x -> aux (x :: acc)
	in List.rev (aux [])

(* Premier parseur *)
let until_no_blank_start liste =
	let rec aux = function
		|x when x = List.length liste -> None
		|x when (List.nth liste x).[0] = ' ' || (List.nth liste x).[0] = '\t' -> aux (x + 1)
		|x -> Some x
	in aux 1
let rec format_lines liste = 
	let rec aux acc listeb = match until_no_blank_start listeb with
		|None -> listeb :: acc
		|Some x -> aux ((slice_list listeb 0 (x-1)) :: acc) (slice_list listeb x (List.length listeb - 1))
	in let auxb = List.rev (aux [] liste)
	in List.map (function x -> String.concat " " (List.map String.trim x)) auxb

(* Second parseur *)
let first_char str charac =
	let rec aux = function
		|x when x = String.length str -> raise MissingElement
		|x when str.[x] = charac -> x
		|x -> aux (x + 1)
	in aux 1
let match_bracket str opener closer=
	let rec aux compteur = function
		|x when compteur = 0 -> (x - 1)
		|x when x = String.length str -> raise MissingElement
		|x when str.[x] = opener -> aux (compteur + 1) (x + 1)
		|x when str.[x] = closer -> aux (compteur - 1) (x + 1)
		|x -> aux compteur (x + 1)
	in aux 1 1
let rec line_to_valeurs str =
	let rec aux acc str =
		try
			match str with
				|"" -> acc
				|x when x.[0] = '"' -> let milieu =  first_char str '"'
					in aux (slice_str x 0 milieu :: acc) (slice_str x (milieu + 1) (String.length x - 1))
				|x when x.[0] = '\'' -> let milieu =  first_char str '\''
					in aux ((slice_str x 0 milieu) :: acc) (slice_str x (milieu + 1) (String.length x - 1))
				|x when x.[0] = '(' -> let milieu =  match_bracket str '(' ')'
					in aux ((slice_str x 0 milieu) :: acc) (slice_str x (milieu + 1) (String.length x - 1))
				|x when x.[0] = '[' -> let milieu =  match_bracket str  '[' ']'
					in aux ((slice_str x 0 milieu) :: acc) (slice_str x (milieu + 1) (String.length x - 1))
				|x when x.[0] = '{' -> let milieu =  match_bracket str  '{' '}'
					in aux ((slice_str x 0 milieu) :: acc) (slice_str x (milieu + 1) (String.length x - 1))
				(* |x when not (String.contains x ' ') -> (x :: acc) *)
				|x -> let milieu =  first_char str ' '
					in aux ((slice_str x 0 (milieu - 1)) :: acc) (slice_str x (milieu + 1) (String.length x - 1))
		with
			|MissingElement -> (str :: acc)
			|Invalid_argument "String.sub / Bytes.sub" -> (str :: acc) 
	in List.map to_valeur (List.rev (aux [] str))
	
(* Conversions des donnees en type valeur *)
and to_valeur = function
	|x when x = (chars_only_from x "0123456789") -> Entier (super_int_of_string x)
	|x when x = (chars_only_from x "0123456789.") -> Flottant (super_float_of_string x)
	|x when x.[0] = '\'' -> Caractere x.[1]
	|x when x.[0] = '"' -> Chaine (String.sub x 1 (String.length x - 2))
	|x when x.[0] = '[' -> Liste (line_to_valeurs (String.sub x 1 (String.length x - 2)))
	|x when x.[0] = '(' -> Proc (line_to_valeurs (String.sub x 1 (String.length x - 2)))
	|x when x.[0] = '{' -> Bloc (line_to_valeurs (String.sub x 1 (String.length x - 2)))
	|x when x = "true" || x = "false" -> Booleen (bool_of_string x)
	|x -> Var x

(* Execution *)
let execute = function
	|(Var "print") :: ls -> cust_print ls
	|x -> let _ = print_endline "coucou" in Vide

(* Main *)
let fichier = if Array.length Sys.argv > 1 then Array.get Sys.argv 1 else "Test.txt"
let contenu = read_file_tab (open_in fichier)
let contenubis = 
	let aux = format_lines contenu
	in List.map line_to_valeurs aux
(* let _ = List.iter (function x -> print_endline (String.concat "_" (List.map to_string x))) contenubis *)
let _ = List.iter (function x -> ignore (execute x)) contenubis