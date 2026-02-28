{ lib, ... }:

rec {
  # Equivalent to map, but the mapped functor takes in key, value pairs.
  # Similar to iterating over `dict.items()` in Python.
  # mapEntries :: (string -> Any -> Any) -> AttrSet -> [Any]
  mapEntries = f: attrs: map (k: f k (attrs.${k})) (builtins.attrNames attrs);

  # Equivalent to map, but the mapped functor is applied to the string names
  # of all files in provided directory.
  # mapFiles :: (string -> Any) -> Path -> [Any]
  mapFiles = func: dir: map func (builtins.attrNames (builtins.readDir dir));

  # Returns the value for the `devShell.${system}` attribute of a flake by
  # reading AttrSets from each file in `dir` and treating them as the argument
  # to `mkShell` (using the provided version of nixpkgs).
  # shellsFromDir :: AttrSet (nixpkgs) -> Path -> [AttrSet]
  shellsFromDir =
    pkgs: dir:
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

  mkInvalid = hostName: [
    {
      assertion = false;
      message = ''
        ${hostName} has been decommisioned and cannot be built.
      '';
    }
  ];
}
