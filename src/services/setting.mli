(* SPDX-License-Identifier:  GPL-3.0-or-later *)
val max_parallel_cpu_supported : Int.t

val cores_available_default_value : Int.t

val get_cores_to_use : Unit.t -> Int.t
