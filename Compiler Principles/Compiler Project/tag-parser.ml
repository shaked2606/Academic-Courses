#use "reader.ml";;


open Reader;;
open PC;;
type constant =
  | Sexpr of sexpr
  | Void

type expr =
  | Const of constant
  | Var of string
  | If of expr * expr * expr
  | Seq of expr list
  | Set of expr * expr
  | Def of expr * expr
  | Or of expr list
  | LambdaSimple of string list * expr
  | LambdaOpt of string list * string * expr
  | Applic of expr * (expr list);;

let rec expr_eq e1 e2 =
  match e1, e2 with
  | Const Void, Const Void -> true
  | Const(Sexpr s1), Const(Sexpr s2) -> sexpr_eq s1 s2
  | Var(v1), Var(v2) -> String.equal v1 v2
  | If(t1, th1, el1), If(t2, th2, el2) -> (expr_eq t1 t2) &&
                                            (expr_eq th1 th2) &&
                                              (expr_eq el1 el2)
  | (Seq(l1), Seq(l2)
    | Or(l1), Or(l2)) -> List.for_all2 expr_eq l1 l2
  | (Set(var1, val1), Set(var2, val2)
    | Def(var1, val1), Def(var2, val2)) -> (expr_eq var1 var2) &&
                                             (expr_eq val1 val2)
  | LambdaSimple(vars1, body1), LambdaSimple(vars2, body2) ->
     (List.for_all2 String.equal vars1 vars2) &&
       (expr_eq body1 body2)
  | LambdaOpt(vars1, var1, body1), LambdaOpt(vars2, var2, body2) ->
     (String.equal var1 var2) &&
       (List.for_all2 String.equal vars1 vars2) &&
         (expr_eq body1 body2)
  | Applic(e1, args1), Applic(e2, args2) ->
     (expr_eq e1 e2) &&
       (List.for_all2 expr_eq args1 args2)
  | _ -> false;;
	
                       
exception X_syntax_error;;

module type TAG_PARSER = sig
  val nested_pairs_to_list : sexpr -> sexpr list
  val is_proper_list : sexpr -> bool 
  val tag_parse_expression : sexpr -> expr 
  val tag_parse_expressions : sexpr list -> expr list
end;; (* signature TAG_PARSER *)

module Tag_Parser : TAG_PARSER = struct

let reserved_word_list =
  ["and"; "begin"; "cond"; "define"; "else";
   "if"; "lambda"; "let"; "let*"; "letrec"; "or";
   "quasiquote"; "quote"; "set!"; "pset!"; "unquote";
   "unquote-splicing"];;  

(* work on the tag parser starts here *)

let rec nested_pairs_to_list lst = 
match lst with
| Nil -> []
| Pair(element, rest) -> (List.append [element] (nested_pairs_to_list rest))
| element -> [element]

let rec get_list_without_last_element lst = (List.rev (List.tl (List.rev lst)))

let rec is_proper_list lst = 
  match lst with
  | Pair(element, rest) -> (is_proper_list rest)
  | Nil -> true
  | _ -> false

let rec find_duplicates lst = 
match lst with 
| [] -> false
| element :: rest -> (List.exists ((=) element) rest || find_duplicates rest)

let rec list_to_proper_list lst = 
match lst with
| [] -> Nil
| element :: rest -> Pair(element, (list_to_proper_list rest))

let list_with_special_variables lst =
    let rec special_variable element temp_lst = 
      (match element with 
      | (Pair (Symbol(name), Pair (value, Pair(Symbol(name_to_change), Nil)))) -> 
            let temp_element = (Pair (Symbol(name), Pair (value, Pair(Symbol((String.make 1 '!' ^ name_to_change)), Nil)))) in 
            if ((List.mem temp_element temp_lst)) then (special_variable temp_element temp_lst) else (List.append [temp_element] temp_lst)
      | _ -> raise X_no_match) in
    (List.fold_right (fun element new_list -> (special_variable element new_list)) lst [])


