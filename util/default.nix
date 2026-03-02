{ lib, ... }:

/*
  ====[ Utils ]====
  :: lib

  A collection of functions that I felt like extracting for general use
*/
rec {
  /*
    mapEntries :: (string -> Any -> Any) -> AttrSet -> [Any]

    Equivalent to map, but the mapped functor takes in key, value pairs.
    Similar to iterating over `dict.items()` in Python.
    ```
    let
      exampleAttr = {
        a = 1;
        b = 2;
      };
    in
    mapEntries (k: v: "${k}${builtins.toString v}") exampleAttr;
    ```
  */
  mapEntries = f: attrs: map (k: f k (attrs.${k})) (builtins.attrNames attrs);

  /*
    mapFiles :: (string -> Any) -> Path -> [Any]

    Equivalent to map, but the mapped functor is applied to the string names
    of all files in provided directory.
    ```
    mapFiles (lib.removeSuffix ".nix") ./hosts;
    ```
  */
  mapFiles = func: dir: map func (builtins.attrNames (builtins.readDir dir));

  /*
    shellsFromDir :: AttrSet (nixpkgs) -> Path -> [AttrSet]

    Returns the value for the `devShell.${system}` attribute of a flake by
    reading AttrSets from each file in `dir` and treating them as the argument
    to `mkShell` (using the provided version of nixpkgs).
    ```
    let
      system = "x86_64-linux";
      pkgs = import <nixpkgs> { inherit system; };
    in
    {
      devShells.${system} = shellsFromDir pkgs ./shells;
    }
    ```
  */
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

  /*
    mkInvalid :: string -> [AttrSet]

    Adds an assertion that guarantees failure so that a NixOS system cannot be used.
    ```
    assertions = mkInvalid "vaal";
    ```
  */
  mkInvalid = hostName: [
    {
      assertion = false;
      message = ''
        ${hostName} has been decommisioned and cannot be built.
      '';
    }
  ];
}
