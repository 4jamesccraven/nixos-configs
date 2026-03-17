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
    parseColor :: string -> colourType

    Takes a hexadecimal colour string with or without the leading #
    and converts it to a colourType module.
  */
  parseColour =
    hex:
    let
      hexNoPrefix = lib.removePrefix "#" hex;
      channelNames = [
        "r"
        "g"
        "b"
      ];
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