let rec tag_parse_expression sexpr = 
match sexpr with
(* Constants *)
| Bool(bool) -> (parse_bool bool)

| Number(num) -> (parse_number num)

| Char(ch) -> (parse_char ch)

| String(str) -> (parse_string str)

| Pair(Symbol("quote"), Pair(quote, Nil)) -> (parse_quote quote)

(* Variables *)
| Symbol(sym) -> (parse_symbol sym)

(* Conditionals *)
| Pair(Symbol("if"), Pair(test, Pair(dit, Pair(dif, Nil)))) -> (parse_if_then_else test dit dif)

| Pair(Symbol("if"), Pair(test, Pair(dit, Nil))) -> (parse_if_then test dit)

(* Disjunctions *)
| Pair(Symbol "or", exprs) -> (parse_or exprs)

(* MIT Define Expr *)
| Pair(Symbol "define", Pair(Pair(name, argl), exprs)) -> (parse_mit_define name argl exprs)

(* Define Expr *)
| Pair(Symbol "define", Pair(name, Pair(expr, Nil))) -> (parse_define name expr)

(* Set! Expr *)
| Pair(Symbol "set!", Pair(name, Pair(expr, Nil))) -> (parse_set name expr)

(* Lambda *)
| Pair(Symbol "lambda", Pair(params, body)) when ((is_proper_list params) && (not (find_duplicates (nested_pairs_to_list params))) && (is_proper_list body)) -> (parse_simple_lambda params body)

| Pair(Symbol "lambda", Pair(Symbol(param), body)) when (is_proper_list body) -> (parse_variadic_lambda param body)

| Pair(Symbol "lambda", Pair(params, body)) when ((not (is_proper_list params)) && (is_proper_list body)) -> (parse_opt_lambda params body) 

(* Explicit Sequences *)
| Pair(Symbol "begin", exprs) -> (parse_explicit_sequences exprs)

(* Quasiquoted Expr *)
| Pair(Symbol "quasiquote", Pair(exprs, Nil)) -> (tag_parse_expression (parse_quasiquote exprs))

(* Cond Expr *)
| Pair(Symbol "cond", ribs) -> (tag_parse_expression (recursive_cond ribs))

(* Let Expr *)
| Pair(Symbol "let", Pair(bindings, body)) -> (parse_let bindings body)

(* Let* Expr *)
| Pair(Symbol "let*",  Pair(bindings, body)) -> (tag_parse_expression (parse_let_star bindings body))

(* Letrec Expr *)
| Pair(Symbol "letrec", Pair(bindings, body)) -> (parse_let_rec bindings body)

(* And Expr *)
| Pair(Symbol "and", exprs) -> (parse_and exprs)

(* Pset! Expr *)
| Pair(Symbol "pset!", bindings) -> (parse_pset bindings) 

(* Application *)
| Pair(expr, exprs) -> (parse_application expr exprs)

| _ -> raise X_this_should_not_happen


(* Constants *)
and parse_bool bool = Const(Sexpr(Bool(bool)))

and parse_number number = 
match number with
| Fraction(frac, den) -> Const(Sexpr(Number(Fraction(frac, den))))
| Float(fl) -> Const(Sexpr(Number(Float(fl))))

and parse_char ch = Const(Sexpr(Char(ch)))

and parse_string str = Const(Sexpr(String(str)))

and parse_quote quote = Const(Sexpr(quote))

(* Variables *)
and resereved_sym symb = List.mem symb reserved_word_list

and parse_symbol sym = 
  match (resereved_sym sym) with
  | false -> Var(sym)
  | _ -> raise X_this_should_not_happen

(* Conditionals *)
and parse_if_then_else test dit dif = If(tag_parse_expression test, tag_parse_expression dit, tag_parse_expression dif)

and parse_if_then test dit = If(tag_parse_expression test, tag_parse_expression dit, Const(Void))

