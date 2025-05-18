{ pkgs, lib, ... }:

rec {
  mapFiles = func: dir: map func (builtins.attrNames (builtins.readDir dir));

  shellsFromDir =
    dir:
    let
      shells = builtins.listToAttrs (
        mapFiles (
          name:
          let
            params = (import (dir + "/${name}") { inherit pkgs; });
            shell = pkgs.mkShell params;
          in
          {
            name = lib.removeSuffix ".nix" name;
            value = shell;
          }
        ) dir
      );
    in
    shells;
}
