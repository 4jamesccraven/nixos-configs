{ lib, ... }:

/*
  ====[ Utils ]====
  :: lib

  A collection of functions that I felt like extracting for general use.
*/
rec {
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

  /*
    parseColor :: string -> colorType

    Takes a hexadecimal colour string with or without the leading #
    and converts it to a colorType module.
  */
  parseColor =
    hex:
    let
      hexNoPrefix = lib.removePrefix "#" hex;
      channels = {
        r = 1;
        g = 2;
        b = 3;
      };

      /*
        hexPairOf :: int -> string
        maps {1,2,3} to the hex associated with {r,g,b}, respectively.
      */
      hexPairOf = n: builtins.substring ((n - 1) * 2) 2 hexNoPrefix;
      /*
        defineAsToml :: string -> int -> string
        takes the name of a channel (in {r,g,b}) and a hex value and converts
        it to an equivalent TOML mapping.
      */
      defineAsTOML = channel: index: "${channel} = 0x${hexPairOf index}";

      # Create the TOML document
      tomlAttrs = lib.mapAttrsToList defineAsTOML channels;
      tomlDoc = lib.concatLines tomlAttrs;
      # Parse and convert ints to strings
      rgb = builtins.mapAttrs (_: toString) (fromTOML tomlDoc);
    in
    {
      hex = hexNoPrefix;
      rgb = "${rgb.r}, ${rgb.g}, ${rgb.b}";
      ansi = "38;2;${rgb.r};${rgb.g};${rgb.b}";
    };
}
