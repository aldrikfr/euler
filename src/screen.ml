open Base
open Stdio
module R = Result

let string_to_stdout =
  Out_channel.printf "%s\n";
  Caml.exit 0

let string_to_stderr m =
  Out_channel.eprintf "Error : %s\n" m;
  Caml.exit 1

let handle_result r =
  R.map ~f:string_to_stdout r |> R.map_error ~f:string_to_stderr |> ignore
