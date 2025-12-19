type operator = Add | Subtract | Multiply | Divide | Modulo | Power

type token =
  | Number of float
  | Op of operator
  | LParen
  | RParen
  | EOF

(* Tokenize input string *)
let tokenize input =
  let rec tokenize_helper str pos tokens =
    if pos >= String.length str then
      List.rev (EOF :: tokens)
    else
      let c = str.[pos] in
      match c with
      | ' ' | '\t' | '\n' -> tokenize_helper str (pos + 1) tokens
      | '+' -> tokenize_helper str (pos + 1) (Op Add :: tokens)
      | '-' -> tokenize_helper str (pos + 1) (Op Subtract :: tokens)
      | '*' -> tokenize_helper str (pos + 1) (Op Multiply :: tokens)
      | '/' -> tokenize_helper str (pos + 1) (Op Divide :: tokens)
      | '%' -> tokenize_helper str (pos + 1) (Op Modulo :: tokens)
      | '^' -> tokenize_helper str (pos + 1) (Op Power :: tokens)
      | '(' -> tokenize_helper str (pos + 1) (LParen :: tokens)
      | ')' -> tokenize_helper str (pos + 1) (RParen :: tokens)
      | _ when c >= '0' && c <= '9' ->
          let rec get_number p acc =
            if p >= String.length str then (acc, p)
            else
              let ch = str.[p] in
              if (ch >= '0' && ch <= '9') || ch = '.' then
                get_number (p + 1) (acc ^ String.make 1 ch)
              else
                (acc, p)
          in
          let num_str, next_pos = get_number pos "" in
          (match float_of_string_opt num_str with
           | Some num -> tokenize_helper str next_pos (Number num :: tokens)
           | None -> failwith ("Invalid number: " ^ num_str))
      | _ -> failwith ("Unknown character: " ^ String.make 1 c)
  in
  tokenize_helper input 0 []

(* Parser with precedence climbing *)
type expr =
  | Num of float
  | BinOp of operator * expr * expr

let parse tokens =
  let pos = ref 0 in
  
  let peek () =
    if !pos < List.length tokens then
      List.nth tokens !pos
    else
      EOF
  in
  
  let advance () =
    incr pos
  in
  
  let precedence = function
    | Add | Subtract -> 1
    | Multiply | Divide | Modulo -> 2
    | Power -> 3
  in
  
  let is_right_associative = function
    | Power -> true
    | _ -> false
  in
  
  let rec parse_primary () =
    match peek () with
    | Number n -> advance (); Num n
    | LParen ->
        advance ();
        let expr = parse_expression 0 in
        (match peek () with
         | RParen -> advance (); expr
         | _ -> failwith "Expected ')'")
    | Op Subtract ->
        advance ();
        let operand = parse_primary () in
        (match operand with
         | Num n -> Num (-.n)
         | _ -> failwith "Cannot negate expression")
    | _ -> failwith ("Unexpected token")
  
  and parse_expression min_prec =
    let mut_expr = parse_primary () in
    parse_binary_op mut_expr min_prec
  
  and parse_binary_op left min_prec =
    match peek () with
    | Op op ->
        let prec = precedence op in
        if prec < min_prec then
          left
        else
          let () = advance () in
          let next_min_prec = if is_right_associative op then prec else prec + 1 in
          let right = parse_expression next_min_prec in
          parse_binary_op (BinOp (op, left, right)) min_prec
    | _ -> left
  in
  
  parse_expression 0

(* Evaluate expression *)
let rec evaluate expr =
  match expr with
  | Num n -> n
  | BinOp (op, left, right) ->
      let left_val = evaluate left in
      let right_val = evaluate right in
      (match op with
       | Add -> left_val +. right_val
       | Subtract -> left_val -. right_val
       | Multiply -> left_val *. right_val
       | Divide ->
           if right_val = 0.0 then
             failwith "Division by zero"
           else
             left_val /. right_val
       | Modulo ->
           if right_val = 0.0 then
             failwith "Modulo by zero"
           else
             mod_float left_val right_val
       | Power -> left_val ** right_val)

(* Main calculator function *)
let calculate input =
  try
    let tokens = tokenize input in
    let expr = parse tokens in
    evaluate expr
  with
  | Failure msg -> failwith ("Error: " ^ msg)
  | _ -> failwith "Error: Invalid expression"

