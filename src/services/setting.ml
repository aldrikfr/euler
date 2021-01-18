(* SPDX-License-Identifier:  GPL-3.0-or-later *)
open Base
open Option

let max_parallel_cpu_supported = 256

let cores_available_default_value = 6

let max_int_string_length = Int.to_string max_parallel_cpu_supported |> String.length

let int_from_string s () = Int.of_string s

let is_core_value_valid n = Range.(from 1 max_parallel_cpu_supported |> contain n)

let is_inside_int_length s = String.length s <= max_int_string_length

let get_cores_to_use () =
  Sys.getenv "CORES_AVAILABLE"
  |> filter ~f:is_inside_int_length
  >>= Fn.compose try_with int_from_string
  |> filter ~f:is_core_value_valid
  |> value ~default:cores_available_default_value