(* Lambda *)
and parse_simple_lambda params body = 
let parsed_body = (parse_implicit_sequences body) in
let parsed_params_to_exp = (List.map (fun param -> tag_parse_expression param) (nested_pairs_to_list params)) in
let mapped_params = (List.map (fun param -> 
match param with 
| Var(v) -> v
| _ -> raise X_this_should_not_happen) 
parsed_params_to_exp) in
LambdaSimple(mapped_params, parsed_body)


and parse_opt_lambda params body = 
let parsed_body = (parse_implicit_sequences body) in
let parsed_params_to_exp = (List.map (fun param -> tag_parse_expression param) (nested_pairs_to_list params)) in
let get_nth_elements_of_params = (get_list_without_last_element parsed_params_to_exp) in 
let get_last_element_of_params = (List.nth parsed_params_to_exp ((List.length parsed_params_to_exp)-1)) in 
let mapped_params = (List.map (fun param -> 
match param with 
| Var(v) -> v
| _ -> raise X_this_should_not_happen) 
get_nth_elements_of_params) in
let get_string_from_last_element = 
match get_last_element_of_params with
| Var(v) -> v
| _ -> raise X_this_should_not_happen in 
if (not (find_duplicates get_nth_elements_of_params))
then LambdaOpt(mapped_params, get_string_from_last_element, parsed_body)
else raise X_this_should_not_happen

and parse_variadic_lambda param body = LambdaOpt([], param, (parse_implicit_sequences body))


(* Disjunctions *)
and parse_or exprs = 
match (nested_pairs_to_list exprs) with 
| [] ->  Const(Sexpr(Bool(false)))
| [element] -> (tag_parse_expression element)
| _ -> Or((List.map (fun expr -> tag_parse_expression expr) (nested_pairs_to_list exprs)))

(* Define Expr *)
and parse_define name expr = 
  let parsed_name = (tag_parse_expression name) in
      match parsed_name with
      | Var(n) -> Def(parsed_name, (tag_parse_expression expr))
      | _ -> raise X_this_should_not_happen

(* Set! Expr *)
and parse_set name expr = 
  let parsed_name = (tag_parse_expression name) in
      match parsed_name with
      | Var(n) -> Set(parsed_name, (tag_parse_expression expr))
      | _ -> raise X_this_should_not_happen

(* Sequences *)
and parse_explicit_sequences exprs =  
  let is_seq_proper_list = (is_proper_list exprs) in
  let explicit =
    match exprs with 
      | Nil -> Const(Void)
      | Pair(element, Nil) -> (tag_parse_expression element)
      | _ -> Seq((List.flatten (List.map (fun expr -> 
      let parsed_seq = (tag_parse_expression expr) in 
      match parsed_seq with
      | Seq(element) -> element
      | _ -> [parsed_seq]) 
      (nested_pairs_to_list exprs)))) in
  match is_seq_proper_list with
  | true -> explicit
  | false -> raise X_this_should_not_happen

  and parse_implicit_sequences exprs =  
    let is_seq_proper_list = (is_proper_list exprs) in
    let implicit =
      match exprs with 
        | Nil -> raise X_this_should_not_happen
        | Pair(element, Nil) -> (tag_parse_expression element)
        | _ -> Seq((List.flatten (List.map (fun expr -> 
        let parsed_seq = (tag_parse_expression expr) in 
        match parsed_seq with
        | Seq(element) -> element
        | _ -> [parsed_seq]) 
        (nested_pairs_to_list exprs)))) in
    match is_seq_proper_list with
    | true -> implicit
    | false -> raise X_this_should_not_happen

(* Application *)
and parse_application expr exprs = Applic(tag_parse_expression expr, (List.map (fun expr -> tag_parse_expression expr) (nested_pairs_to_list exprs))) 


(* Macro Expansions *)

