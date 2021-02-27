
#use "pc.ml";;

open PC;;
exception X_not_yet_implemented;;
exception X_this_should_not_happen;;
  
type number =
  | Fraction of int * int
  | Float of float;;
  
type sexpr =
  | Bool of bool
  | Nil
  | Number of number
  | Char of char
  | String of string
  | Symbol of string
  | Pair of sexpr * sexpr;;

let rec sexpr_eq s1 s2 =
  match s1, s2 with
  | Bool(b1), Bool(b2) -> b1 = b2
  | Nil, Nil -> true
  | Number(Float f1), Number(Float f2) -> abs_float(f1 -. f2) < 0.001
  | Number(Fraction (n1, d1)), Number(Fraction (n2, d2)) -> n1 = n2 && d1 = d2
  | Char(c1), Char(c2) -> c1 = c2
  | String(s1), String(s2) -> s1 = s2
  | Symbol(s1), Symbol(s2) -> s1 = s2
  | Pair(car1, cdr1), Pair(car2, cdr2) -> (sexpr_eq car1 car2) && (sexpr_eq cdr1 cdr2)
  | _ -> false;;

module Reader: sig
    val normalize_scheme_symbol : string -> string
    val make_paired : ('a -> 'b * 'c) -> ('d -> 'e * 'f) -> ('f -> 'g * 'a) -> 'd -> 'g * 'c
    val read_semicolon : char list -> char * char list
    val read_lparen : char list -> char * char list
    val read_rparen : char list -> char * char list
    val read_lparen_nil : char list -> sexpr * char list
    val read_rparen_nil : char list -> sexpr * char list
    val read_true : char list -> sexpr * char list
    val read_false : char list -> sexpr * char list
    val read_bool : char list -> sexpr * char list
    val read_backslash : char list -> char list * char list
    val read_char_prefix : char list -> char * char list
    val read_visible_simple_char : char list -> char * char list
    val read_named_char : char list -> char * char list
    val read_char : char list -> sexpr * char list
    val read_zeros : char list -> char list * char list
    val ascii_0 : int
    val read_digit_as_number : char list -> int * char list
    val read_digit_as_char : char list -> char * char list
    val read_digit_as_string : char list -> string * char list
    val read_natural : char list -> int * char list
    val compute_gcd : int -> int -> int
    val read_plus_sign : char list -> int * char list
    val read_minus_sign : char list -> int * char list
    val read_plus_or_minus : char list -> int * char list
    val read_integer : char list -> sexpr * char list
    val read_whole : char list -> string * char list
    val read_frac : char list -> string * char list
    val read_float : char list -> sexpr * char list
    val read_numerator : char list -> string * char list
    val read_denominator : char list -> int * char list
    val read_fraction : char list -> sexpr * char list
    val read_number : char list -> sexpr * char list
    val read_e : char list -> sexpr * char list
    val read_E : char list -> sexpr * char list
    val read_scientific_notation : char list -> sexpr * char list
    val read_special_backslash : char list -> char * char list
    val read_double_comma : char list -> char list * char list
    val read_string_literal_char : char list -> char * char list
    val read_string_meta_char : char list -> char * char list
    val read_string_char : char list -> char * char list
    val read_string : char list -> sexpr * char list
    val read_letter_ci : char list -> char * char list
    val read_letter : char list -> char * char list
    val read_dot : char list -> char * char list
    val read_dot_as_string : char list -> string * char list
    val read_special_chars : char list -> char * char list
    val read_symbol_char_no_dot : char list -> string * char list
    val read_symbol_char : char list -> string * char list
    val read_packed_symbol_char : char list -> string * char list
    val read_symbol : char list -> sexpr * char list
    val read_end_of_line : char list -> char * char list
    val packed_nt_end_of_input : char list -> char * 'a list
    val read_allowed_char : char list -> char * char list
    val read_allowed_chars : char list -> char * char list
    val read_final_chars : char list -> char * char list
    val read_line_comment : char list -> sexpr * char list
    val read_apostrophe : char list -> char * char list
    val read_grave_accent : char list -> char * char list
    val read_comma : char list -> char * char list
    val read_strudel : char list -> char * char list
    val read_whitespace_or_less : char list -> sexpr * char list
    val read_sexpr : char list -> sexpr * char list
    val read_list : char list -> sexpr * char list
    val read_dotted_list : char list -> sexpr * char list
    val read_quote : char list -> sexpr * char list
    val read_quasiquote : char list -> sexpr * char list
    val read_unquote : char list -> sexpr * char list
    val read_unquote_splicing : char list -> sexpr * char list
    val read_sexprs_comment : char list -> sexpr * char list
    val read_sexprs : string -> sexpr list

end
= struct
let normalize_scheme_symbol str =
  let s = string_to_list str in
  if (andmap
	(fun ch -> (ch = (lowercase_ascii ch)))
	s) then str
  else Printf.sprintf "|%s|" str;;

let make_paired nt_right nt_left nt = 
  let nt = caten nt_left nt in
  let nt = pack nt(function(_, e) -> e) in
  let nt = caten nt nt_right in
  let nt = pack nt(function(e, _) -> e) in
    nt;;


(* SemiColon *)
let read_semicolon = (char ';')

(* LeftParentheses *)
let read_lparen = (char '(')

(* RightParentheses *)
let read_rparen = (char ')')








(* Boolean *)
let read_true = pack (caten (char '#') (char_ci 't')) (fun _ -> Bool(true))
let read_false = pack (caten (char '#') (char_ci 'f')) (fun _ -> Bool(false))
let read_bool = (disj read_true read_false)











(* CharPrefix *)
let read_char_prefix = pack (word "#\\") (fun _ -> ' ')

(* VisibleSimpleChar *)
let read_visible_simple_char = (const (fun ch -> ch > ' '))

(* NamedChar *)
let read_named_char =
let read_nul = pack (word_ci "nul") (fun _ -> '\000') in
let read_newline = pack (word_ci "newline") (fun _ -> '\010') in
let read_return = pack (word_ci "return") (fun _ -> '\013') in 
let read_tab =  pack (word_ci "tab") (fun _ -> '\009') in 
let read_page = pack (word_ci "page") (fun _ -> '\012') in 
let read_space = pack (word_ci "space") (fun _ -> '\032') in 
(disj_list [read_nul; read_newline; read_return; read_tab; read_page; read_space])

(* Char *)
let read_char = pack (caten read_char_prefix (disj read_named_char read_visible_simple_char)) (fun (strs, ch) -> Char(ch))












(* LeadingZeros *)
let read_zeros = (star (char '0'))

(* Digit *)
let ascii_0 = 48
let read_digit_as_number = pack (const (fun ch -> '0' <= ch && ch <= '9')) (fun ch -> (int_of_char ch) - ascii_0)
let read_digit_as_char = const (fun ch -> '0' <= ch && ch <= '9')
let read_digit_as_string = pack (const (fun ch -> '0' <= ch && ch <= '9')) (Char.escaped)

(* Natural *)
let read_natural =
let rec make_nt_natural () =
  pack (caten read_digit_as_number
    (disj (delayed make_nt_natural)
      nt_epsilon))
    (function (a, s) -> a :: s) in
  pack (make_nt_natural())
    (fun s ->(List.fold_left
      (fun a b -> 10 * a + b)
      0
      s));;

let rec compute_gcd n1 n2 = 
match n2 with
| 0 -> n1
| _ -> compute_gcd n2 (n1 mod n2);;


(* Integer *)
let read_plus_sign = pack (char '+') (fun _ -> 1)
let read_minus_sign = pack (char '-') (fun _ -> -1)
let read_plus_or_minus = pack (maybe (disj read_plus_sign read_minus_sign)) (fun result -> match result with
  | None -> 1
  | Some(result) -> result)
let read_integer = pack (caten read_plus_or_minus read_natural) (fun (n1, n2) -> Number(Fraction (n1 * n2, 1)))

(* Float *)
let read_whole = pack (caten read_plus_or_minus read_natural) (fun (n1, n2) -> if(n1 == -1 && n2 == 0) then "-0" else (string_of_int (n1 * n2)))

let read_frac = pack (caten (char '.') (plus read_digit_as_char)) (fun (ch, fracs) -> (list_to_string fracs))
let read_float = pack (caten read_whole read_frac) (fun (s1, f1) -> 
let s = String.concat "" [s1; "."; f1] in
Number(Float(float_of_string s)))

(* Fraction *)
let read_numerator = pack (caten read_plus_or_minus read_natural) (fun (n1, n2) -> if(n1 == -1 && n2 == 0) then "-0" else (string_of_int (n1 * n2)))
let read_denominator = pack (caten (char '/') read_natural) (fun (ch, den) -> den)
let read_fraction = pack (caten read_numerator read_denominator) (fun (n1, d1) -> 
Number(Fraction((int_of_string n1) / (abs (compute_gcd (int_of_string n1) d1)), abs(d1 / (compute_gcd (int_of_string n1) d1)))))

(* Scientific notation *)
let read_e = pack (char 'e') (fun _ -> Number(Float(0.0)))
let read_E = pack (char 'E') (fun _ -> Number(Float(0.0)))
let read_scientific_notation = pack (caten (disj read_float read_integer) (caten (disj read_e read_E) read_integer))
  (fun x -> match x with
  | Number(Fraction(whole, 1)), (ch1, Number(Fraction(p, 1))) -> Number(Float((float_of_int whole) *. (10. ** (float_of_int p))))
  | Number(Float(fl)), (ch1, Number(Fraction(p, 1))) -> Number(Float(fl *. (10. ** (float_of_int p))))
  | _ -> raise X_this_should_not_happen)


(* Number *)
let read_number = (disj_list [read_scientific_notation; read_float; read_fraction; read_integer])












(* Special_backslash *)
let read_special_backslash = (char '\092')

(* DoubleComma *)
let read_double_comma =  (word "\"")



(* StringLiteralChar *)
let read_backslash = (word "\\") 
let read_double_quote = (word "\"")
let read_backslash_or_double_quote = (disj read_backslash read_double_quote)
let read_string_literal_char = (diff nt_any read_backslash_or_double_quote)

(* StringMetaChar *)  
let read_string_meta_char =
let read_return = pack (word_ci "\\r") (fun _ -> '\013') in
let read_newline = pack (word_ci "\\n") (fun _ -> '\010') in
let read_tab = pack (word_ci "\\t") (fun _ -> '\009') in 
let read_page =  pack (word_ci "\\f") (fun _ -> '\012') in 
let read_backslash = pack (word_ci "\\\\") (fun _ -> '\092') in 
let read_double_quote = pack (word_ci "\\\"") (fun _ -> '\034') in 
(disj_list [read_backslash; read_double_quote; read_tab; read_page; read_newline; read_return])

(* StringChar *)
let read_string_char = (disj read_string_literal_char read_string_meta_char)

(* String *)
let read_string = pack (caten read_double_comma (caten (star read_string_char) read_double_comma))
      (fun (str1, (strs, str2)) -> String((list_to_string strs)))












(* Letter *)
let read_letter_ci = pack (const (fun ch -> ('a' <= ch && ch <= 'z') || ('A' <= ch && ch <= 'Z'))) (fun ch -> (lowercase_ascii ch))
let read_letter = const (fun ch -> ('a' <= ch && ch <= 'z') || ('A' <= ch && ch <= 'Z'))

(* Dot *)
let read_dot = (char '.')
let read_dot_as_string = pack (char '.') (Char.escaped)

(* SpecialChars *) 
let read_special_chars = const (fun ch -> '!' == ch || '$' == ch || '^' == ch || '*' == ch || '-' == ch || '_' == ch || '=' == ch || '+' == ch || '<' == ch || '>' == ch || '?' == ch || '/' == ch || ':' == ch)

(* SymbolCharNoDot *)
let read_symbol_char_no_dot = pack (one_of_ci "1234567890abcdefghijklmnopqrstuvwxyz!$^*-_=+<>?/:") (fun ch -> (Char.escaped (lowercase_ascii ch)))

(* SymbolChar *)
let read_symbol_char = (disj read_symbol_char_no_dot read_dot_as_string)
let read_packed_symbol_char = pack (caten read_symbol_char (plus read_symbol_char)) (fun (str, strs) -> String.concat "" (List.append [str] strs))

(* Symbol *)
let read_symbol = pack (disj read_packed_symbol_char read_symbol_char_no_dot) (fun s -> Symbol(s))


(* EndOfLine *)
let read_end_of_line = (char_ci '\n')
let packed_nt_end_of_input = pack (nt_end_of_input) (fun _ -> '\n')

(* LineComments *)
let read_allowed_char = const (fun ch -> (lowercase_ascii ch) != '\n')
let read_allowed_chars = pack (star read_allowed_char) (fun _ -> '\n')
let read_final_chars = (disj read_end_of_line packed_nt_end_of_input)
let read_line_comment = pack (caten_list [read_semicolon; read_allowed_chars; read_final_chars]) (fun _ -> Nil) 



(* Apostophe *)
let read_apostrophe = (char '\'') (* TODO: needs to be checked *)

(* GraveAccent *)
let read_grave_accent = (char '`')

(* Comma *)
let read_comma = (char ',')

(* Strudel *)
let read_strudel = (char '@')

let read_lparen_nil = pack (char '(') (fun _ -> Nil)
let read_rparen_nil = pack (char ')') (fun _ -> Nil)

(* WhiteSpace *)
let read_whitespace_or_less = pack (const (fun ch -> (' ' >= ch))) (fun _ -> Nil) ;;


(* Sexpression *)
let rec read_sexpr s = 
let paired_read_sexpr = make_paired ignore_whitespace_or_line_comment_or_sexpr_comment
ignore_whitespace_or_line_comment_or_sexpr_comment (disj_list [read_bool; read_char; (not_followed_by read_number (disj read_symbol (pack (read_dot) (fun _ -> Nil)))); read_symbol; read_nil; read_list; read_dotted_list; read_string; read_symbol; read_quote; read_quasiquote; read_unquote; read_unquote_splicing]) in
paired_read_sexpr s

  (* List *)
  and read_list s = 
  let paren_and_sexprs = (caten read_lparen (caten (star read_sexpr) read_rparen)) in
  let list_of_sexprs = pack (paren_and_sexprs) (fun (lparen, (sexprs, rparen)) -> (List.fold_right (fun arg1 arg2 -> Pair(arg1, arg2)) sexprs Nil)) in
  list_of_sexprs s

  (* DottedList *)
  and read_dotted_list s = 
  let read_plus_sexprs = (plus read_sexpr) in
  let paren_sexprs_dot = (caten read_lparen (caten read_plus_sexprs (caten read_dot (caten read_sexpr read_rparen)))) in
  let list_of_sexprs = pack (paren_sexprs_dot) (fun (lparen, (sexprs, (dot, (sexpr, rparen)))) -> 
  (List.fold_right (fun arg1 arg2 -> Pair(arg1, arg2)) sexprs sexpr)) in
  list_of_sexprs s

  (* Quoted *)
  and read_quote s = (pack (caten read_apostrophe read_sexpr) (fun (ch, sexpr) -> Pair(Symbol("quote"), Pair(sexpr, Nil)))) s

  (* QuasiQuoted *)
  and read_quasiquote s = (pack (caten read_grave_accent read_sexpr) (fun (ch, sexpr) -> Pair(Symbol("quasiquote"), Pair(sexpr, Nil)))) s

  (* Unquoted *)
  and read_unquote s = (pack (caten read_comma read_sexpr) (fun (ch, sexpr) -> Pair(Symbol("unquote"), Pair(sexpr, Nil)))) s

  (* UnquoteAndSpliced *)
  and read_unquote_splicing s = (pack (caten read_comma (caten read_strudel read_sexpr)) (fun (ch1, (ch2, sexpr)) -> Pair(Symbol("unquote-splicing"), Pair(sexpr, Nil)))) s

  (* SexprComments *)
  and read_sexprs_comment s =  pack (caten (char '#') (caten (char ';') (caten (star read_whitespace_or_less) read_sexpr))) (fun _ -> Nil) s

  and ignore_whitespace_or_line_comment_or_sexpr_comment s = pack (star (disj_list [read_whitespace_or_less; read_line_comment; read_sexprs_comment])) (fun _ -> Nil) s

  and read_nil s = pack (caten_list [read_lparen_nil; ignore_whitespace_or_line_comment_or_sexpr_comment; read_rparen_nil]) (fun _ -> Nil) s;;



(* Sexpressions *)
let read_sexprs string =
let lst = (string_to_list string) in
let (ast, end_list_of_chars) = (star read_sexpr) lst in
ast

end;; (* struct Reader *)

open Reader;;