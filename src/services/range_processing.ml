let map_reduce_on_range =
  if Setting.get_cores_to_use () < 2 then Monocore_range.map_reduce_on_range
  else Multicore_range.map_reduce_on_range
