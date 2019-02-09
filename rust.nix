{ stdenv, fetchgit, rustc, ... }:
stdenv.mkDerivation {
  name = "derivate-benchmark-rust";

  src = fetchgit {
    url = https://gist.github.com/af73f345710e937ec39a4dbaca4504fe.git;
    rev = "4f7b169622ff154dacb7a69d21c17c55d321edd8";
    sha256 = "1pdjv721z4ccfw45qfkbmwl5h2d0ar4baa4hi43v6avcdnl9a0xr";
  };

  buildInputs = [ rustc ];

  buildPhase = ''
    rustc -O -o deriv deriv.rs
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp deriv $out/bin/deriv
  '';
}
