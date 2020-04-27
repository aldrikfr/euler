open Functory.Cores
open Base
module Num = Range.Number

let cores_available_default_value = 6

let int_from_string s = try Int.of_string s |> Option.some with _ -> None

let greater_than_zero n = Option.some_if (n > 0) n

let get_cores_setting () =
  let open Option in
  Sys.getenv "CORES_AVAILABLE"
  >>= int_from_string >>= greater_than_zero
  |> value ~default:cores_available_default_value

let cores_available = get_cores_setting ()

let threshold = 1_000 |> Num.gtz_from_int_exn

let batch_job_number = cores_available * 2 |> Num.gtz_from_int_exn

let () = set_number_of_cores cores_available

let map_reduce_on_range ~f_map ~f_reduce ~neutral r =
  let map_reduce_inside_list acc x = f_reduce acc (f_map x) in
  r
  |> Range.split threshold batch_job_number
  |> map_fold_ac
       ~f:(Range.fold ~f:map_reduce_inside_list neutral)
       ~fold:f_reduce neutral
