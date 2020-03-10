open Base
open Distributed_range
open Result

type t = Z.t

let self_power x = Z.pow (Z.of_int x) x

let ( + ) = Z.add

let zero = Z.zero

let sum_self_power = function
  | 0 | 1 -> return "1"
  | _ as x ->
      Range.from 1 x
      |> map_reduce_on_range ~f_reduce:( + ) ~f_map:self_power ~neutral:zero
      |> Z.to_string |> return

let sum_self_power_of_natural = Positive_number.map ~f:sum_self_power

(* public part of the code *)
let of_int x = x |> Positive_number.from_int >>= sum_self_power_of_natural

let of_string = Fn.compose of_int Int.of_string
