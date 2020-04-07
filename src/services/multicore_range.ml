open Functory.Cores
open Base

let cores_available = 
  match (Sys.getenv "CORES_AVAILABLE" ) with
    | None -> 6
    | Some s -> Int.of_string s

let threshold = 1_000

let batch_job_number = cores_available * 2

let () = set_number_of_cores cores_available

let map_reduce_on_range ~f_map ~f_reduce ~neutral r =
  r
  |> Range.split threshold batch_job_number
  |> map_fold_ac
       ~f:(Range.fold (fun acc x -> f_reduce acc (f_map x)) neutral)
       ~fold:f_reduce neutral
