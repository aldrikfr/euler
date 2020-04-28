let map_reduce_on_range ~f_map ~f_reduce ~neutral =
  Range.fold (fun acc x -> f_reduce acc (f_map x)) neutral
