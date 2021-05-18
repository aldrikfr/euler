(* SPDX-License-Identifier:  GPL-3.0-or-later *)
open Base
open Result
open Stdio

let ( let* ) r f = bind r ~f

let argv = Sys.get_argv ()

let apply_on_unique_parameter ~f () =
  match Array.length argv with
  | 2 ->
      f 1
  | 1 ->
      fail "A parameter is needed"
  | _ ->
      fail "Only one parameter is needed"


let int_of_string s =
  try return @@ Int.of_string @@ s with
  | Failure _ ->
      fail "Input can't be converted to a number"


let string_from_user x =
  let* argument =
    try return argv.(x) with
    | Invalid_argument _ ->
        fail ("Internal bug inside Param.get, index : " ^ Int.to_string x)
  in
  if String.(argument = "--")
  then In_channel.(input_line stdin) |> of_option ~error:"problem reading stdin"
  else return argument


let get_number () =
  apply_on_unique_parameter ~f:string_from_user () >>= int_of_string
