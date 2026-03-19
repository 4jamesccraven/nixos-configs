{ lib, ... }:

/*
  ====[ lib/colour ]====
  :: lib

  Functions for working with colours.
*/
rec {
  /*
    parseHex :: string -> int

    Converts a hexadecimal string to an int.
  */
  parseHex = hex: (fromTOML "number = 0x${hex}").number;

  /*
    parseRGBString :: string -> { r :: int; g :: int; b :: int; }

    Parses a string of form "R, G, B" into Attrs.
    ```
    nix-repl> parseRGBString "255, 0, 135"
    {
      r = 255;
      g = 0;
      b = 135;
    }
    ```
  */
  parseRGBString =
    rgb:
    lib.pipe rgb [
      (lib.splitString ", ")
      (map lib.toInt)
      mapRGBList
    ];

  /*
    parseRGBList :: [int | string] -> { r :: int | string; g :: int | string; g :: int | string; }

    Takes a list of integers or strings and associates them (in order) with the
    colour values r, g, and b.
  */
  mapRGBList =
    rgb:
    let
      channels = [
        "r"
        "g"
        "b"
      ];
    in
    lib.pipe rgb [
      (lib.zipListsWith (name: value: { inherit name value; }) channels)
      builtins.listToAttrs
    ];

  /*
    parseColor :: string -> colourType

    Takes a hexadecimal colour string with or without the leading #
    and converts it to a colourType module.
  */
  parseColour =
    hex:
    let
      hexNoPrefix = lib.removePrefix "#" hex;
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
        mapRGBList
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
