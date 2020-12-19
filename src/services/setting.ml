(* SPDX-License-Identifier:  GPL-3.0-or-later *)
open Base
open Option

let max_parallel_cpu_supported = 256

let cores_available_default_value = 6

let int_from_string s = try some @@ Int.of_string @@ s with _ -> None

let valid_core_value n =
  some_if Range.(from 1 max_parallel_cpu_supported |> contain n) n

let is_inside_int_length s =
  some_if (String.length s <= Int.(max_value |> to_string |> String.length)) s

let get_cores_to_use () =
  Sys.getenv "CORES_AVAILABLE"
  >>= is_inside_int_length >>= int_from_string >>= valid_core_value
  |> value ~default:cores_available_default_value
