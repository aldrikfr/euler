open Base

let int_from_string s = try Int.of_string s |> Option.some with _ -> None

let valid_core_value n = Option.some_if Range.(from 1 256 |> contain n) n

let cores_available_default_value = 6

let get_cores_to_use () =
  let open Option in
  Sys.getenv "CORES_AVAILABLE"
  >>= int_from_string >>= valid_core_value
  |> value ~default:cores_available_default_value
