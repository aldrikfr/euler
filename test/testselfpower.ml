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
  ]
  |> List.map ~f:test_self_power

let regression_tests =
  [
    ( "with param -2" >:: fun ctxt ->
      assert_selfpower ctxt Result.(fail "Positive number only") "-2" );
    ( "equivalence of_int and of_string" >:: fun ctxt ->
      assert_selfpower ctxt (Selfpower.of_int 10) "10" );
    {
      name = "with big number";
      expected =
        "667416034701924785765596204948166693522547271446669864569977567455934029999699179849510340328450429002366965072251905882885496059758789109837606138151969711382328518854841164536790682216103482558262850219420997897105814448476236951750402229947138222669163402276323545663384886501893587295802842005222257480715468884208711797302151062301041717953074021114243904798818115511634245990868292820541848858173911781743232809554757109084924980882334551433920005586126307043512075078468630370431392395139539782268206633967100110747212517888269695161647755086854755348911194246728973593213427748958991161324501639529953280955413866420962553599350789319986816188455581643060746139438129178031482071771610377233503092310904659678867191142407396633076387388349889260721554751107061650679699017182765156251971138237199369385704759841124067916935197797421569292524071063285559269406593935913742454129050392709365005031005306769272466256622304209822379122729769054102402623406330783380576228899342800757894340252445111519480022027866884920434415463404972180";
      parameter = "400";
    }
    |> test_self_power;
    ( "with param too big" >:: fun ctxt ->
      assert_selfpower ctxt
        Result.(fail "This size of number is not supported")
        "1_000_000_000" );
  ]

let suite =
  test_list
    [
      "unit testing" >::: selfpower_tests;
      "regression testing" >::: regression_tests;
    ]

let () = run_test_tt_main suite
