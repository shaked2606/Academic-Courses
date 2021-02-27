#use "semantic-analyser.ml";;

(* This module is here for you convenience only!
   You are not required to use it.
   you are allowed to change it. *)
module type CODE_GEN = sig
  (* This signature assumes the structure of the constants table is
     a list of key-value pairs:
     - The keys are constant values (Sexpr(x) or Void)
     - The values are pairs of:
       * the offset from the base const_table address in bytes; and
       * a string containing the byte representation (or a sequence of nasm macros)
         of the constant value
     For example: [(Sexpr(Nil), (1, "T_NIL"))]
   *)
  val make_consts_tbl : expr' list -> (constant * (int * string)) list

  (* This signature assumes the structure of the fvars table is
     a list of key-value pairs:
     - The keys are the fvar names as strings
     - The values are the offsets from the base fvars_table address in bytes
     For example: [("boolean?", 0)]
   *)  
  val make_fvars_tbl : expr' list -> (string * int) list

  (* If you change the types of the constants and fvars tables, you will have to update
     this signature to match: The first argument is the constants table type, the second 
     argument is the fvars table type, and the third is an expr' that has been annotated 
     by the semantic analyser.
   *)
  val generate : (constant * (int * string)) list -> (string * int) list -> expr' -> string
end;;

module Code_Gen : CODE_GEN = struct
  let rec remove_duplicates lst = 
  match lst with 
  | [] -> []
  | element :: rest -> 
  if (List.exists ((=) element) rest) then (remove_duplicates rest)
  else (List.append [element] (remove_duplicates rest))

 let get_list_without_last_element lst = (List.rev (List.tl (List.rev lst)))

  let symbol_to_string sym =
  (String sym)

  let string_to_ascii_list str =
    let chars = (string_to_list str) in
    let asciis = List.map Char.code chars in
    let ascii_strs = List.map (Printf.sprintf "%d") asciis in
    String.concat ", "ascii_strs;;


  let rec make_list_of_constants exprt lst = 
  match exprt with
  | Const'(Sexpr(Nil)) | Const'(Sexpr(Bool(_))) -> []
  | Const'(Sexpr(_) as c) -> [c]
  | BoxSet'(_, exprt) -> (make_list_of_constants exprt lst)
  | If'(test, dit, dif) -> (List.append (make_list_of_constants test lst) (List.append (make_list_of_constants dit lst) (make_list_of_constants dif lst)))
  | Seq'(exprt_list) -> (List.flatten (List.map (fun exprt -> (make_list_of_constants exprt lst)) exprt_list))
  | Set'(_, exprt) -> (make_list_of_constants exprt lst)
  | Def'(_, exprt) -> (make_list_of_constants exprt lst)
  | Or'(exprt_list) -> (List.flatten (List.map (fun exprt -> (make_list_of_constants exprt lst)) exprt_list))
  | LambdaSimple'(_, exprt) -> (make_list_of_constants exprt lst)
  | LambdaOpt'(_, _, exprt) -> (make_list_of_constants exprt lst)
  | Applic'(exprt, exprt_list) | ApplicTP'(exprt, exprt_list) -> (List.append (make_list_of_constants exprt lst) (List.flatten (List.map (fun exprt -> (make_list_of_constants exprt lst)) exprt_list)))
  | _ -> []


let rec make_sub_constants_from_constant const lst = 
match const with
| Sexpr(Number(_)) as const -> [const]
| Sexpr(Char(_)) as const -> [const]
| Sexpr(String(_)) as const -> [const]
| Sexpr(Symbol(sym)) as const -> [Sexpr((symbol_to_string sym)); const] 
| Sexpr(Pair(car, cdr)) as const -> (List.append (make_sub_constants_from_constant (Sexpr car) lst) (List.append (make_sub_constants_from_constant (Sexpr cdr) lst) [const]))
| _ -> []


let compute_offset_of_constant const = 
match const with 
| Void -> 1
| Sexpr(Nil) -> 1
| Sexpr(Bool(false)) -> 2
| Sexpr(Bool(true)) -> 2
| Sexpr(Char(_)) -> 2
| Sexpr(Number(Fraction(_,_))) -> 17
| Sexpr(Number(Float(_))) -> 9
| Sexpr(String(str)) -> 9 + (String.length str)
| Sexpr(Symbol(_)) -> 9
| Sexpr(Pair(car, cdr)) -> 17

