open Base
open Distributed_range

type t = Z.t

let self_power x = Z.pow (Z.of_int x) x

let ( + ) = Z.add

let zero = Z.zero

type int_kind = Negative | Positive | Zero

let classify n = if n = 0 then Zero else if n > 0 then Positive else Negative

let self_power_on_range x =
  Range.from 1 x
  |> map_reduce_on_range ~f_reduce:( + ) ~f_map:self_power ~neutral:zero
  |> Z.to_string |> Result.return

(* public part of the code *)

let of_int x =
  Result.(
    match classify x with
    | Negative -> Error "Positive number only"
    | Zero -> return "1"
    | Positive -> self_power_on_range x)

let of_string = Fn.compose of_int Int.of_string
