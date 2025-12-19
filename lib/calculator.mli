(** Calculator library for evaluating mathematical expressions *)

type operator = Add | Subtract | Multiply | Divide | Modulo | Power | Factorial

type token =
  | Number of float
  | Op of operator
  | LParen
  | RParen
  | EOF

type expr =
  | Num of float
  | BinOp of operator * expr * expr
  | UnaryOp of operator * expr

(** Tokenize a mathematical expression string *)
val tokenize : string -> token list

(** Parse a list of tokens into an expression tree *)
val parse : token list -> expr

(** Evaluate an expression tree *)
val evaluate : expr -> float

(** Main function to calculate the result of a mathematical expression *)
val calculate : string -> float
