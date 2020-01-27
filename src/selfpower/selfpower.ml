open Base
open Distributed_range

type t = Z.t

let self_power x = Z.pow (Z.of_int x) x

let (+) = Z.add

let zero = Z.zero

let of_int x =
  if x < 1 then Result.fail "Non null positive number only" else
  Range.from 1 x
  |> map_reduce_on_range ~f_reduce:(+) ~f_map:self_power ~neutral:zero
  |> Z.to_string
  |> Result.return

let of_string = Fn.compose of_int Int.of_string
