(lang dune 3.17)
(name rgb_matrix)

(generate_opam_files true)

(package
 (name rgb_matrix)
 (synopsis "OCaml bindings for rpi-rgb-led-matrix")
 (description "OCaml bindings for the Raspberry Pi RGB LED matrix library")
 (depends
  (ocaml (>= 4.13.0))
  core
  core_unix
  ppx_jane))
