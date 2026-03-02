{ self, pkgs, ... }:

with pkgs;
let
  formatter = lib.getExe pkgs.nixfmt;
in
runCommandLocal "formatting-check" { } ''
  cd ${self}
  find -type f -iname "*.nix" -exec ${formatter} {} \+
  touch $out
''
