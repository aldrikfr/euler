open Base
open Functory.Cores

let cores_available = 12

let () = set_number_of_cores cores_available


let sum_and_power acc x = Z.add acc ( Z.pow  (Z.of_int x)  x )

let of_string x =
  let open Range in
  x
  |> Int.of_string
  |> from 1
  |> split 1000 (cores_available * 2)
  |> map_fold_ac
    ~f:(fold sum_and_power Z.zero)
    ~fold:(Z.add)
    Z.zero
  |> Z.to_string
