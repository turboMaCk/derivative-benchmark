{ stdenv, fetchgit, rustPlatform }:
rustPlatform.buildRustPackage {
  name = "derivate-benchmark-rust-opt";

  src = fetchgit {
    url =  https://github.com/TeXitoi/deriv-rs.git;
    rev = "c5724cd11df9683847153e48b0fb6eca785d75b4";
    sha256 = "0gvfggf0l6nag2q1pz7bv7wsdxfih83k8d39dkp5za6a1fjk7spq";
  };

  cargoSha256 = "0d56c5ip61b9fijqfvpgxpcws9ycx9828asl4dx3rcgzhjskz2s5";

  patches = [ ./rust-opt.patch ];
}
