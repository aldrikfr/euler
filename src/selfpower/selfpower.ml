open Base
open Distributed_range
open Result

type t = Z.t

let self_power x = Z.pow (Z.of_int x) x

let ( + ) = Z.add

let zero = Z.zero

let self_power_on_range = function
  | 0 | 1 -> return "1"
  | _ as x ->
      return
        ( Range.from 1 x
        |> map_reduce_on_range ~f_reduce:( + ) ~f_map:self_power ~neutral:zero
        |> Z.to_string )

(* public part of the code *)
let of_int x =
  if x < 0 then Error "Positive number only" else self_power_on_range x

let of_string = Fn.compose of_int Int.of_string
