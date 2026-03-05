{ lib, ... }:

/*
  ====[ libjcc ]====
  :: lib

  A collection of functions that I felt like extracting for general use.
*/
rec {
  /*
    mapFiles :: (string -> a) -> path -> [a]

    Equivalent to map, but the mapped functor is applied to the string names
    of all files in provided directory.
    ```
    mapFiles (lib.removeSuffix ".nix") ./hosts;
    ```
  */
  mapFiles = func: dir: map func (builtins.attrNames (builtins.readDir dir));

  /*
    shellsFromDir :: nixpkgs -> path -> attrsOf derivation

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
      # Gather the name of the shells in `dir`
      shellNames = mapFiles (lib.removeSuffix ".nix") dir;
      /*
        mkDevShell :: string -> derivation
        Creates a devShell by reading in the parameters with the specified
        filename (without the suffix) in `dir` and applying `pkgs.mkShell`.
      */
      mkDevShell =
        name:
        lib.pipe name [
          (name: import (dir + "/${name}.nix") { inherit pkgs; })
          pkgs.mkShell
        ];
    in
    lib.genAttrs shellNames mkDevShell;

  /*
    templatesFromDir :: path -> attrs

    Reads in templates from a given directory.
    ```
    {
      templates = templatesFromDir ./templates;
    }
    ```
  */
  templatesFromDir =
    dir:
    let
      templateDirs = mapFiles lib.baseNameOf dir;
      genTemplate = name: {
        path = dir + "/${name}";
        description = if name != "default" then "Flake template for ${name}" else "Default template";
      };
    in
    lib.genAttrs templateDirs genTemplate;

  /*
    mkInvalid :: string -> [attrs]

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
      channelNames = [
        "r"
        "g"
        "b"
      ];

      /*
        parseHex :: string -> int
        Converts a hexadecimal string to an int.
      */
      parseHex = hex: (fromTOML "number = 0x${hex}").number;
      /*
        hexPairOf :: int -> string
        Gets the nth hexadecimal pair from the input string.
      */
      hexPairAt = n: builtins.substring ((n - 1) * 2) 2 hexNoPrefix;
      /*
        parseHexAt :: int -> int
        Composition of parseHex and hexPairAt.
      */
      parseHexAt = n: parseHex (hexPairAt n);

      rgb = lib.pipe (lib.range 1 3) [
        # Get hex pairs as ints
        (map parseHexAt)
        # Create associative mapping ({r,g,b} -> {int,int,int})
        (lib.zipListsWith (name: value: { inherit name value; }) channelNames)
        builtins.listToAttrs
        # Convert to Strings for interpolation
        (builtins.mapAttrs (_: toString))
      ];
    in
    {
      hex = hexNoPrefix;
      rgb = "${rgb.r}, ${rgb.g}, ${rgb.b}";
      ansi = "38;2;${rgb.r};${rgb.g};${rgb.b}";
    };
}
