open Conversion

(* Fonctions Additionnelle *)
let slice_list liste a b =
	let rec aux acc i = 
		if i > b then acc
		else aux ((List.nth liste i) :: acc) (i + 1)
	in List.rev (aux [] a)
	
let slice_str str a b =
	let rec aux acc i = 
		if i > b then acc
		else aux (acc ^ (String.make 1 str.[i])) (i + 1)
	in aux "" a

let get_value liste index default =
	if index < List.length liste
	then List.nth liste index
	else default
	
let string_of_list liste fonc = 
	let milieu = List.map fonc liste
	in "[" ^ (String.concat ", " milieu) ^ "]"

let rec string_of_valeur = function
	|Entier x -> "Entier " ^ (string_of_int x)
	|Flottant x -> "Flottant " ^ (string_of_float x)
	|Caractere x -> "Caractere " ^ (String.make 1 x)
	|Chaine x -> "Chaine " ^ x
	|Var x -> "Var " ^ x
	|Booleen x -> "Booleen " ^ (string_of_bool x)
	|Proc x -> "Proc " ^ string_of_list x string_of_valeur
	|Bloc x -> "Bloc " ^ string_of_list x string_of_valeur
	|Liste x -> "Liste " ^ string_of_list x string_of_valeur
	|Fonction _ -> "Fonction "
	|Vide -> "Vide "

(* Fonctions Utilisables *)
let cust_print valeurs = 
	let aux = List.map to_string valeurs
	in let auxb = String.concat " " aux
	in let _ = print_endline auxb
	in Chaine auxb
	
let cust_get valeurs =
	let texte = to_string (get_value valeurs 0 Vide)
	in let _ = if texte <> "" then print_endline texte
	in read_line ()