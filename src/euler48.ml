let () =
  Sys.argv.(1)
  |> Selfpower.of_string
  |> print_string
