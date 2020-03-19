open Base
open Stdio

let handle_result = function
  | Ok s -> Out_channel.printf "%s\n" s
  | Error m ->
      Out_channel.eprintf "Error : %s\n" m;
      Caml.exit 1
