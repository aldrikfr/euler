open Base
open Distributed_range

type t = Z.t

let self_power x = Z.pow (Z.of_int x) x

let (+) = Z.add

let zero = Z.zero

let of_int x =
  Range.from 1 x
  |> map_reduce_on_range ~f_reduce:(+) ~f_map:self_power ~neutral:zero
  |> Z.to_string

let of_string = Fn.compose of_int Int.of_string
