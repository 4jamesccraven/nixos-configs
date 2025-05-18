{ pkgs, ... }:

with pkgs;
let
  script = stdenvNoCC.mkDerivation {
    name = "export-nvim-script";

    src = ./build_config.tar.gz;

    phases = [
      "unpackPhase"
      "installPhase"
    ];

    unpackPhase = ''
      tar xvf $src
    '';

    installPhase = ''
      mkdir -p $out
      cp build_config.py $out
    '';
  };
in
writers.writePython3Bin "export_nvim" {
  doCheck = false;
} (builtins.readFile "${script}/build_config.py")
