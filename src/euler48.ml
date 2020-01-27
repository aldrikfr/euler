open Base
open Stdio

let get_index () =
  let open Result in
  match Array.length (Sys.get_argv ()) with
  | 1 -> fail "A parameter is needed"
  | 2 -> return 1
  | _ -> fail "Only one parameter is needed"

let int_of_string s =
  try (Result.return (Int.of_string s)) with
  | Failure _ -> Result.fail "Parameter is not a number"

let get_param = Array.get (Sys.get_argv ())

let () =
  let open Result in
  get_index ()
  >>| get_param
  >>= int_of_string
  >>| Selfpower.of_int
  |> function
    | Ok s -> Out_channel.(printf "%s\n" s)
    | Error m -> Out_channel.(eprintf "Error : %s\n" m )
