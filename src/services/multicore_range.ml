open Functory.Cores
open Base

let cores_available =
  match (Sys.getenv "CORES_AVAILABLE" ) with
    | None -> 6
    | Some s -> Int.of_string s |> abs

let threshold = 1_000 |> Range.Number.gtz_from_int_exn

let batch_job_number =
  cores_available * 2
  |> Range.Number.gtz_from_int_exn

let () = set_number_of_cores cores_available

let map_reduce_on_range ~f_map ~f_reduce ~neutral r =
  r
  |> Range.split threshold batch_job_number
  |> map_fold_ac
       ~f:(Range.fold ~f:(fun acc x -> f_reduce acc (f_map x)) neutral)
       ~fold:f_reduce neutral
