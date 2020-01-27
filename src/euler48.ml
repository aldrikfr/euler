open Base
open Stdio
open Result

let handle_result = function
| Ok s -> Out_channel.printf "%s\n" s
| Error m ->
  begin
    Out_channel.eprintf "Error : %s\n" m ;
    Caml.exit 1
  end

let () =
  Param.get_user_param ()
  >>= Selfpower.of_int
  |> handle_result
