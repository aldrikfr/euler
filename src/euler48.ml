open Base

let () =
  assert ((Array.length Sys.arg) = 1);
  Sys.argv.(1)
  |> Selfpower.of_string
  |> print_string
  |> print_newline
