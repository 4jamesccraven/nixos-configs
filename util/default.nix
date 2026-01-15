{ pkgs, lib, ... }:

rec {
  # mapEntries :: (string -> Any -> Any) -> AttrSet -> [Any]
  mapEntries = f: attrs: map (k: f k (attrs.${k})) (builtins.attrNames attrs);

  # mapFiles :: (string -> Any) -> Path -> [Any]
  mapFiles = func: dir: map func (builtins.attrNames (builtins.readDir dir));

  # shellsFromDir :: Path -> [AttrSet]
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
