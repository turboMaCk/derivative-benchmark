{pkgs ? import <nixpkgs> {} }:
with pkgs;
{
  ocaml = callPackage ./ocaml.nix {};
  rust = callPackage ./rust.nix {};
  rust-opt = callPackage ./rust-opt.nix {};
  haskell = callPackage ./haskell.nix {};
  swift = callPackage ./swift.nix {};
}
