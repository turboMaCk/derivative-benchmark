# Derivative Benchmark

This repository provides reproducible build scripts
for source used in [John Harrop](https://twitter.com/jonharrop)'s article
[Does reference counting really use less memory than tracing garbage collection?](https://flyingfrogblog.blogspot.com/2017/12/does-reference-counting-really-use-less.html)
by utilizing [nix](https://nixos.org) package manager and expression language.
**Note that I have no relation ship with J. Harrop or any other author of implementation used.**
I can't guarantee anything regarding quality of build scripts provided so take it for what it is.

## Limitations

F# and Mathematica implementation mentioned in [2nd blogpost](http://flyingfrogblog.blogspot.com/2017/12/does-reference-counting-really-use-less_26.html)
are not included.

This repository is intended to be compatible only with Linux and MacOS.

At this point it is not possible to build swift version on MacOS via nix.
In order to build Swift version on Mac you have to clone swift code and run it yourself.

## Implementations

In addition to John Harrop's original implementation in Swift and OCaml original implementation was
ported to several different laguages.

| source                                                                                                   | language | author                                     | Tracing GC | nix attribute   | build      | flags       |
|----------------------------------------------------------------------------------------------------------|----------|--------------------------------------------|------------|-----------------|------------|-------------|
| [jdh30/f3d90a65a7abc7c9faf5c0299b002db3](https://gist.github.com/jdh30/f3d90a65a7abc7c9faf5c0299b002db3) | OCaml    | [@jdh30](https://github.com/jdh30)         | yes        | `ocaml`         | `ocamlopt` | `-O3`       |
| [jdh30/e3c9cfe31dc311be20cc2984b3398545](https://gist.github.com/jdh30/e3c9cfe31dc311be20cc2984b3398545) | Swift    | [@jdh30](https://github.com/jdh30)         | no         | `swift` (Linux) | `swiftc`   | `-O`        |
| [tov/af73f345710e937ec39a4dbaca4504fe](https://gist.github.com/tov/af73f345710e937ec39a4dbaca4504fe)     | Rust     | [@tov](https://github.com/tov)             | no         | `rust`          | `rustc`    | `-O`        |
| [TeXitoi/deriv-rs](https://github.com/TeXitoi/deriv-rs)                                                  | Rust     | [@TeXitoi](https://github.com/TeXitoi)     | no         | `rust-opt`      | `cargo`    | `--release` |
| [turboMaCk/deriv-hs](https://github.com/turboMaCk/deriv-hs)                                              | Haskell  | [@turboMaCk](https://github.com/turboMaCk) | yes        | `haskell`       | `ghc`      | `-02`       |

## Usage

Make sure you have [Nix package manager installed](https://nixos.org/nix/) on your Linux or Apple system.

Individual implementations are defined as an attribute in `release.nix` file. Just use nix to compile implementation you wish.

```
$ nix-build release.nix -A ocaml
```

### Swift on MacOS

On MacOS you will need to use system version of Swift compiler. Make sure it's installed on your Mac.

```
$ which swiftc
/usr/bin/swiftc
```

Also you'll need to clone swift implementation using git and compile it from command line:

```
$ git clone https://gist.github.com/e3c9cfe31dc311be20cc2984b3398545.git
$ swiftc -O -o deriv e3c9cfe31dc311be20cc2984b3398545/deriv.swift
```

### Rust-opt on NixOS

Nixos comes by default with outdated version of `rustc` and `cargo`
which is not compatible with optimized rust version.
See [nixpkgs documentation](https://nixos.org/nixpkgs/manual/#using-the-rust-nightlies-overlay)
to use Mozilla overlay.

### Benchmarking using `time`

One of the most simple tools you can use for measurements is plain old `time`.
Nix will create symlink named `result` in the directory which always contains
`bin/deriv`. All implementations expect one command line argument (Int).

```
$ time ./result/bin/deriv 10
```

For more informations you'll need to pass additional flag to `time`:

- GNU (Linux): `$(which time) -v ./results/bin/deriv 10`
- BSD (MacOS): `$(which time) -l ./results/bin/deriv 10`

> Note that you need full path to the time binary in order to be able to pass additional flags.

## Results

TL;DR comparision:

| place | implementation         | User time | Wall Time | Max Memory (kbytes) | Tracing GC |
|-------|------------------------|-----------|-----------|---------------------|------------|
| 1     | Rust-opt (typed arena) | 0.60s     | 0.71s     | 480672              | no         |
| 2     | OCaml                  | 1.51s     | 1.59s     | 432756              | yes        |
| 3     | Haskell                | 1.73s     | 1.84s     | 432596              | yes        |
| 4     | Rust                   | 1.83s     | 2.01s     | 887976              | no         |
| 5     | Swift                  | 6.51s     | 5.82      | 1574552             | no         |

Benchmarking was done on my desktop Ryzen 7 1800x system with 32GB DDR4 2133MHz RAM running NixOS Linux.

### OCaml

```
	Command being timed: "./result/bin/deriv 10"
	User time (seconds): 1.51
	System time (seconds): 0.07
	Percent of CPU this job got: 99%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 0:01.59
	Average shared text size (kbytes): 0
	Average unshared data size (kbytes): 0
	Average stack size (kbytes): 0
	Average total size (kbytes): 0
	Maximum resident set size (kbytes): 432756
	Average resident set size (kbytes): 0
	Major (requiring I/O) page faults: 0
	Minor (reclaiming a frame) page faults: 108169
	Voluntary context switches: 1
	Involuntary context switches: 2
	Swaps: 0
	File system inputs: 0
	File system outputs: 0
	Socket messages sent: 0
	Socket messages received: 0
	Signals delivered: 0
	Page size (bytes): 4096
	Exit status: 0
```

### Swift

```
	Command being timed: "result/bin/deriv 10"
	User time (seconds): 6.51
	System time (seconds): 0.31
	Percent of CPU this job got: 99%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 0:06.82
	Average shared text size (kbytes): 0
	Average unshared data size (kbytes): 0
	Average stack size (kbytes): 0
	Average total size (kbytes): 0
	Maximum resident set size (kbytes): 1574552
	Average resident set size (kbytes): 0
	Major (requiring I/O) page faults: 0
	Minor (reclaiming a frame) page faults: 391662
	Voluntary context switches: 1
	Involuntary context switches: 4
	Swaps: 0
	File system inputs: 0
	File system outputs: 0
	Socket messages sent: 0
	Socket messages received: 0
	Signals delivered: 0
	Page size (bytes): 4096
	Exit status: 0
```

### Rust

```
	Command being timed: "result/bin/deriv 10"
	User time (seconds): 1.83
	System time (seconds): 0.17
	Percent of CPU this job got: 100%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 0:02.01
	Average shared text size (kbytes): 0
	Average unshared data size (kbytes): 0
	Average stack size (kbytes): 0
	Average total size (kbytes): 0
	Maximum resident set size (kbytes): 887976
	Average resident set size (kbytes): 0
	Major (requiring I/O) page faults: 0
	Minor (reclaiming a frame) page faults: 221532
	Voluntary context switches: 1
	Involuntary context switches: 2
	Swaps: 0
	File system inputs: 0
	File system outputs: 0
	Socket messages sent: 0
	Socket messages received: 0
	Signals delivered: 0
	Page size (bytes): 4096
	Exit status: 0
```

### Rust Optimized (typed arena)

*Note that there might be some issues cargo version in nix.
I'm using rust Mizilla's rust overly.*

```
	Command being timed: "./target/release/deriv-rs 10"
	User time (seconds): 0.60
	System time (seconds): 0.10
	Percent of CPU this job got: 100%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 0:00.71
	Average shared text size (kbytes): 0
	Average unshared data size (kbytes): 0
	Average stack size (kbytes): 0
	Average total size (kbytes): 0
	Maximum resident set size (kbytes): 480716
	Average resident set size (kbytes): 0
	Major (requiring I/O) page faults: 0
	Minor (reclaiming a frame) page faults: 119682
	Voluntary context switches: 1
	Involuntary context switches: 0
	Swaps: 0
	File system inputs: 0
	File system outputs: 0
	Socket messages sent: 0
	Socket messages received: 0
	Signals delivered: 0
	Page size (bytes): 4096
	Exit status: 0
```

### Haskell

```
	Command being timed: "./Main 10"
	User time (seconds): 1.73
	System time (seconds): 0.11
	Percent of CPU this job got: 100%
	Elapsed (wall clock) time (h:mm:ss or m:ss): 0:01.84
	Average shared text size (kbytes): 0
	Average unshared data size (kbytes): 0
	Average stack size (kbytes): 0
	Average total size (kbytes): 0
	Maximum resident set size (kbytes): 432596
	Average resident set size (kbytes): 0
	Major (requiring I/O) page faults: 0
	Minor (reclaiming a frame) page faults: 107393
	Voluntary context switches: 1
	Involuntary context switches: 2
	Swaps: 0
	File system inputs: 0
	File system outputs: 0
	Socket messages sent: 0
	Socket messages received: 0
	Signals delivered: 0
	Page size (bytes): 4096
	Exit status: 0
```
