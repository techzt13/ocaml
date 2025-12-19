open Calculator

let print_menu () =
  print_endline "\n=== OCaml Calculator ===";
  print_endline "Supported operators:";
  print_endline "  + : Addition";
  print_endline "  - : Subtraction";
  print_endline "  * : Multiplication";
  print_endline "  / : Division";
  print_endline "  % : Modulo";
  print_endline "  ^ : Power";
  print_endline "  ! : Factorial (postfix, e.g., 5!)";
  print_endline "  ( ) : Parentheses for grouping";
  print_endline "Type 'quit' to exit\n"

let rec main_loop () =
  print_string "Enter expression: ";
  flush stdout;
  let input = read_line () in
  
  if String.equal (String.lowercase_ascii input) "quit" then
    print_endline "Goodbye!"
  else if String.trim input = "" then
    main_loop ()
  else
    match calculate input with
    | result ->
        Printf.printf "Result: %g\n" result;
        main_loop ()
    | exception Failure msg ->
        Printf.printf "%s\n" msg;
        main_loop ()

let () =
  print_menu ();
  main_loop ()
