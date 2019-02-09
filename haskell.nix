{ stdenv, fetchgit, haskellPackages, ... }:
stdenv.mkDerivation {
  name = "derivate-benchmark-haskell";

  src = fetchgit {
    url = https://github.com/turboMaCk/deriv-hs.git;
    rev = "1fee06523bfdcb01b6ecce8aa3a32dba24d123b9";
    sha256 = "0qr7q6j1bxr1dvws2napk0amlj5k93s26ywd3kj43zvp0yxpk382";
  };

  buildInputs = [ haskellPackages.ghc ];

  buildPhase = ''
    ghc -O2 -o deriv Main.hs
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp deriv $out/bin/deriv
  '';
}
