open Functory.Cores

let cores_available = 12

let threshold = 200

let () = set_number_of_cores cores_available

let map_reduce_on_range ~f_map ~f_reduce ~neutral r =
  Range.split threshold (cores_available * 2) r
  |> map_fold_ac
       ~f:(Range.fold (fun acc x -> f_reduce acc (f_map x)) neutral)
       ~fold:f_reduce neutral
