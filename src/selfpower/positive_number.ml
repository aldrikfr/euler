open Base

type t = int

let from_int x =
  let open Result in
  if x < 0 then Error "Positive number only"
  else if x > 999_999_999 then Error "This size of number not supported"
  else return x

let to_int x = x

let map n ~f = f n
