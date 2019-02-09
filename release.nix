{pkgs ? import <nixpkgs> {} }:
with pkgs;
{
  ocaml = callPackage ./ocaml.nix {};
  rust = callPackage ./rust.nix {};
  rust-opt = callPackage ./rust-opt.nix {};
}
