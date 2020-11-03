open Base

type t = int

let max_supported = 999_999_999

let from_int x =
  let open Result in
  if x < 0 then Error "Positive number only"
  else if x > max_supported then Error "This size of number is not supported"
  else return x

let to_int x = x

let map n ~f = f n
