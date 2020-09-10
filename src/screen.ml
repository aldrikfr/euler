open Base
open Stdio
module R = Result

let string_to_stdout m =
begin
  Out_channel.printf "%s\n" m;
  Caml.exit 0
end

let string_to_stderr m =
begin
  Out_channel.eprintf "Error : %s\n" m;
  Caml.exit 1
end

let handle_result r =
  R.map ~f:string_to_stdout r |> R.map_error ~f:string_to_stderr |> ignore
