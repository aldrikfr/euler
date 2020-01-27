(* SPDX-License-Identifier:  GPL-3.0-or-later *)
open OUnit2
open Base

let result_printer = Result.(function Ok s -> s | Error m -> m)

let assert_selfpower expected param =
  assert_equal
    ~cmp:(Result.equal String.equal String.equal)
    ~printer:result_printer expected
    (Selfpower.of_string param)

let selfpower_tests =
  [
    ("with param 1" >:: fun _ctxt -> assert_selfpower Result.(return "1") "1");
    ("with param 2" >:: fun _ctxt -> assert_selfpower Result.(return "5") "2");
    ( "with param -2" >:: fun _ctxt ->
      assert_selfpower Result.(fail "Positive number only") "-2" );
    ("with param 0" >:: fun _ctxt -> assert_selfpower Result.(return "1") "0");
    ( "with big number" >:: fun _ctxt ->
      assert_selfpower Result.(return "106876212200059554303215024") "20" );
    ( "equivalence of_int and of_string" >:: fun _ctxt ->
      assert_equal (Selfpower.of_int 50) (Selfpower.of_string "50") );
  ]

let () = run_test_tt_main ("Euler 48 testing" >::: selfpower_tests)
