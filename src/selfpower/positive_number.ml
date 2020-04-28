open Base

type t = int

let from_int x =
  let open Result in
  if x < 0 then Error "Positive number only"
  else if x > 100_000_000 then
    Error "Too big number for actual multi-precision library"
  else return x

let to_int x = x

let map n ~f = f n
