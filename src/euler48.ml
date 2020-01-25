open Base

let () =
  assert ((Array.length Sys.argv) = 2);
  Sys.argv.(1)
  |> Selfpower.of_string
  |> print_string
  |> print_newline
