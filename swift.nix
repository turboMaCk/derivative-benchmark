{ stdenv, fetchgit, swift
, darwin ? null, ... }:
let
  inherit (darwin.apple_sdk.frameworks) CoreServices ApplicationServices;
in
with stdenv.lib;
stdenv.mkDerivation {
  name = "derivate-benchmark-swift";

  src = fetchgit {
    url = https://gist.github.com/e3c9cfe31dc311be20cc2984b3398545.git;
    rev = "fecec3823d44de98366bad97418087dc417931d3";
    sha256 = "1drh6qk5hcn7nxffmylhjwmq70ybl2qp6jk3cvkxdhq3j5s5397k";
  };

  buildInputs =  optionals stdenv.isDarwin [ CoreServices ApplicationServices ]
    ++ optionals stdenv.isLinux [ swift ];

  buildPhase = ''
    ls -la
    swiftc deriv.swift
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp deriv $out/bin/deriv
  '';
}
