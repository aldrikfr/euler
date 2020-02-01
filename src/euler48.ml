open Base
open Stdio
open Result

let handle_result = function
  | Ok s -> Out_channel.printf "%s\n" s
  | Error m ->
      Out_channel.eprintf "Error : %s\n" m;
      Caml.exit 1

let () = Param.get_number () >>= Selfpower.of_int |> handle_result
