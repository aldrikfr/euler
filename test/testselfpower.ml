
(* SPDX-License-Identifier:  GPL-3.0-or-later *)
open OUnit2


let selfpower_tests =
  [
    ("intialization" >:: fun _ctxt ->
        assert_bool "always true" true
    )
  ]

let () =
  run_test_tt_main(
    "Euler 48 testing" >::: selfpower_tests
  )
