open Base
open Functory.Cores

let cores_available = 12

let () = set_number_of_cores cores_available

let power_itself x = Z.pow (Z.of_int x) x

let map_reduce_on_range ~f_map ~f_reduce ~neutral r =
  Range.split 200 (cores_available * 2) r
  |> map_fold_ac
    ~f:(Range.fold (fun acc x -> (f_reduce acc (f_map x))) neutral)
    ~fold:(f_reduce)
    neutral

let of_int x =
  Range.from 1 x
  |> map_reduce_on_range ~f_reduce:Z.add ~f_map:power_itself ~neutral:Z.zero
  |> Z.to_string

let of_string = Fn.compose of_int Int.of_string
