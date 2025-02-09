{ pkgs ? import <nixpkgs> {} }:
let

  commitRev = "34a626458d686f1b58139620a8b2793e9e123bba";

  nixpkgs = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/${commitRev}.tar.gz";
  };

  tex = (pkgs.texliveSmall.withPackages (ps: with ps; [

  ]));

in

pkgs.mkShell {
  nativeBuildInputs = with pkgs.buildPackages; [
    gnumake
    binwalk
    qpdf
    tex
  ];
}
