{ stdenv, fetchgit, ocaml, ... }:
stdenv.mkDerivation {
  name = "derivate-benchmark-ocaml";

  src = fetchgit {
    url = https://gist.github.com/f3d90a65a7abc7c9faf5c0299b002db3.git;
    rev = "dfe1745fc1eabfc126398e48e899d3a385a18f61";
    sha256 = "1mq28xblhvx1jnh9w0zb6g3d798vzdxw7j2n26534grvpzdgdkjx";
  };

  buildInputs = [ ocaml ];

  buildPhase = ''
    ocamlopt -O3 -o deriv deriv.ml
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp deriv $out/bin/deriv
  '';
}
