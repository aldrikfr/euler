
(* SPDX-License-Identifier:  GPL-3.0-or-later *)
open OUnit2

let assert_selfpower expected param =
  assert_equal expected (Selfpower.of_string param)

let selfpower_tests =
  [
    ("with param 1" >:: fun _ctxt -> assert_selfpower "1" "1");
    ("with param 2" >:: fun _ctxt -> assert_selfpower "5" "2");
    ("with big number" >:: fun _ctxt ->
        assert_selfpower "106876212200059554303215024" "20")
  ]

let () =
  run_test_tt_main(
    "Euler 48 testing" >::: selfpower_tests
  )
