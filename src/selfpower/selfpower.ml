open Base
open Distributed_range

type t = Z.t

let self_power x = Z.pow (Z.of_int x) x

let ( + ) = Z.add

let zero = Z.zero

let positive_only x = Result.ok_if_true (x >= 0) ~error:"Positive number only"

let is_zero x = x = 0

let self_power_on_range x =
  Range.from 1 x
  |> map_reduce_on_range ~f_reduce:( + ) ~f_map:self_power ~neutral:zero
  |> Z.to_string |> Result.return

(* public part of the code *)

let of_int x =
  Result.(
    positive_only x >>= fun _ ->
    if is_zero x then return "1" else self_power_on_range x)

let of_string = Fn.compose of_int Int.of_string
