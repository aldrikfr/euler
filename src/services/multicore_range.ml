open Functory.Cores
open Base
module Mono = Monocore_range

let gtz = Range.Number.gtz_from_int_exn

let cores_available = Setting.get_cores_to_use ()

let threshold = gtz 1_000

let batch_job_number = cores_available * 3 |> gtz

let () = set_number_of_cores cores_available

let map_reduce_on_range ~f_map ~f_reduce ~neutral r =
  r
  |> Range.split threshold batch_job_number
  |> map_fold_ac
       ~f:(Mono.map_reduce_on_range ~f_map ~f_reduce ~neutral)
       ~fold:f_reduce neutral
