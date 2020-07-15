open Functory.Cores
open Base
module Num = Range.Number
module Mono = Monocore_range

let cores_available = Setting.get_cores_to_use ()

let threshold = 1_000 |> Num.gtz_from_int_exn

let batch_job_number = cores_available * 2 |> Num.gtz_from_int_exn

let () = set_number_of_cores cores_available

let map_reduce_on_range ~f_map ~f_reduce ~neutral r =
  r
  |> Range.split threshold batch_job_number
  |> map_fold_ac
       ~f:(Mono.map_reduce_on_range ~f_map ~f_reduce ~neutral)
       ~fold:f_reduce neutral
