open Base
open Result

let () = Param.get_number () >>= Selfpower.of_int |> Screen.handle_result
