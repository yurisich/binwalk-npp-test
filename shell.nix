{ pkgs ? import <nixpkgs> {} }:
let

  commitRev = "34a626458d686f1b58139620a8b2793e9e123bba";

  nixpkgs = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/${commitRev}.tar.gz";
  };

in

pkgs.mkShell {
  nativeBuildInputs = with pkgs.buildPackages; [
    binwalk
    qpdf
  ];
}
