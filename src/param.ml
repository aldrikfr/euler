open Base
open Result
open Stdio

let ( let* ) r f = bind r ~f

let argv = Sys.get_argv ()

let get_idx_if_available () =
  match Array.length argv with
  | 2 -> return 1
  | 1 -> fail "A parameter is needed"
  | _ -> fail "Only one parameter is needed"

let int_of_string s =
  try return @@ Int.of_string @@ s
  with Failure _ -> fail "Input can't be converted to a number"

let get x =
  let* argument =
    try return argv.(x)
    with Invalid_argument _ ->
      fail ("Internal bug inside get_param, index : " ^ Int.to_string x)
  in
  if String.equal argument "--" then
    In_channel.(input_line stdin)
    |> of_option ~error:"problem reading stdin"
  else return argument

let get_number () = get_idx_if_available () >>= get >>= int_of_string
