(* SPDX-License-Identifier:  GPL-3.0-or-later *)
open Base

let map_reduce_on_range =
  if Int.(Setting.get_cores_to_use () = 1) then
    Monocore_range.map_reduce_on_range
  else Multicore_range.map_reduce_on_range
