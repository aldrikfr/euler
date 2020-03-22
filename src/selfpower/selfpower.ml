open Base
open Range_processing
open Result

type t = Z.t

let self_power x = Z.pow (Z.of_int x) x

let ( + ) = Z.add

let zero = Z.zero

let sum_self_power ~f:map_reduce_f = function
  | 0 | 1 -> return "1"
  | _ as x ->
      Range.from 1 x
      |> map_reduce_f ~f_map:self_power ~f_reduce:( + ) ~neutral:zero
      |> Z.to_string |> return

let sum_self_power_of_natural ~f:map_reduce_f =
  Positive_number.map ~f:(sum_self_power ~f:map_reduce_f)

(* public part of the code *)
let of_int x =
  x |> Positive_number.from_int
  >>= sum_self_power_of_natural ~f:map_reduce_on_range

let of_string x = x |> Int.of_string |> of_int
