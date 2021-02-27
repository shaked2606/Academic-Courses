#use "tag-parser.ml";;

open PC;;
open Reader;;
open Tag_Parser;;

type var = 
  | VarFree of string
  | VarParam of string * int
  | VarBound of string * int * int;;

type expr' =
  | Const' of constant
  | Var' of var
  | Box' of var
  | BoxGet' of var
  | BoxSet' of var * expr'
  | If' of expr' * expr' * expr'
  | Seq' of expr' list
  | Set' of var * expr'
  | Def' of var * expr'
  | Or' of expr' list
  | LambdaSimple' of string list * expr'
  | LambdaOpt' of string list * string * expr'
  | Applic' of expr' * (expr' list)
  | ApplicTP' of expr' * (expr' list);;

let rec expr'_eq e1 e2 =
  match e1, e2 with
  | Const' Void, Const' Void -> true
  | Const'(Sexpr s1), Const'(Sexpr s2) -> sexpr_eq s1 s2
  | Var'(VarFree v1), Var'(VarFree v2) -> String.equal v1 v2
  | Var'(VarParam (v1,mn1)), Var'(VarParam (v2,mn2)) -> String.equal v1 v2 && mn1 = mn2
  | Var'(VarBound (v1,mj1,mn1)), Var'(VarBound (v2,mj2,mn2)) -> String.equal v1 v2 && mj1 = mj2  && mn1 = mn2
  | Box'(VarFree v1), Box'(VarFree v2) -> String.equal v1 v2
  | Box'(VarParam (v1,mn1)), Box'(VarParam (v2,mn2)) -> String.equal v1 v2 && mn1 = mn2
  | Box'(VarBound (v1,mj1,mn1)), Box'(VarBound (v2,mj2,mn2)) -> String.equal v1 v2 && mj1 = mj2  && mn1 = mn2
  | BoxGet'(VarFree v1), BoxGet'(VarFree v2) -> String.equal v1 v2
  | BoxGet'(VarParam (v1,mn1)), BoxGet'(VarParam (v2,mn2)) -> String.equal v1 v2 && mn1 = mn2
  | BoxGet'(VarBound (v1,mj1,mn1)), BoxGet'(VarBound (v2,mj2,mn2)) -> String.equal v1 v2 && mj1 = mj2  && mn1 = mn2
  | BoxSet'(VarFree v1,e1), BoxSet'(VarFree v2, e2) -> String.equal v1 v2 && (expr'_eq e1 e2)
  | BoxSet'(VarParam (v1,mn1), e1), BoxSet'(VarParam (v2,mn2),e2) -> String.equal v1 v2 && mn1 = mn2 && (expr'_eq e1 e2)
  | BoxSet'(VarBound (v1,mj1,mn1),e1), BoxSet'(VarBound (v2,mj2,mn2),e2) -> String.equal v1 v2 && mj1 = mj2  && mn1 = mn2 && (expr'_eq e1 e2)
  | If'(t1, th1, el1), If'(t2, th2, el2) -> (expr'_eq t1 t2) &&
                                            (expr'_eq th1 th2) &&
                                              (expr'_eq el1 el2)
  | (Seq'(l1), Seq'(l2)
  | Or'(l1), Or'(l2)) -> List.for_all2 expr'_eq l1 l2
  | (Set'(var1, val1), Set'(var2, val2)
  | Def'(var1, val1), Def'(var2, val2)) -> (expr'_eq (Var'(var1)) (Var'(var2))) &&
                                             (expr'_eq val1 val2)
  | LambdaSimple'(vars1, body1), LambdaSimple'(vars2, body2) ->
     (List.for_all2 String.equal vars1 vars2) &&
       (expr'_eq body1 body2)
  | LambdaOpt'(vars1, var1, body1), LambdaOpt'(vars2, var2, body2) ->
     (String.equal var1 var2) &&
       (List.for_all2 String.equal vars1 vars2) &&
         (expr'_eq body1 body2)
  | Applic'(e1, args1), Applic'(e2, args2)
  | ApplicTP'(e1, args1), ApplicTP'(e2, args2) ->
	 (expr'_eq e1 e2) &&
	   (List.for_all2 expr'_eq args1 args2)
  | _ -> false;;	
                      
exception X_syntax_error;;

module type SEMANTICS = sig
  val run_semantics : expr -> expr'
  val annotate_lexical_addresses : expr -> expr'
  val annotate_tail_calls : expr' -> expr'
  val box_set : expr' -> expr'
end;;

module Semantics : SEMANTICS = struct


let rec rec_annotate_lexical_addresses e plist blist = 
match e with
| Const(c) -> Const'(c)

| Var(v) -> 
  let is_exist = (List.mem v plist) in
  let find_element_in_plist = (find_minor_index v plist) in
  if (is_exist)
  then Var'(VarParam(v, find_element_in_plist))
  else (let major_index_of_element_in_blist = (find_major_index v blist) in
  if(major_index_of_element_in_blist != (-1))
  then Var'(VarBound(v, major_index_of_element_in_blist, (find_minor_index v (List.nth blist major_index_of_element_in_blist))))
  else Var'(VarFree(v)))

| If(test, dit, dif) -> If'((rec_annotate_lexical_addresses test plist blist),(rec_annotate_lexical_addresses dit plist blist),(rec_annotate_lexical_addresses dif plist blist))

| Seq(expr_list) -> Seq'((List.map (fun exprt -> (rec_annotate_lexical_addresses exprt plist blist)) expr_list))

| Set(v, expr) -> Set'((get_var_from_exprtag (rec_annotate_lexical_addresses v plist blist)), (rec_annotate_lexical_addresses expr plist blist))

| Def(v, expr) -> Def'((get_var_from_exprtag (rec_annotate_lexical_addresses v plist blist)), (rec_annotate_lexical_addresses expr plist blist))

| Or(expr_list) -> Or'((List.map (fun exprt -> (rec_annotate_lexical_addresses exprt plist blist)) expr_list))

| LambdaSimple(str_list, expr) -> LambdaSimple'(str_list, (rec_annotate_lexical_addresses expr str_list (List.append [plist] blist)))

| LambdaOpt(str_list, str, expr) -> LambdaOpt'(str_list, str, (rec_annotate_lexical_addresses expr (List.append str_list [str]) (List.append [plist] blist)))

| Applic(expr, expr_list) -> Applic'((rec_annotate_lexical_addresses expr plist blist), (List.map (fun exprt -> (rec_annotate_lexical_addresses exprt plist blist)) expr_list))

and get_var_from_exprtag exprtag = 
match exprtag with 
| Var'(v) -> v 
| _ -> raise X_this_should_not_happen


and find_major_index var list = 
  let rec rec_find_major i list = 
  match list with 
  | [] -> -1
  | element :: rest -> 
      if (List.mem var element) 
      then i
      else (rec_find_major (i+1) rest) in 
  (rec_find_major 0 list)

and find_minor_index var list = 
  let rec rec_find_minor i list = 
  match list with
  | [] -> -1
  | element :: rest -> 
  if (String.equal var element)
  then i
  else (rec_find_minor (i+1) rest) in 
  (rec_find_minor 0 list);;



let rec rec_annotate_tail_calls e is_tp = 
match e with
  | If'(test, dit, dif) -> If'((rec_annotate_tail_calls test false), (rec_annotate_tail_calls dit is_tp), (rec_annotate_tail_calls dif is_tp))
  | Seq'(expr_list) -> Seq'(List.append (List.map (fun exp -> (rec_annotate_tail_calls exp false)) (get_list_without_last_element expr_list)) [(rec_annotate_tail_calls (List.nth expr_list ((List.length expr_list)-1)) is_tp)])
  | Set'(v, expr) -> Set'(v, (rec_annotate_tail_calls expr false))
  | Def'(v, expr) -> Def'(v, (rec_annotate_tail_calls expr false))
  | Or'(expr_list) -> Or'(List.append (List.map (fun exp -> (rec_annotate_tail_calls exp false)) (get_list_without_last_element expr_list)) [(rec_annotate_tail_calls (List.nth expr_list ((List.length expr_list)-1)) is_tp)])
  | LambdaSimple'(varts, expr) -> LambdaSimple'(varts, (rec_annotate_tail_calls expr true))
  | LambdaOpt'(varts, vart, expr) -> LambdaOpt'(varts, vart, (rec_annotate_tail_calls expr true))
  | Applic'(expr, expr_list) -> 
    let check_if_applictp_or_not = 
    if (is_tp)
    then ApplicTP'((rec_annotate_tail_calls expr false), (List.map (fun expr -> (rec_annotate_tail_calls expr false)) expr_list))
    else Applic'((rec_annotate_tail_calls expr false), (List.map (fun expr -> (rec_annotate_tail_calls expr false)) expr_list)) in 
    (check_if_applictp_or_not)
  | _ -> e


and get_list_without_last_element lst = (List.rev (List.tl (List.rev lst)))
;;


(* Center Function of box that goes over the expression *)
let rec rec_box_set e = 
match e with 
| If'(test, dit, dif) -> If'((rec_box_set test), (rec_box_set dit), (rec_box_set dif))
| Seq'(expr_list) -> Seq'((List.map (fun expr -> (rec_box_set expr)) expr_list)) 
| Set'(v, expr) -> Set'(v, (rec_box_set expr))
| Def'(v, expr) -> Def'(v, (rec_box_set expr))
| Or'(expr_list) -> Or'((List.map (fun expr -> (rec_box_set expr)) expr_list))
| LambdaSimple'(vars, expr) -> (set_box_lambda vars e expr)
| LambdaOpt'(vars, var, expr) -> (set_box_lambda (List.append vars [var]) e expr)
| Applic'(expr, expr_list) -> Applic'((rec_box_set expr), (List.map (fun expr -> (rec_box_set expr)) expr_list))
| ApplicTP'(expr, expr_list) -> ApplicTP'((rec_box_set expr), (List.map (fun expr -> (rec_box_set expr)) expr_list))
| _ -> e

and get_list_without_last_element lst = (List.rev (List.tl (List.rev lst)))

(* goes over the parameters of lambda, and accumolate the vars which need to be boxed - box_get_and_set them, and return updated body of lambda *)
and set_box_lambda vars expr body = 
let vars_to_be_boxed_func = (List.fold_right (fun v lst ->
if((needs_to_be_boxed v expr body))
then (List.append [v] lst )
else lst)
 vars []) in 
match (vars_to_be_boxed_func) with 
| [] -> 
  let lambda_simple_or_lambda_opt_when_no_boxed_vars = 
  match expr with 
  | LambdaSimple'(varts, _) -> LambdaSimple'(varts,(rec_box_set body))
  | LambdaOpt'(varts, vart ,_ ) -> LambdaOpt'(varts, vart, (rec_box_set body))
  | _ -> raise X_no_match in
  (lambda_simple_or_lambda_opt_when_no_boxed_vars)
| vars_to_be_boxed -> 
  let boxing_set_get = (List.fold_right (fun v exp -> (box_get_and_set v exp)) vars_to_be_boxed body) in 
  let boxing_vars = (List.map (fun v -> (box_var v (find_minor_index v vars))) vars_to_be_boxed) in 
  let new_body = (List.append boxing_vars [(rec_box_set boxing_set_get)]) in
  let new_body = 
  match new_body with 
    | [] -> Const'(Void)
    | [element] -> element
    | element :: rest -> Seq'((List.flatten (List.map (fun expr -> 
      match expr with
      | Seq'(element) -> element
      | _ -> [expr]) (new_body)))) in 
  let build_lambda_simple_or_lambda_opt_when_boxed_vars = 
  match expr with 
  | LambdaSimple'(varts, _) -> LambdaSimple'(varts, new_body)
  | LambdaOpt'(varts, vart ,_ ) -> LambdaOpt'(varts, vart, new_body)
  | _ -> raise X_no_match in 
  (build_lambda_simple_or_lambda_opt_when_boxed_vars)



(* returns boolean if var need to be boxed in expression *)
and needs_to_be_boxed v expr body = 
let write_lambdas_lst = (find_write_occur v body expr false) in
let read_lambdas_lst = (find_read_occur v body expr false) in
let is_boxing_needed = 
match write_lambdas_lst, read_lambdas_lst with
| _, [] -> false
| [], _ -> false
| _ -> (List.fold_right (fun write_lambda bool -> (bool || (List.exists (fun read_lambda -> ((not (is_ordered v expr read_lambda write_lambda)) && (read_lambda != write_lambda)))) read_lambdas_lst)) write_lambdas_lst false) in 
(is_boxing_needed)


and find_write_occur v expr owner_lambda is_bound =
match expr with 
| If'(test, dit, dif) -> 
  let if_write_occur = (List.append (List.append (find_write_occur v test owner_lambda is_bound) (find_write_occur v dit owner_lambda is_bound)) (find_write_occur v dif owner_lambda is_bound)) in
  (if_write_occur)

| Seq'(expr_list) -> (concat_map (fun exp -> (find_write_occur v exp owner_lambda is_bound)) expr_list)
| Or'(expr_list) -> (concat_map(fun exp -> (find_write_occur v exp owner_lambda is_bound)) expr_list)

| Set'(VarBound(var, _, _), expr) | Set'(VarParam(var, _), expr) when (String.equal var v) -> [owner_lambda]
| Set'(_, exp) -> (find_write_occur v exp owner_lambda is_bound)
| Def'(var, exp) -> (find_write_occur v exp owner_lambda is_bound)

| LambdaSimple'(vars, body) when (List.exists (fun var -> (String.equal var v)) vars) -> [] (* v is parameter in inner lambda *)
| LambdaSimple'(vars, body) when is_bound -> (find_write_occur v body owner_lambda is_bound)   (* this is the first nested lambda *)
| LambdaSimple'(vars, body) -> (find_write_occur v body expr true) (* v is bound variable so we need to take the nested lambda*)

| LambdaOpt'(vars, var, body) when (List.exists (fun var -> (String.equal var v)) (List.append vars [var])) -> [] (* v is parameter in inner lambda *)
| LambdaOpt'(vars, var, body) when is_bound -> (find_write_occur v body owner_lambda is_bound)  (* this is the first nested lambda *)
| LambdaOpt'(vars, var, body) -> (find_write_occur v body expr true) (* v is bound variable so we need to take the nested lambda*)


| Applic'(expr, expr_list) -> (List.append (find_write_occur v expr owner_lambda is_bound) (concat_map (fun exp -> (find_write_occur v exp owner_lambda is_bound)) expr_list))
| ApplicTP'(expr, expr_list) -> (List.append (find_write_occur v expr owner_lambda is_bound) (concat_map (fun exp -> (find_write_occur v exp owner_lambda is_bound)) expr_list))
| _ -> []


and find_read_occur v expr owner_lambda is_bound =
match expr with 
| (Var'(VarBound(var, _, _)) | Var'(VarParam(var, _))) when (String.equal var v) -> [owner_lambda]
| If'(test, dit, dif) -> 
  let if_read_occur = (List.append (List.append (find_read_occur v test owner_lambda is_bound) (find_read_occur v dit owner_lambda is_bound)) (find_read_occur v dif owner_lambda is_bound)) in
  (if_read_occur)
| Seq'(expr_list) -> (concat_map (fun exp -> (find_read_occur v exp owner_lambda is_bound)) expr_list)
| Or'(expr_list) -> (concat_map (fun exp -> (find_read_occur v exp owner_lambda is_bound)) expr_list)

| Set'(var, exp) -> (find_read_occur v exp owner_lambda is_bound)
| Def'(var, exp) -> (find_read_occur v exp owner_lambda is_bound)

| LambdaSimple'(vars, body) when (List.exists (fun var -> (String.equal var v)) vars) -> [] (* v is parameter in inner lambda *)
| LambdaSimple'(vars, body) when is_bound -> (find_read_occur v body owner_lambda is_bound)   (* this is the first nested lambda *)
| LambdaSimple'(vars, body) -> (find_read_occur v body expr true) (* v is bound variable so we need to take the nested lambda*)

| LambdaOpt'(vars, var, body) when (List.exists (fun var -> (String.equal var v)) (List.append vars [var])) -> [] (* v is parameter in inner lambda *)
| LambdaOpt'(vars, var, body) when is_bound -> (find_read_occur v body owner_lambda is_bound)  (* this is the first nested lambda *)
| LambdaOpt'(vars, var, body) -> (find_read_occur v body expr true) (* v is bound variable so we need to take the nested lambda*)

| Applic'(expr, expr_list) -> (List.append (find_read_occur v expr owner_lambda is_bound) (concat_map (fun exp -> (find_read_occur v exp owner_lambda is_bound)) expr_list))
| ApplicTP'(expr, expr_list) -> (List.append (find_read_occur v expr owner_lambda is_bound) (concat_map (fun exp -> (find_read_occur v exp owner_lambda is_bound)) expr_list))
| _ -> []


and box_var v minor = Set'(VarParam(v, minor), Box'(VarParam(v, minor)))

and box_get_and_set v expr = 
match expr with 
| (Var'(VarBound(var, _, _)as vart)) | (Var'(VarParam(var, _) as vart)) when (String.equal var v) -> BoxGet'(vart)
| Set'((VarBound(var, _, _) as vart), exp) | Set'((VarParam(var, _) as vart), exp) when (String.equal var v) -> BoxSet'(vart, (box_get_and_set v exp))
| Set'(var, expr) -> Set'(var, (box_get_and_set v expr))
| BoxSet'(var, expr) -> BoxSet'(var, (box_get_and_set v expr))
| Def'(var, expr) -> Def'(var, (box_get_and_set v expr))

| If'(test, dit, dif) -> If'((box_get_and_set v test), (box_get_and_set v dit), (box_get_and_set v dif))

| Seq'(expr_list) -> Seq'((List.map (fun expr -> (box_get_and_set v expr)) expr_list)) 
| Or'(expr_list) -> Or'((List.map (fun expr -> (box_get_and_set v expr)) expr_list))

| LambdaSimple'(varts, expr) when not (List.mem v varts) -> LambdaSimple'(varts, (box_get_and_set v expr))
| LambdaOpt'(varts, vart, expr) when not (List.mem v (List.append varts [vart])) ->  LambdaOpt'(varts, vart, (box_get_and_set v expr))

| Applic'(expr, expr_list) -> Applic'((box_get_and_set v expr), (List.map (fun expr -> (box_get_and_set v expr)) expr_list))
| ApplicTP'(expr, expr_list) -> ApplicTP'((box_get_and_set v expr), (List.map (fun expr -> (box_get_and_set v expr)) expr_list))
| _ -> expr


and is_ordered var lambda read_owner write_owner =
if (read_owner == lambda) then (is_write_after_var_in_seq var lambda write_owner) else 
if (write_owner == lambda) then (is_read_after_var_in_seq var lambda read_owner) else false

and is_write_after_var_in_seq var lambda write_owner =
match lambda with
| LambdaOpt'(_, _, Seq'(exprs)) | LambdaSimple'(_, Seq'(exprs)) -> 
let read_index = find_var_param var exprs in
let write_index = find_expr_in_exprs write_owner exprs in
if(read_index == (-1))
then false
else write_index > read_index
| _ -> false

and is_read_after_var_in_seq var lambda read_owner = 
match lambda with
| LambdaOpt'(_, _, Seq'(exprs)) | LambdaSimple'(_, Seq'(exprs)) -> 
let write_index = find_var_param_set var exprs in
let read_index = find_expr_in_exprs read_owner exprs in
if(write_index == (-1))
then false
else read_index > write_index
| _ -> false

and find_expr_in_exprs expr_to_find exprs = 
let rec find exprs index =
match exprs with
| [] -> -1
| expr :: exprs when expr = expr_to_find -> index
| _ :: exprs -> find exprs (index+1) in
(find exprs 0)

and find_var_param_set var exprs = 
let rec find exprs index =
match exprs with
| [] -> -1
| (Set'(VarParam(x, _), _)) :: exprs when x = var -> index
| _ :: exprs -> find exprs (index+1) in
(find exprs 0)

and find_var_param var exprs = 
let rec find exprs index =
match exprs with
| [] -> -1
| (Var'(VarParam(x, _))) :: exprs when x = var -> index
| _ :: exprs -> find exprs (index+1) in
(find exprs 0)


and concat_map func list = (List.concat (List.map func list))
;;


let annotate_lexical_addresses e = (rec_annotate_lexical_addresses e [] []);;

let annotate_tail_calls e = (rec_annotate_tail_calls e false);;

let box_set e = (rec_box_set e);;

let run_semantics expr =
  box_set
    (annotate_tail_calls
       (annotate_lexical_addresses expr));;
  
end;; (* struct Semantics *)

open Semantics;;