and parse_and exprs = 
let paired_exprs_to_list = (nested_pairs_to_list exprs) in
match paired_exprs_to_list with 
| [] -> Const(Sexpr(Bool(true)))
| element :: [] -> (tag_parse_expression element)
| _ ->
let get_first_element = (tag_parse_expression (List.hd paired_exprs_to_list)) in 
let get_rest_of_elements_without_first = (List.fold_right (fun arg1 arg2 -> Pair(arg1, arg2)) (List.tl paired_exprs_to_list) Nil) in
let and_rest = Pair(Symbol "and", get_rest_of_elements_without_first) in 
If(get_first_element, (tag_parse_expression and_rest), Const(Sexpr(Bool(false))))


(* MIT Define Expr *)
and parse_mit_define name argl exprs = 
let parsed_lambda = (tag_parse_expression (Pair(Symbol "lambda", Pair(argl, exprs)))) in 
let parsed_name = (tag_parse_expression name) in
match parsed_name with
| Var(v) -> Def(Var(v), parsed_lambda)
| _ -> raise X_this_should_not_happen 


(* Cond Expr *)
and recursive_cond ribs =
let parsed_ribs = 
(match ribs with
| Pair(Pair(Symbol "else", expr), rest) -> (Pair(Symbol "begin", expr))

| Pair(Pair(expr, Pair(Symbol "=>", Pair(exprf, Nil))), Nil) ->
  Pair (Symbol "let", Pair(Pair (Pair (Symbol "value", Pair (expr, Nil)),
  Pair(Pair (Symbol "f", Pair(Pair (Symbol "lambda", Pair (Nil, Pair (exprf, Nil))), Nil)), Nil)),
  Pair(Pair (Symbol "if", Pair (Symbol "value", Pair (Pair (Pair (Symbol "f", Nil), Pair (Symbol "value", Nil)), Nil))), Nil)))

| Pair(Pair(expr, Pair(Symbol "=>", Pair(exprf, Nil))), rest) ->
    Pair (Symbol "let", Pair(Pair (Pair (Symbol "value", Pair (expr, Nil)), Pair(Pair (Symbol "f", Pair
    (Pair (Symbol "lambda", Pair (Nil, Pair (exprf, Nil))), Nil)), 
    Pair(Pair (Symbol "rest", Pair(Pair (Symbol "lambda", 
    Pair (Nil, Pair (recursive_cond rest, Nil))), Nil)), Nil))),
    Pair(Pair (Symbol "if", Pair (Symbol "value", 
    Pair (Pair (Pair (Symbol "f", Nil), Pair (Symbol "value", Nil)), 
    Pair (Pair (Symbol "rest", Nil), Nil)))), Nil)))
| Pair(Pair(expr, exprf), Nil) -> Pair (Symbol "if", Pair (expr, Pair (Pair (Symbol "begin", exprf), Nil)))
| Nil -> Nil
| Pair(Pair(expr, exprf), rest) -> Pair (Symbol "if", Pair (expr, Pair (Pair (Symbol "begin", exprf), Pair (recursive_cond rest, Nil))))
| _ -> raise X_this_should_not_happen) in
(parsed_ribs)

(* PSet Expr *)
and parse_pset bindings = 
let full_details_list_bindings = (List.map (fun binding -> 
match binding with 
| (Pair (Symbol(name), Pair (value, Nil))) -> (Pair (Symbol(name), Pair (value, Pair(Symbol(name), Nil))))
|_ -> raise X_this_should_not_happen) (nested_pairs_to_list bindings)) in 

let get_special_vars = (list_with_special_variables full_details_list_bindings) in 

let get_vars = (List.map (fun binding -> 
match binding with 
| (Pair (Symbol(name), Pair (value, Pair(Symbol(name_changed), Nil)))) -> Symbol(name_changed)
| _ -> raise X_this_should_not_happen) 
get_special_vars) in

