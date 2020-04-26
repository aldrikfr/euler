val map_reduce_on_range :
  f_map:(int -> 'a) -> f_reduce:('a -> 'a -> 'a) -> neutral:'a -> Range.t -> 'a
