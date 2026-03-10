{ self, pkgs, ... }:

with pkgs;
let
  formatter = lib.getExe self.formatter.${pkgs.stdenv.hostPlatform.system};
in
runCommandLocal "formatting-check" { } ''
  cd ${self}
  ${formatter} --ci
  touch $out
''
