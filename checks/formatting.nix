{ self, pkgs, ... }:

with pkgs;
let
  formatter = lib.getExe self.formatter.${pkgs.stdenv.hostPlatform.system};
in
runCommandLocal "formatting-check" { } ''
  cd ${self}
  find -type f -iname "*.nix" -exec ${formatter} {} \+
  touch $out
''
