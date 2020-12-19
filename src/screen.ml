(* SPDX-License-Identifier:  GPL-3.0-or-later *)
open Base
open Stdio
module R = Result

let string_to_stdout m =
  Out_channel.printf "%s\n" m;
  Caml.exit 0

let string_to_stderr m =
  Out_channel.eprintf "Error : %s\n" m;
  Caml.exit 1

let handle_result r =
  R.map ~f:string_to_stdout r |> R.map_error ~f:string_to_stderr |> ignore
