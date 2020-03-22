open Base
open Result

let argv = Sys.get_argv ()

let get_idx_if_available () =
  match Array.length argv with
  | 2 -> return 1
  | 1 -> fail "A parameter is needed"
  | _ -> fail "Only one parameter is needed"

let int_of_string s =
  try return @@ Int.of_string @@ s
  with Failure _ -> fail "Parameter is not a number"

let get x =
  try return (Array.get argv x)
  with Invalid_argument _ ->
    fail ("Internal bug inside get_param, index : " ^ Int.to_string x)

let get_number () = get_idx_if_available () >>= get >>= int_of_string
