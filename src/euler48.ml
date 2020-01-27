open Base
open Stdio
open Result

let get_index () =
  match Array.length @@ Sys.get_argv @@ () with
  | 2 -> return 1
  | 1 -> fail "A parameter is needed"
  | _ -> fail "Only one parameter is needed"

let int_of_string s =
  try return @@ Int.of_string @@ s with
  | Failure _ -> fail "Parameter is not a number"

let get_param x =
  try return @@ (Array.get @@ Sys.get_argv @@ () ) @@ x with
  | Invalid_argument _ ->
    fail ("Internal bug inside get_param, index : " ^ (Int.to_string x))

let handle_result =
  let open Out_channel in
    function
      | Ok s -> printf "%s\n" s
      | Error m ->
        begin
          eprintf "Error : %s\n" m ;
          Caml.exit 1
        end

let () =
  get_index ()
  >>= get_param
  >>= int_of_string
  >>= Selfpower.of_int
  |> handle_result
