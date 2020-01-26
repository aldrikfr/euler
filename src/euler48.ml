open Base
open Stdio

let check_param_available () =
  if Array.length (Sys.get_argv ())= 2
  then Result.return 1
  else Result.fail "One parameter only"

let check_is_int s =
  try Result.return (Int.of_string s) with
  | _ -> Result.fail "Parameter is not a numvber"


let () =
  let open Result in
  check_param_available ()
  >>= (fun n -> return (Sys.get_argv () |> fun x -> x.(n)) )
  >>= (Fn.compose return Selfpower.of_string)
  |> function
  | Ok s -> Out_channel.(printf "%s\n" s)
  | Error m -> Out_channel.(eprintf "Erreur:\n%s\n" m )
