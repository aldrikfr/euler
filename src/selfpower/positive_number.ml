open Base

type t = int

let from_int x =
  Result.(if x < 0 then Error "Positive number only" else return x)

let to_int x = x

let map n ~f = f n
