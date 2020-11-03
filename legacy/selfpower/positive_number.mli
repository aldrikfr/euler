open Base

type t

val from_int : int -> (t, String.t) Result.t

val to_int : t -> int

val map : t -> f:(int -> 'a) -> 'a
