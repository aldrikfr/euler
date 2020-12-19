(* SPDX-License-Identifier:  GPL-3.0-or-later *)
let map_reduce_on_range ~f_map ~f_reduce ~neutral r =
  Range.fold ~f:(fun acc x -> f_reduce acc (f_map x)) neutral r