let rec compute_addresses_of_constant_list lst offset = 
match lst with 
| [] -> []
| element :: rest -> 
let new_offset = offset + (compute_offset_of_constant element) in 
(List.append [(element, offset)] 
(compute_addresses_of_constant_list rest new_offset))


let compute_representation_of_constant consts const = 
match const with 
| Void -> (Printf.sprintf "MAKE_VOID")
| Sexpr(Nil) -> (Printf.sprintf "MAKE_NIL")
| Sexpr(Bool(false)) -> (Printf.sprintf "MAKE_BOOL(0)")
| Sexpr(Bool(true)) -> (Printf.sprintf "MAKE_BOOL(1)")
| Sexpr(Char(c)) -> (Printf.sprintf "MAKE_LITERAL_CHAR(%d)" (int_of_char c))
| Sexpr(Number(Fraction(num, den))) -> (Printf.sprintf "MAKE_LITERAL_RATIONAL(%d, %d)" num den)
| Sexpr(Number(Float(fl))) -> (Printf.sprintf "MAKE_LITERAL_FLOAT(%f)" fl)
| Sexpr(String(str)) -> 
  let string_to_char_list = (string_to_ascii_list str) in 
  let string_list = (string_to_list str) in
  let check_if_empty_list = (List.length string_list) in 
  let sprintf_string = 
  (match check_if_empty_list with 
  | 0 -> (Printf.sprintf "MAKE_LITERAL_STRING '%s'" str)
  | _ -> (Printf.sprintf "MAKE_LITERAL_STRING %s" string_to_char_list)) in 
  (sprintf_string)
| Sexpr(Symbol(sym)) -> (Printf.sprintf "MAKE_LITERAL_SYMBOL(const_tbl + %d)" (List.assoc (Sexpr(String(sym))) consts))
| Sexpr(Pair(car, cdr)) -> (Printf.sprintf "MAKE_LITERAL_PAIR(const_tbl + %d, const_tbl + %d)" (List.assoc (Sexpr car) consts) (List.assoc (Sexpr cdr) consts))


