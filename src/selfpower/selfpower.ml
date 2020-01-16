open Base
open Distributed_range

let f_map x = Z.pow (Z.of_int x) x

let f_reduce = Z.add

let neutral = Z.zero

let of_int x =
  Range.from 1 x
  |> map_reduce_on_range ~f_reduce ~f_map ~neutral
  |> Z.to_string

let of_string = Fn.compose of_int Int.of_string
