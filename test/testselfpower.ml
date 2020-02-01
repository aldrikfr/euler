(* SPDX-License-Identifier:  GPL-3.0-or-later *)
open OUnit2
open Base

type t = { name : String.t; expected : String.t; parameter : String.t }

let result_printer = Result.(function Ok s -> s | Error m -> m)

let assert_selfpower ctxt expected param =
  assert_equal ~ctxt
    ~cmp:(Result.equal String.equal String.equal)
    ~printer:result_printer expected
    (Selfpower.of_string param)

let test_self_power { name; expected; parameter } =
  name >:: fun ctxt -> assert_selfpower ctxt Result.(return expected) parameter

let selfpower_tests =
  [
    { name = "with param 0"; expected = "1"; parameter = "0" };
    { name = "with param 1"; expected = "1"; parameter = "1" };
    { name = "with param 2"; expected = "5"; parameter = "2" };
    {
      name = "with big number";
      expected = "106876212200059554303215024";
      parameter = "20";
    };
  ]
  |> List.map ~f:test_self_power

let regression_tests =
  [
    ( "with param -2" >:: fun ctxt ->
      assert_selfpower ctxt Result.(fail "Positive number only") "-2" );
    ( "equivalence of_int and of_string" >:: fun ctxt ->
      assert_selfpower ctxt (Selfpower.of_int 50) "50" );
  ]

let suite =
  test_list
    [
      "unit testing" >::: selfpower_tests;
      "regression testing" >::: regression_tests;
    ]

let () = run_test_tt_main suite