let create_consts_table lst = 
let lst1 = lst in 
(List.map (fun (sexpr, offset) -> (sexpr, (offset, (compute_representation_of_constant lst1 sexpr)))) lst)

  let make_constants_table asts = 
    let mandatory_constants = [Void; Sexpr(Nil); Sexpr(Bool(false)); Sexpr(Bool(true))]  in 
    let list_of_constants = (List.flatten (List.map (fun exprt -> (make_list_of_constants exprt [])) asts)) in 
    let remove_duplicates_from_list_of_constants = (remove_duplicates list_of_constants) in 
    let list_sorted_topologically = (List.flatten (List.map (fun const -> make_sub_constants_from_constant const []) remove_duplicates_from_list_of_constants)) in 
    let remove_again_duplictaed_from_list_of_constants = (remove_duplicates list_sorted_topologically) in
    let list_with_mandatory_constants = (List.append mandatory_constants remove_again_duplictaed_from_list_of_constants) in
    let add_addresses_to_constants_list = (compute_addresses_of_constant_list list_with_mandatory_constants 0) in 
    (create_consts_table add_addresses_to_constants_list)


  let make_consts_tbl asts = (make_constants_table asts);;

  let rec get_address_from_constant_table consts const = 
  match consts with
  | [] -> raise X_this_should_not_happen
  | (constant, (offset, representation)) :: rest -> 
    if (expr'_eq (Const'(constant)) (Const'(const))) then offset
    else (get_address_from_constant_table rest const)


  let rec get_type_from_constant_table consts const = 
  match consts with
  | [] -> raise X_this_should_not_happen
  | (constant, (offset, representation)) :: rest -> 
    if (expr'_eq (Const'(constant)) (Const'(const))) then representation
    else (get_type_from_constant_table rest const)


  let rec make_list_of_fvars exprt lst = 
  match exprt with
  | Var'(VarFree(v)) -> [v]
  | Box'(VarFree(v)) -> [v]
  | BoxGet'(VarFree(v)) -> [v]
  | BoxSet'(VarFree(v), exprt) -> (List.append [v] (make_list_of_fvars exprt lst))
  | If'(test, dit, dif) -> (List.append (make_list_of_fvars test lst) (List.append (make_list_of_fvars dit lst) (make_list_of_fvars dif lst)))
  | Seq'(exprt_list) -> (List.flatten (List.map (fun exprt -> (make_list_of_fvars exprt lst)) exprt_list))
  | Set'(VarFree(v), exprt) -> (List.append [v] (make_list_of_fvars exprt lst))
  | Def'(VarFree(v), exprt) -> (List.append [v] (make_list_of_fvars exprt lst))
  | Or'(exprt_list) -> (List.flatten (List.map (fun exprt -> (make_list_of_fvars exprt lst)) exprt_list))
  | LambdaSimple'(_, exprt) -> (make_list_of_fvars exprt lst)
  | LambdaOpt'(_, _, exprt) -> (make_list_of_fvars exprt lst)
  | Applic'(exprt, exprt_list) | ApplicTP'(exprt, exprt_list) -> (List.append (make_list_of_fvars exprt lst) (List.flatten (List.map (fun exprt -> (make_list_of_fvars exprt lst)) exprt_list)))
  | _ -> []


  let make_fvars_tbl asts =  
  let list_of_fvars = (List.flatten (List.map (fun exprt -> (make_list_of_fvars exprt [])) asts)) in 
  let fvars =
  (* Type queries  *)
  ["boolean?", "boolean?";  "flonum?", "flonum?"; "rational?", "rational?";
  "pair?", "pair?"; "null?", "null?"; "char?", "char?"; "string?", "string?";
  "procedure?", "procedure?"; "symbol?", "symbol?";
  (* String procedures *)
  "string-length", "string_length"; "string-ref", "string_ref"; "string-set!", "string_set";
  "make-string", "make_string"; "symbol->string", "symbol_to_string";
  (* Type conversions *)
  "char->integer", "char_to_integer"; "integer->char", "integer_to_char"; "exact->inexact", "exact_to_inexact";
  (* Identity test *)
  "eq?", "eq?";
  (* Arithmetic ops *)
  "+", "add"; "*", "mul"; "/", "div"; "=", "eq"; "<", "lt";
  (* Additional rational numebr ops *)
  "numerator", "numerator"; "denominator", "denominator"; "gcd", "gcd";
  (* you can add yours here *) 
  "car", "car"; "cdr", "cdr"; "cons", "cons"; "set-car!", "set_car"; "set-cdr!", "set_cdr"; "apply", "apply";  
  ] in 
  let take_only_name = (List.map (fun (name, label) -> name) fvars) in 
  let full_fvars_tbl = (List.append take_only_name list_of_fvars) in
  let fvars_with_no_duplicates = (remove_duplicates full_fvars_tbl) in 
  let build_fvars_tbl = (List.mapi (fun i var -> (var, i*8)) fvars_with_no_duplicates) in 
  (build_fvars_tbl);;


let counter () = let count = ref 0 in fun () -> count := (!count) + 1; !count;;
let lexit = counter()
let lelse = counter()
let lcont = counter()
let lcode = counter()
let lextenv = counter()
let lparamsenv = counter()
let lshrinkframe = counter()
let lshiftframe = counter()
let lapplictp = counter()
let lnothingtodo = counter()

  let rec rec_generate consts fvars e lambda_counter = 
  match e with
  | Const'(c) -> 
    let address = (get_address_from_constant_table consts c) in 
      (Printf.sprintf "; DEBUG: Constant from type: %s
                        mov rax, const_tbl + %d" (get_type_from_constant_table consts c) address)
  | Var'(VarParam(v, minor)) -> 
    (Printf.sprintf "; DEBUG: VarParam: %s
                      mov rax, qword [rbp + 8 * (4 + %d)]" v minor) 
  | Var'(VarFree(v)) -> 
    (Printf.sprintf "; DEBUG: VarFree: %s
                      mov rax, qword [fvar_tbl + %d]" v (List.assoc v fvars))
  | Var'(VarBound(v, major, minor)) ->
        (Printf.sprintf "; DEBUG: VarBound: %s
                        mov rax, qword [rbp + 8 * 2]
                        mov rax, qword [rax + 8 * %d]
                        mov rax, qword [rax + 8 * %d]" v major minor)
  | Set'(VarParam(v, minor), exprt) -> 
    let generate_exprt = (rec_generate consts fvars exprt lambda_counter) in 
    (Printf.sprintf "; DEBUG: Set'(VarParam(%s))
                        %s
                        mov qword [rbp + 8 * (4 + %d)], rax
                        mov rax, SOB_VOID_ADDRESS" v generate_exprt minor) 
  | Set'(VarBound(v, major, minor), exprt) -> 
    let generate_exprt = (rec_generate consts fvars exprt lambda_counter) in 
    (Printf.sprintf "; DEBUG: Set'(Var'(VarBound(%s)))
                        %s
                        mov rbx, qword [rbp + 8 * 2]
                        mov rbx, qword [rbx + 8 * %d]
                        mov qword [rbx + 8 * %d], rax
                        mov rax, SOB_VOID_ADDRESS" v generate_exprt major minor) 
  | Set'(VarFree(v), exprt) | Def'(VarFree(v), exprt) ->
    let generate_exprt = (rec_generate consts fvars exprt lambda_counter) in 
     (Printf.sprintf "; DEBUG: Set'(VarFree(%s)) | Def'(VarFree(%s))
                        %s
                        mov qword [fvar_tbl + %d], rax
                        mov rax, SOB_VOID_ADDRESS" v v generate_exprt (List.assoc v fvars)) 
  | Box'(v) -> 
  let generate_var = (rec_generate consts fvars (Var' v) lambda_counter) in
  (Printf.sprintf "; DEBUG: Box'(v)
                  %s
                  MALLOC rdx, WORD_SIZE
                  mov [rdx], rax
                  mov rax, rdx" generate_var)
  | BoxGet'(v) -> 
    let generate_vart = (rec_generate consts fvars (Var' v) lambda_counter) in 
    (Printf.sprintf "; DEBUG: BoxGet'(Var'()
                        %s
                        mov rax, qword [rax]" generate_vart) 
  | BoxSet'(v, exprt) -> 
    let generate_exprt = (rec_generate consts fvars exprt lambda_counter) in 
    let generate_vart = (rec_generate consts fvars (Var' v)  lambda_counter) in 
    (Printf.sprintf "; DEBUG: BoxSet'(Var'())
                        %s
                        push rax
                        %s
                        pop qword [rax]
                        mov rax, SOB_VOID_ADDRESS" generate_exprt generate_vart) 
  | If'(test, dit, dif) -> 
    let generate_test = (rec_generate consts fvars test lambda_counter) in
    let generate_dit = (rec_generate consts fvars dit lambda_counter) in
    let generate_dif = (rec_generate consts fvars dif lambda_counter) in
    let label_else = lelse() in
    let label_exit = lexit() in
    (Printf.sprintf "; DEBUG: IF
                      %s
                      cmp rax, SOB_FALSE_ADDRESS
                      je Lelse%d
                      %s
                      jmp Lexit%d
                      Lelse%d:
                      %s
                      Lexit%d:"
                      generate_test label_else generate_dit label_exit label_else generate_dif label_exit)
  | Seq'(exprt_list) ->
    let generated_seq = (String.concat "" (List.map (fun exprt -> 
    (rec_generate consts fvars exprt lambda_counter)) exprt_list)) in
    (Printf.sprintf "; DEBUG: SEQ
                      %s" generated_seq)
  | Or'(exprt_list) -> 
    let label_exit = lexit() in 
    let generate_or_except_last_exprt = (String.concat "" 
        (List.map (fun exprt -> 
        (Printf.sprintf "%s
                        cmp rax, SOB_FALSE_ADDRESS
                        jne Lexit%d"
                        (rec_generate consts fvars exprt lambda_counter) label_exit)) (get_list_without_last_element exprt_list))) in
    let last_exprt_from_exprt_list = (List.nth exprt_list ((List.length exprt_list)-1)) in 
    let generate_last_exprt = (rec_generate consts fvars last_exprt_from_exprt_list lambda_counter) in 
    (Printf.sprintf "; DEBUG: OR
                      %s
                      %s
                      Lexit%d:" generate_or_except_last_exprt generate_last_exprt label_exit)
  | LambdaSimple'(params, body) -> 
    let label_cont = lcont() in 
    let label_code = lcode() in 
    let label_copy_old_env = lextenv() in
    let label_paramsenv = lparamsenv() in 
    let label_nothing_to_do = lnothingtodo() in
    let generate_body = (rec_generate consts fvars body (lambda_counter + 1)) in
    (Printf.sprintf "; DEBUG: LAMBDASIMPLE
                      ; Allocate ExtEnv - NewExtEnv + OldExtEnvs
                      mov r8, 0
                      lea r8, [%d * WORD_SIZE] ; r8 = |Env+1| * WORD_SIZE
                      MALLOC rbx, r8 
                      mov qword [rbx], SOB_NIL_ADDRESS

                      ; rbx = points to the ExtEnv

                      mov rcx, %d                 ; number of nested lambdas - |Env|
                      cmp rcx, 0                  ; if there are no Old Envs, we do nothing (just dummy frame exist)
                      je Nothing_To_Do%d

                      ; Get lexical Address of OldEnv
                      mov r9, qword [rbp + 2 * WORD_SIZE] ; r9 = old lex env of frame

                      ; Init Counters for loop - ExtEnv[i+1] = OldEnv[i]
                      mov rcx, 0 
                      mov r11, 0

                      ; Copy pointers of minor vectors from Env to ExtEnv
                      CopyOldEnv%d:
                      mov r11, qword [r9 + WORD_SIZE * rcx]           ; copy from OldEnv[i]
                      inc rcx
                      mov qword [rbx + WORD_SIZE * rcx], r11          ; copy to ExtEnv[i+1]
                      cmp rcx, %d                                     ; if we got to number of nested_lambdas we finish
                      jne CopyOldEnv%d 

                      mov rdx, 0
                      mov rcx, 0
                      ; Get number of Params - |Params|
                      mov rdx, qword [rbp + 3 * WORD_SIZE] ; get n from stack   ; rdx = n argument
                      lea r9, [rdx * WORD_SIZE]
                      ; Init ExtEnv[0]
                      MALLOC rcx, r9
                      mov [rbx], rcx                                            ; copy space for params of frame
                      mov r10, rcx

                      ParamsEnv%d:
                      cmp rdx, 0
                      je Nothing_To_Do%d

                      mov r11, 0
                      mov rcx, 0
                      CopyParams%d:
                      mov r11, PVAR(rcx)
                      mov [r10 + rcx * WORD_SIZE], qword r11
                      inc rcx
                      cmp rcx, rdx
                      jne CopyParams%d
                      
                      Nothing_To_Do%d:
                      MAKE_CLOSURE(rax, rbx, Lcode%d)
                      jmp Lcont%d

                      Lcode%d:
                      push rbp
                      mov rbp, rsp
                      %s
                      leave
                      ret

                      Lcont%d:" (lambda_counter + 1) lambda_counter label_nothing_to_do label_copy_old_env lambda_counter label_copy_old_env
                      label_paramsenv label_nothing_to_do label_paramsenv label_paramsenv label_nothing_to_do label_code label_cont 
                      
                      label_code generate_body label_cont)
  | LambdaOpt'(params, param, body) -> 
    let label_cont = lcont() in 
    let label_code = lcode() in 
    let label_exit = lexit() in 
    let label_copy_old_env = lextenv() in
    let label_paramsenv = lparamsenv() in 
    let label_nothing_to_do = lnothingtodo() in
    let label_shrink_frame = lshrinkframe() in 
    let label_shift_frame = lshiftframe() in
    let number_of_params = (List.length params) in
    let generate_body = (rec_generate consts fvars body (lambda_counter + 1)) in
    (Printf.sprintf "; DEBUG: LAMBDAOPT
                      ; Allocate ExtEnv - NewExtEnv + OldExtEnvs
                      mov r8, 0
                      lea r8, [%d * WORD_SIZE] ; r8 = |Env+1| * WORD_SIZE
                      MALLOC rbx, r8 
                      mov qword [rbx], SOB_NIL_ADDRESS

                      ; rbx = points to the ExtEnv

                      mov rcx, %d                 ; number of nested lambdas - |Env|
                      cmp rcx, 0                  ; if there are no Old Envs, we do nothing (just dummy frame exist)
                      je Nothing_To_Do%d

                      ; Get lexical Address of OldEnv
                      mov r9, qword [rbp + 2 * WORD_SIZE] ; r9 = old lex env of frame

                      ; Init Counters for loop - ExtEnv[i+1] = OldEnv[i]
                      mov rcx, 0 
                      mov r11, 0

                      ; Copy pointers of minor vectors from Env to ExtEnv
                      CopyOldEnv%d:
                      mov r11, qword [r9 + WORD_SIZE * rcx]           ; copy from OldEnv[i]
                      inc rcx
                      mov qword [rbx + WORD_SIZE * rcx], r11          ; copy to ExtEnv[i+1]
                      cmp rcx, %d                                     ; if we got to number of nested_lambdas we finish
                      jne CopyOldEnv%d 

                      mov rdx, 0
                      mov rcx, 0
                      ; Get number of Params - |Params|
                      mov rdx, qword [rbp + 3 * WORD_SIZE] ; get n from stack   ; rdx = n argument
                      lea r9, [rdx * WORD_SIZE]
                      ; Init ExtEnv[0]
                      MALLOC rcx, r9
                      mov [rbx], rcx                                            ; copy space for params of frame
                      mov r10, rcx

                      ParamsEnv%d:
                      cmp rdx, 0
                      je Nothing_To_Do%d

                      mov r11, 0
                      mov rcx, 0
                      CopyParams%d:
                      mov r11, PVAR(rcx)
                      mov qword [r10 + rcx * WORD_SIZE], r11
                      inc rcx
                      cmp rcx, rdx
                      jne CopyParams%d
                      
                      Nothing_To_Do%d:
                      MAKE_CLOSURE(rax, rbx, Lcode%d)
                      jmp Lcont%d

                      Lcode%d:
                      ; r12 = saves the needed params from lambda object
                      mov r12, 0
                      mov r12, %d                            ; saving number of Params from lambda object (excluding opt argument)
                      mov rbx, [rsp + WORD_SIZE * 2]         ; Get number of Params on stack including magic
                      dec rbx                                ; excludes magic
                      ; Checking if there are optional arguments
                      cmp rbx, r12 ; rbx = number of params on stack frame (excluding magic), we compare with needed params in lambda object
                      je End_Of_LambdaOpt%d ; The number of the params is equal to the number on stack frame (including magic), so we need do nothing
                      ; Shrink Frame Because there are optional arguments on stack
                      add qword r12, 3                       ; ret, env, n. in r12 we have already needed params
                      
                      lea r14, [rsp + WORD_SIZE * r12]       ; get pointer to the start of optional arguments

                      mov r9, 3
                      add r9, qword [rsp + WORD_SIZE * 2]
                      sub r9, 2                              ; sub magic and points to the optional list place
                      lea r9, [r9 * WORD_SIZE]
                      mov r13, rsp
                      add r13, r9

                      mov r10, SOB_NIL_ADDRESS               ; init optional list
                      mov r8, 0                              ; r8 is for saving the car element
                      mov r9, 0                              ; r9 is for saving the cdr element

                      mov rcx, rbx                           ; rcx = all arguments in stack (excluding magic)

                      mov r11, %d                            ; r11 = all needed params in lambda object

                      ; go over the optional arguments from last to first and make optional list
                      Shrink_Frame%d:
                      mov r9, r10
                      dec rcx
                      cmp r11, rcx
                      jg End_Of_Shrink_Frame%d
                      mov r8, [rsp + WORD_SIZE * (3 + rcx)]
                      MAKE_PAIR(r10, r8, r9)
                      jmp Shrink_Frame%d

                      ; r10 = list of optional arguments
                      End_Of_Shrink_Frame%d:
                      add r11, 2                              ; add magic and optional list
                      mov [rsp + WORD_SIZE * 2], r11          ; update new n

                      mov qword [r13], r10                    ; push to stack the optional list

                      mov r11, 3                              ; ret, env, n
                      add r11, %d                             ; add needed params from lambda object

                      lea rcx, [rsp + WORD_SIZE * r11]

                      mov r12, 0
                      Shift_Frame%d:                          
                      cmp rcx, rsp
                      je End_Of_Shift_Frame%d
                      sub rcx, WORD_SIZE
                      sub r13, WORD_SIZE
                      mov r12, [rcx]
                      mov [r13], r12
                      jmp Shift_Frame%d

                      End_Of_Shift_Frame%d:
                      mov rsp, r13

                      End_Of_LambdaOpt%d:
                      push rbp
                      mov rbp, rsp
                      %s
                      leave
                      ret
                      Lcont%d:" (lambda_counter + 1) lambda_counter label_nothing_to_do label_copy_old_env lambda_counter label_copy_old_env
                      label_paramsenv label_nothing_to_do label_paramsenv label_paramsenv label_nothing_to_do label_code label_cont
                      label_code number_of_params label_exit number_of_params
                      label_shrink_frame label_shrink_frame label_shrink_frame label_shrink_frame number_of_params
                      label_shift_frame label_exit label_shift_frame label_exit
                      label_exit generate_body label_cont)
  | Applic'(proc, exprt_list) -> 
    let generate_proc = (rec_generate consts fvars proc lambda_counter) in 
    let reverse_list_of_exprt = (List.rev exprt_list) in
    let generate_list_of_args = (String.concat "" (List.map (fun exprt -> 
        (Printf.sprintf "%s
                          push rax"
                        (rec_generate consts fvars exprt lambda_counter))) reverse_list_of_exprt)) in
    (Printf.sprintf "; DEBUG: Applic
                    push SOB_NIL_ADDRESS ; for magic
                    %s
                    push %d
                    %s

                    CLOSURE_ENV rdx, rax
                    push rdx
                    CLOSURE_CODE rax, rax
                    call rax        

                    add rsp, WORD_SIZE * 1 ; pop env
                    pop rbx ; pop arg count
                    shl rbx, 3 ; rbx = rbx * 8
                    add rsp, rbx ; pop args"
                    generate_list_of_args ((List.length exprt_list) + 1) generate_proc)
  | ApplicTP'(proc, exprt_list) -> 
    let label_applictp = lapplictp() in 
    let generate_proc = (rec_generate consts fvars proc lambda_counter) in 
    let reverse_list_of_exprt = (List.rev exprt_list) in
    let generate_list_of_args = (String.concat "" (List.map (fun exprt -> 
        (Printf.sprintf "%s
                          push rax"
                        (rec_generate consts fvars exprt lambda_counter))) reverse_list_of_exprt)) in
        (Printf.sprintf "; DEBUG: ApplicTP
                        push SOB_NIL_ADDRESS ; for magic 
                        %s
                        push %d
                        %s

                        mov rdx, 0
                        CLOSURE_ENV rdx, rax                  ; env of proc
                        mov r8, 0
                        mov r8, rdx
                        push qword r8

                        mov r9, qword [rbp + WORD_SIZE * 1]   ; ret-address
                        push qword r9
                        mov rdx, qword [rbp]                  ; saving old_rbp

                        mov r9, qword [rbp + WORD_SIZE * 3]   ; get n from stack

                        mov r14, rbp
                        lea r14, [r14 + (r9 + 4) * WORD_SIZE]

                        ; set up the current frame with the new frame
                        ; Init counter loop
                        mov rcx, qword rbp                              ; set up rcx to rbp (top of prev frame)

                        ; Start of set up frame loop
                        mov r8, 0
                        Set_Up_Frame%d:
                        cmp rcx, rsp                                    ; check if we got to the top of the stack
                        jle Set_Up_Frame_Exit%d                         ; end of loop
                        sub rcx, WORD_SIZE                              ; sub rcx by WORD_SIZE
                        inc r8
                        mov rbx, qword [rcx]                            ; set rbx to be the [rcx] content
                        mov qword [rcx + (r9 + 4) * WORD_SIZE], rbx     ; do the set up
                        jmp Set_Up_Frame%d                              ; continue loop

                        Set_Up_Frame_Exit%d:
                        lea r8, [r8 * WORD_SIZE]
                        mov rbp, rdx                                  ; back to old_rbp   
                        mov rsp, r14        
                        sub rsp, r8                    

                        mov rdx, 0
                        CLOSURE_CODE rdx, rax
                        jmp rdx"
        generate_list_of_args ((List.length exprt_list) + 1) generate_proc label_applictp label_applictp label_applictp label_applictp)
  | _ -> raise X_this_should_not_happen
  
  let generate consts fvars e = (rec_generate consts fvars e 0)

end;;

open Code_Gen;;