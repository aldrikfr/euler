open Base

type t = int

let from_int x =
  Result.(
    if x < 0 then Error "Integer is negative and can't be transformed to a positive number type"
    else return x
  )

let to_int x = x

let map n ~f = f n
