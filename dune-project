(lang dune 1.10)
(name euler)
(source (github aldrikfr/euler))
(license ISC)
(authors "Aldrik KLEBER")
(maintainers "contact@aldrik.net")
(generate_opam_files true)

(package
 (name euler)
 (synopsis "Solve puzzle euler 48.")
 (description "Solve puzzle 48 using arbitrary size number and parallel computing.")
 (depends
  (zarith (> 1.9))
  (range (> 1.8))
  (functory  (>= 0.6))
  (base (>= 0.13 ))
  (ounit :with-test)
  ))
