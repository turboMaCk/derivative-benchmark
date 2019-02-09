# Derivative Benchmark

This repository provides reproducible build scripts
for source used in [John Harrop](https://twitter.com/jonharrop)'s article
[Does reference counting really use less memory than tracing garbage collection?](https://flyingfrogblog.blogspot.com/2017/12/does-reference-counting-really-use-less.html)
by utilizing [nix](https://nixos.org) package manager and expression language.
**Note that I have no relation ship with J. Harrop or any other author of implementation used.**
I can't guarantee anything regarding quality of build scripts provided so take it for what it is.

## Motivation

TBA

## Limitations

F# and Mathematica implementation mentioned in [2nd blogpost](http://flyingfrogblog.blogspot.com/2017/12/does-reference-counting-really-use-less_26.html)
are not included.

This repository is intended to be compatible only with Linux and MacOS.

At this point it is not possible to build swift version on MacOS via nix.
In order to build Swift version on Mac you have to clone swift code and run it yourself.

## Implementations

In addition to John Harrop's original implementation in Swift and OCaml original implementation was
ported to several different laguages.

| source                                                                                                   | language         | author                                 | Tracing GC | nix attribute | build      | flags       |
| ======================================================================================================== | ========         | ==================================     | ========== | ============= | ========== | =========== |
| [jdh30/f3d90a65a7abc7c9faf5c0299b002db3](https://gist.github.com/jdh30/f3d90a65a7abc7c9faf5c0299b002db3) | OCaml            | [@jdh30](https://github.com/jdh30)     | yes        | `ocaml`       | `ocamlopt` | `-O3`       |
| [jdh30/e3c9cfe31dc311be20cc2984b3398545](https://gist.github.com/jdh30/e3c9cfe31dc311be20cc2984b3398545) | Swift            | [@jdh30](https://github.com/jdh30)     | no         | ---           | `swiftc`   | `-O`        |
| [tov/af73f345710e937ec39a4dbaca4504fe](https://gist.github.com/tov/af73f345710e937ec39a4dbaca4504fe)     | Rust             | [@tov](https://github.com/tov)         | no         | `rust`        | `rustc`    | `-O`        |
| [TeXitoi/deriv-rs](https://github.com/TeXitoi/deriv-rs)                                                  | Rust (optimized) | [@TeXitoi](https://github.com/TeXitoi) | no         | `rust-opt`    | `cargo`    | `--release` |

## Usage

Make sure you have [Nix package manager installed](https://nixos.org/nix/) on your Linux or Apple system.

TBA

## Results

TBA
