open Base
include Container.Summable

val of_string : String.t -> (String.t, String.t) Result.t

val of_int : Int.t ->  (String.t, String.t) Result.t
