open Base
open Option

let int_from_string s = try some @@ Int.of_string @@ s with _ -> None

let valid_core_value n = some_if Range.(from 1 256 |> contain n) n

let cores_available_default_value = 6

let is_inside_int_length s =
  if String.length s <= Int.(max_value |> to_string |> String.length) then
    Some s
  else None

let get_cores_to_use () =
  Sys.getenv "CORES_AVAILABLE"
  >>= is_inside_int_length >>= int_from_string >>= valid_core_value
  |> value ~default:cores_available_default_value