let get_values = (List.map (fun binding -> 
match binding with 
| (Pair (Symbol(name), Pair (value, Pair(Symbol(name_changed), Nil)))) -> value
| _ -> raise X_this_should_not_happen)
get_special_vars) in

 let get_sets = (List.map (fun binding -> 
match binding with 
| (Pair (Symbol(name), Pair (value, Pair(Symbol(name_changed), Nil)))) -> Pair(Symbol "set!", Pair(Symbol(name), Pair(Symbol(name_changed), Nil)))
| _ -> raise X_this_should_not_happen) get_special_vars) in

(tag_parse_expression (Pair(Pair(Symbol "lambda", Pair((list_to_proper_list get_vars), 
Pair(Pair(Symbol "begin", (list_to_proper_list get_sets)), Nil))), 
(list_to_proper_list get_values))))



(* QuasiQuote *)
and parse_quasiquote exprs = 
let parsed_quasiquote = 
match exprs with 
| Pair(Symbol "unquote", Pair(sexpr, Nil)) -> (sexpr)

| Pair(Symbol "unquote-splicing", cdr) -> raise X_no_match

| Nil -> Pair(Symbol("quote"), Pair(Nil, Nil))

| Symbol(sym) as symbol -> Pair(Symbol("quote"), Pair(symbol, Nil))

| Pair(car, cdr) ->
    (match car, cdr with
      | (Pair(Symbol("unquote-splicing"), Pair(sexpr, Nil)), something) ->
          (Pair(Symbol "append", Pair(sexpr, Pair((parse_quasiquote cdr), Nil))))
      | (something, Pair(Symbol("unquote-splicing"), Pair(sexpr, Nil))) -> 
          Pair(Symbol "cons", Pair((parse_quasiquote car), Pair(sexpr, Nil)))
      | something_car, something_cdr -> (Pair(Symbol "cons", Pair((parse_quasiquote car), Pair((parse_quasiquote cdr), Nil)))))
| _ -> exprs in 
(parsed_quasiquote)

(* Let Expr *)
and parse_let bindings body = 
let get_vars = (List.map (fun binding -> 
match binding with 
| (Pair (name, Pair (value, Nil))) -> name
|_ -> raise X_this_should_not_happen) (nested_pairs_to_list bindings)) in 
let get_values = (List.map (fun binding -> 
match binding with 
| (Pair (name, Pair (value, Nil))) -> (tag_parse_expression value)
| _ -> raise X_this_should_not_happen) (nested_pairs_to_list bindings)) in 
Applic(tag_parse_expression (Pair(Symbol("lambda"), Pair(list_to_proper_list get_vars, body))), get_values)


(* Let* Expr *)
and parse_let_star bindings body = 
let parsed_let_star = 
(match bindings with
| Nil -> (Pair(Symbol "let", Pair(Nil, body)))
| Pair(car, Nil) -> (Pair(Symbol "let", Pair(Pair(car, Nil), body)))
| Pair(car, cdr) -> (Pair(Symbol "let", Pair(Pair(car, Nil), Pair((parse_let_star cdr body), Nil))))
| _ -> raise X_this_should_not_happen) in 
(parsed_let_star) 


(* LetRec Expr *)
and parse_let_rec bindings body = 
let get_bindings_to_list = (nested_pairs_to_list bindings) in 
let get_vars = (List.map (fun binding -> 
match binding with 
| (Pair (name, Pair (value, Nil))) -> (Pair (name, Pair (Pair(Symbol "quote", Pair(Symbol "whatever", Nil)), Nil))) 
|_ -> raise X_this_should_not_happen) get_bindings_to_list) in 
let create_sets_exprs = (List.map (fun binding -> 
(Pair(Symbol "set!", binding))) get_bindings_to_list) in 
(tag_parse_expression (Pair(Symbol "let", Pair((list_to_proper_list get_vars), (list_to_proper_list (List.append create_sets_exprs  (nested_pairs_to_list body)))))))

let tag_parse_expressions sexpr = (List.map (fun expr -> tag_parse_expression expr) sexpr)

end;; (* struct Tag_Parser *)

open Tag_Parser;;