{pkgs ? import <nixpkgs> {} }:
with pkgs;
{
  ocaml = callPackage ./ocaml.nix {};
  rust = callPackage ./rust.nix {};
  rust-opt = callPackage ./rust-opt.nix {};
} // stdenv.lib.optionals stdenv.isLinux {
    swift = callPackage ./swift.nix {};
}
